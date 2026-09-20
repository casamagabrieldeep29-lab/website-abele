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

export type SendCodeResult = { ok: true; email: string } | { ok: false; message: string };

/**
 * First step of Reset Progress: sends a 6-digit email OTP to the caller's
 * OWN address (from their session, never a client-submitted email — so
 * this can't be used to send a code anywhere else). Same
 * signInWithOtp/verifyOtp mechanism already used for login (see
 * src/app/login/actions.ts) — no new email infrastructure needed.
 */
export async function sendResetProgressCode(
  _prev: SendCodeResult | null,
  _formData: FormData,
): Promise<SendCodeResult> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user?.email) return { ok: false, message: "Not signed in." };

  const { error } = await supabase.auth.signInWithOtp({
    email: user.email,
    options: { shouldCreateUser: false },
  });
  if (error) {
    console.error("[sendResetProgressCode]", error.status, error.message);
    return { ok: false, message: "Couldn't send a verification code. Try again in a moment." };
  }

  return { ok: true, email: user.email };
}

export type ResetProgressResult = { ok: true } | { ok: false; message: string };

/**
 * Second step: verifies the emailed code, then wipes computed study
 * progress only — attempts (attempt_answers cascades from it),
 * flashcard_progress, and user_achievements. Never the account itself,
 * never user-authored content (notes, bookmarks) or preferences
 * (user_settings) — this is "start my stats over," not account deletion.
 * user_achievements only has a SELECT policy for regular users (it's
 * normally written by a SECURITY DEFINER RPC), so that one delete goes
 * through the service-role client, explicitly scoped to this verified
 * user's own id — same pattern deleteAccount below already uses for its
 * own destructive operation.
 */
export async function confirmResetProgress(
  _prev: ResetProgressResult | null,
  formData: FormData,
): Promise<ResetProgressResult> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user?.email) return { ok: false, message: "Not signed in." };

  const token = String(formData.get("token") ?? "").trim();
  if (!token) {
    return { ok: false, message: "Enter the 6-digit code from your email." };
  }

  const { error: otpError } = await supabase.auth.verifyOtp({ email: user.email, token, type: "email" });
  if (otpError) {
    console.error("[confirmResetProgress]", otpError.status, otpError.message);
    return { ok: false, message: "That code didn't work — it may be wrong or expired. Try sending a new one." };
  }

  const admin = createAdminClient();
  const [{ error: attemptsErr }, { error: flashErr }, { error: achErr }] = await Promise.all([
    supabase.from("attempts").delete().eq("user_id", user.id),
    supabase.from("flashcard_progress").delete().eq("user_id", user.id),
    admin.from("user_achievements").delete().eq("user_id", user.id),
  ]);
  const firstError = attemptsErr ?? flashErr ?? achErr;
  if (firstError) {
    return { ok: false, message: firstError.message };
  }

  revalidatePath("/dashboard");
  revalidatePath("/progress");
  revalidatePath("/profile");
  revalidatePath("/settings");
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
