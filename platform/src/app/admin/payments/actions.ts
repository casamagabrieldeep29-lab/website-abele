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
 * Demotes back to "pending" (gated unconditionally at /upgrade until a real
 * payment is approved), not "trial" — there's no more free trial to fall
 * back to (2026-09-28's "all must pay" policy), so a revoked fake payment
 * must not hand out one by accident.
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
  await admin.from("profiles").update({ plan: "pending" }).eq("id", userId);

  revalidatePath("/admin/payments");
}

/**
 * The other outcome of a spot-check — "I looked, this one's legit." Only
 * removes the request from the "Recently auto-approved" review list
 * (patch 044_payment_spot_check.sql's spot_checked_at, filtered out of that
 * query) — deliberately does NOT touch payment_requests.status or
 * profiles.plan, since the student is already correctly a subscriber and
 * this is just dismissing it from the queue (Gabriel's explicit "the
 * autoapproved account will be deleted in the list. but not in the users
 * subscriber", 2026-09-28).
 */
export async function confirmAutoApproval(requestId: string) {
  await requireAdmin();
  const admin = createAdminClient();

  await admin.from("payment_requests").update({ spot_checked_at: new Date().toISOString() }).eq("id", requestId);

  revalidatePath("/admin/payments");
}
