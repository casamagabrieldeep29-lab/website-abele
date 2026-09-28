"use server";

import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";
import { createAdminClient } from "@/lib/supabase/admin";
import { verifyReceipt } from "@/lib/receipt-verification";
import { UPGRADE_PRICE_PHP, type PaymentMethodKey } from "@/lib/payment-methods";

const VALID_METHODS: PaymentMethodKey[] = ["gcash", "maya", "landbank"];

export async function submitPaymentRequest(formData: FormData) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const method = String(formData.get("method") ?? "");
  const referenceNumber = String(formData.get("referenceNumber") ?? "").trim();
  const payerName = String(formData.get("payerName") ?? "").trim() || null;
  const receipt = formData.get("receipt");

  if (!VALID_METHODS.includes(method as PaymentMethodKey) || !referenceNumber) {
    redirect("/upgrade?error=missing-fields");
  }

  // A receipt is required (Gabriel's explicit "all must pay. and upload
  // their reference. and the screenshot of receipt", 2026-09-28) — no more
  // "submit without a receipt, wait for manual review" path.
  if (!(receipt instanceof File) || receipt.size === 0) {
    redirect("/upgrade?error=missing-fields");
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
    redirect("/upgrade?error=submit-failed");
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
  redirect(autoApproved ? "/upgrade?approved=1" : "/upgrade?submitted=1");
}
