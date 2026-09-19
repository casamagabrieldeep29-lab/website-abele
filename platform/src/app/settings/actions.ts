"use server";

import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";
import { createAdminClient } from "@/lib/supabase/admin";
import { isValidPracticeLength, isValidPracticeMode } from "@/lib/study-preferences";

export type SaveResult = { ok: true } | { ok: false; error: string };

export async function updateStudyPreferences(formData: FormData): Promise<SaveResult> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return { ok: false, error: "Not signed in." };

  const length = Number(formData.get("defaultPracticeLength"));
  const mode = String(formData.get("defaultPracticeMode") ?? "");

  if (!isValidPracticeLength(length)) {
    return { ok: false, error: "Invalid practice length." };
  }
  if (!isValidPracticeMode(mode)) {
    return { ok: false, error: "Invalid practice mode." };
  }

  const { error } = await supabase.from("user_settings").upsert(
    {
      user_id: user.id,
      default_practice_length: length,
      default_practice_mode: mode,
      updated_at: new Date().toISOString(),
    },
    { onConflict: "user_id" },
  );
  if (error) return { ok: false, error: error.message };

  revalidatePath("/settings");
  revalidatePath("/profile");
  revalidatePath("/quick");
  return { ok: true };
}

/**
 * Permanently deletes the caller's own account. The confirmation text is
 * checked here (server-side), never trusted from a disabled/enabled button
 * state alone. Deleting the auth.users row cascades through profiles and
 * every user_id foreign key (attempts, notes, bookmarks, settings,
 * flashcard progress, etc. — all `on delete cascade`); admin-authored
 * content (created_by/reviewed_by on questions/reviewer_entries/flashcards)
 * is `on delete set null` instead, so it isn't affected.
 */
export async function deleteAccount(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const confirmation = String(formData.get("confirmation") ?? "");
  if (confirmation !== "DELETE") {
    redirect("/settings?error=delete-confirmation");
  }

  const admin = createAdminClient();
  const { error } = await admin.auth.admin.deleteUser(user.id);
  if (error) {
    redirect("/settings?error=delete-failed");
  }

  await supabase.auth.signOut();
  redirect("/login?deleted=1");
}
