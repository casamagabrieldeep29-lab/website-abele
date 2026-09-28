"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";

export async function approvePaymentRequest(requestId: string, userId: string) {
  const { user } = await requireAdmin();
  const admin = createAdminClient();

  await admin
    .from("payment_requests")
    .update({ status: "approved", reviewed_at: new Date().toISOString(), reviewed_by: user.id })
    .eq("id", requestId);
  await admin.from("profiles").update({ plan: "subscriber" }).eq("id", userId);

  revalidatePath("/admin/payments");
}

export async function rejectPaymentRequest(requestId: string) {
  const { user } = await requireAdmin();
  const admin = createAdminClient();

  await admin
    .from("payment_requests")
    .update({ status: "rejected", reviewed_at: new Date().toISOString(), reviewed_by: user.id })
    .eq("id", requestId);

  revalidatePath("/admin/payments");
}

/**
 * For an auto-approved request that turns out to be fake on manual
 * spot-check — the safety net for /upgrade's "auto-approve when the
 * receipt checks out" path (Gabriel's explicit request, 2026-09-28).
 * Resets trial_started_at to now, same reasoning as downgradeToTrial in
 * ../actions.ts: the trial clock starts fresh from this specific demotion,
 * not from some unrelated past timestamp.
 */
export async function revokeAutoApproval(requestId: string, userId: string) {
  const { user } = await requireAdmin();
  const admin = createAdminClient();

  await admin
    .from("payment_requests")
    .update({
      status: "rejected",
      admin_note: "Revoked after manual review",
      reviewed_at: new Date().toISOString(),
      reviewed_by: user.id,
    })
    .eq("id", requestId);
  await admin
    .from("profiles")
    .update({ plan: "trial", trial_started_at: new Date().toISOString() })
    .eq("id", userId);

  revalidatePath("/admin/payments");
}
