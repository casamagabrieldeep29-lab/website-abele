"use server";

import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";
import { createAdminClient } from "@/lib/supabase/admin";
import { verifyReceipt } from "@/lib/receipt-verification";
import { UPGRADE_PRICE_PHP, type PaymentMethodKey } from "@/lib/payment-methods";
import { checkRateLimit } from "@/lib/rate-limit";
import { logError } from "@/lib/log-error";

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];

// Shared by both /upgrade and signup's own payment step — keyed by user id
// since a session already exists by this point either way. Generous enough
// for a few "wrong reference number" retries, tight enough to stop someone
// scripting fake submissions against the AI verifier (flagged as a
// public-launch blocker, 2026-09-28).
const PAYMENT_SUBMIT_LIMIT = 8;
const PAYMENT_SUBMIT_WINDOW_SECONDS = 60 * 60;

export type SubmitPaymentResult =
  | { ok: true; autoApproved: boolean }
  | { ok: false; error: "missing-fields" | "submit-failed" | "rate-limited" }
  | null;

/**
 * Deliberately returns a result instead of redirect()-ing on success/error —
 * the actual verification here is fast, but Gabriel's explicit "autoapproval
 * shouldnt be flash like 1 second. it should take 20 seconds to 1 minutes"
 * (2026-09-28) means the CALLER (upgrade-form.tsx / signup-form.tsx) holds
 * this result behind a client-side delay + spinner before navigating,
 * rather than the user seeing an instant "approved" that looks unchecked.
 * That delay has to live client-side, not as a server-side sleep here —
 * a serverless function held open for up to a minute risks the platform's
 * own execution timeout killing the request mid-way, which would be a much
 * worse failure than "approval felt fast." Still takes (_prev, formData)
 * so it can be driven by useActionState on both call sites.
 */
export async function submitPaymentRequest(_prev: SubmitPaymentResult, formData: FormData): Promise<SubmitPaymentResult> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const allowed = await checkRateLimit(`payment:${user.id}`, PAYMENT_SUBMIT_LIMIT, PAYMENT_SUBMIT_WINDOW_SECONDS);
  if (!allowed) {
    return { ok: false, error: "rate-limited" };
  }

  const method = String(formData.get("method") ?? "");
  const referenceNumber = String(formData.get("referenceNumber") ?? "").trim();
  const payerName = String(formData.get("payerName") ?? "").trim() || null;
  const receipt = formData.get("receipt");

  if (!VALID_METHODS.includes(method as PaymentMethodKey) || !referenceNumber) {
    return { ok: false, error: "missing-fields" };
  }

  // A receipt is required (Gabriel's explicit "all must pay. and upload
  // their reference. and the screenshot of receipt", 2026-09-28) — no more
  // "submit without a receipt, wait for manual review" path.
  if (!(receipt instanceof File) || receipt.size === 0) {
    return { ok: false, error: "missing-fields" };
  }

  let receiptPath: string | null = null;
  let autoApproved = false;
  let adminNote: string | null = null;

  {
    const buffer = Buffer.from(await receipt.arrayBuffer());
    const ext = receipt.name.split(".").pop() || "jpg";
    const path = `${user.id}/${Date.now()}.${ext}`;
    const mimeType = receipt.type || "image/jpeg";

    const { error: uploadError } = await supabase.storage
      .from("payment-receipts")
      .upload(path, buffer, { contentType: mimeType });

    if (!uploadError) {
      receiptPath = path;
      const verification = await verifyReceipt(buffer.toString("base64"), mimeType, referenceNumber);
      autoApproved = verification.verified;
      adminNote = verification.reason;
    } else {
      adminNote = `Receipt upload failed: ${uploadError.message}`;
      await logError("submitPaymentRequest.receiptUpload", uploadError);
    }
  }

  const { data: inserted, error: insertError } = await supabase
    .from("payment_requests")
    .insert({
      user_id: user.id,
      method,
      reference_number: referenceNumber,
      payer_name: payerName,
      amount_php: UPGRADE_PRICE_PHP,
      status: autoApproved ? "approved" : "pending",
      receipt_path: receiptPath,
      auto_approved: autoApproved,
      admin_note: adminNote,
      reviewed_at: autoApproved ? new Date().toISOString() : null,
    })
    .select("id")
    .single();

  if (insertError || !inserted) {
    await logError("submitPaymentRequest.insert", insertError ?? "insert returned no row");
    return { ok: false, error: "submit-failed" };
  }

  if (autoApproved) {
    // A regular user's RLS deliberately doesn't allow writing their own
    // profiles.plan (admin-only everywhere else in this codebase) — the
    // service-role client is scoped here to exactly this user's own
    // verified session id, never anything caller-supplied.
    const admin = createAdminClient();
    await admin.from("profiles").update({ plan: "subscriber" }).eq("id", user.id);
  }

  revalidatePath("/upgrade");
  return { ok: true, autoApproved };
}
