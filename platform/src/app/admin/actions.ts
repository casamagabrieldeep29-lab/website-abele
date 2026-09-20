"use server";

import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createAdminClient } from "@/lib/supabase/admin";

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

  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
  const admin = createAdminClient();

  const { error } = await admin.auth.admin.inviteUserByEmail(email, {
    redirectTo: `${siteUrl}/auth/callback`,
  });

  if (error) {
    return { ok: false, message: error.message };
  }

  return { ok: true, email };
}
