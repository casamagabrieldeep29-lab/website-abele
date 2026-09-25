"use server";

import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";
import { getSiteUrl } from "@/lib/site-url";

export type InviteResult = { ok: true; email: string } | { ok: false; message: string };

/**
 * Permanently removes a reviewee's account (Supabase Auth user + their
 * `profiles` row, which cascades to their study data) — the admin-side
 * equivalent of a student's own "Delete Account" in Settings, same
 * type-CONFIRM-to-confirm UI gate re-checked server-side here. Two
 * safeguards beyond that: an admin can never remove their own account this
 * way (that's what Settings' self-delete is for) or another admin's, so
 * this panel can't be used to accidentally lock everyone out of Admin.
 */
export async function removeUser(targetUserId: string, formData: FormData) {
  const { user: currentUser } = await requireAdmin();

  const confirmation = String(formData.get("confirmation") ?? "");
  if (confirmation !== "REMOVE") {
    redirect("/admin/users?error=remove-confirmation");
  }

  if (targetUserId === currentUser.id) {
    redirect("/admin/users?error=remove-self");
  }

  const admin = createAdminClient();

  const { data: targetProfile } = await admin
    .from("profiles")
    .select("role")
    .eq("id", targetUserId)
    .single();
  if (targetProfile?.role === "admin") {
    redirect("/admin/users?error=remove-admin");
  }

  const { error } = await admin.auth.admin.deleteUser(targetUserId);
  if (error) {
    redirect("/admin/users?error=remove-failed");
  }

  revalidatePath("/admin/users");
}

export async function inviteUser(
  _prev: InviteResult | null,
  formData: FormData,
): Promise<InviteResult> {
  // Re-checks admin status server-side on every submission — never trust a
  // client that merely didn't show the form.
  await requireAdmin();

  const email = String(formData.get("email") ?? "").trim();
  if (!email || !email.includes("@")) {
    return { ok: false, message: "Enter a valid email address." };
  }

  const plan = formData.get("plan") === "subscriber" ? "subscriber" : "trial";

  const siteUrl = await getSiteUrl();
  const admin = createAdminClient();

  const { data, error } = await admin.auth.admin.inviteUserByEmail(email, {
    redirectTo: `${siteUrl}/auth/callback`,
  });

  if (error) {
    return { ok: false, message: error.message };
  }

  // handle_new_user() already created the profiles row (default plan
  // 'trial', trial_started_at = now() — i.e. the moment of this invite,
  // per Gabriel's explicit "it starts from the moment they get invited").
  // Only need a follow-up write when the admin picked "subscriber" instead.
  if (plan === "subscriber" && data.user) {
    await admin.from("profiles").update({ plan: "subscriber" }).eq("id", data.user.id);
  }

  return { ok: true, email };
}

/**
 * One-click upgrade from the Free-Trial Users list — no payment gateway
 * behind this, it's purely Gabriel manually recording that this reviewee
 * has actually paid (per his explicit "add a feature in free trial users
 * where in i can just click them and add them as subscriber", 2026-09-25).
 * Immediately lifts the 14-day proxy.ts block on their next request.
 */
export async function upgradeToSubscriber(userId: string) {
  await requireAdmin();
  const admin = createAdminClient();
  await admin.from("profiles").update({ plan: "subscriber" }).eq("id", userId);
  revalidatePath("/admin/users");
}

/**
 * The reverse of upgradeToSubscriber — one-click from the Subscribers list
 * (per Gabriel's explicit "add a feature in free subscriber wherein i
 * click 'move to free trial'", 2026-09-25). Resets trial_started_at to now
 * rather than leaving whatever stale value the row had (e.g. a grandfathered
 * pre-plan-feature account, or their original trial from before an earlier
 * upgrade) — the 14-day clock always starts fresh from the moment of this
 * specific demotion, not from some unrelated past timestamp.
 */
export async function downgradeToTrial(userId: string) {
  await requireAdmin();
  const admin = createAdminClient();
  await admin.from("profiles").update({ plan: "trial", trial_started_at: new Date().toISOString() }).eq("id", userId);
  revalidatePath("/admin/users");
}
