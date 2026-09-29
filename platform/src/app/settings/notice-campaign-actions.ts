"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";
import type { SaveResult } from "./actions";

/**
 * Backs the recurring notice-campaign popup (src/components/notice-campaign-
 * modal.tsx) — a schedulable, admin-authored version of saveProfileDetails'
 * one-shot "complete your profile" ask (src/app/settings/actions.ts). Only
 * ever writes a field the form actually rendered (i.e. one the campaign
 * targeted AND the user was still missing), same optional-password handling
 * as saveProfileDetails: updateUser() only runs when one was actually typed.
 */
export async function saveNoticeCampaignResponse(formData: FormData): Promise<SaveResult> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { ok: false, error: "Not signed in." };

  const address = formData.has("address") ? String(formData.get("address") ?? "").trim() : undefined;
  const school = formData.has("school") ? String(formData.get("school") ?? "").trim() : undefined;
  const password = formData.has("password") ? String(formData.get("password") ?? "") : "";

  if (password && password.length < 8) {
    return { ok: false, error: "Password must be at least 8 characters." };
  }

  const profileUpdate: Record<string, string | null> = {};
  if (address !== undefined && address) profileUpdate.address = address;
  if (school !== undefined && school) profileUpdate.school = school;

  if (Object.keys(profileUpdate).length > 0) {
    const { error } = await supabase.from("profiles").update(profileUpdate).eq("id", user.id);
    if (error) return { ok: false, error: error.message };
  }

  if (password) {
    const { error: pwError } = await supabase.auth.updateUser({ password });
    if (pwError) return { ok: false, error: pwError.message };
    const { error: flagError } = await supabase.from("profiles").update({ has_password: true }).eq("id", user.id);
    if (flagError) return { ok: false, error: flagError.message };
  }

  revalidatePath("/", "layout");
  return { ok: true };
}
