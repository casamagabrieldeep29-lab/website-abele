"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";

export type SaveResult = { ok: true } | { ok: false; error: string };

const MAX_DISPLAY_NAME_LENGTH = 60;

export async function updateDisplayName(formData: FormData): Promise<SaveResult> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return { ok: false, error: "Not signed in." };

  const displayName = String(formData.get("displayName") ?? "").trim();
  if (displayName.length === 0) {
    return { ok: false, error: "Display name can't be empty." };
  }
  if (displayName.length > MAX_DISPLAY_NAME_LENGTH) {
    return { ok: false, error: `Display name must be ${MAX_DISPLAY_NAME_LENGTH} characters or fewer.` };
  }

  const { error } = await supabase
    .from("profiles")
    .update({ display_name: displayName })
    .eq("id", user.id);
  if (error) return { ok: false, error: error.message };

  revalidatePath("/profile");
  revalidatePath("/dashboard");
  return { ok: true };
}

/** Strict YYYY-MM-DD parse/validate — never routed through `new Date(string)`
 *  for the round-trip, so there's no local-timezone shifting of the date. */
function parseIsoDateOrNull(raw: string): string | null {
  const match = /^(\d{4})-(\d{2})-(\d{2})$/.exec(raw);
  if (!match) return null;
  const y = Number(match[1]);
  const m = Number(match[2]);
  const d = Number(match[3]);
  const check = new Date(Date.UTC(y, m - 1, d));
  if (check.getUTCFullYear() !== y || check.getUTCMonth() !== m - 1 || check.getUTCDate() !== d) return null;
  return raw;
}

export async function updateTargetExamDate(formData: FormData): Promise<SaveResult> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return { ok: false, error: "Not signed in." };

  const raw = String(formData.get("targetExamDate") ?? "").trim();
  let targetExamDate: string | null = null;
  if (raw.length > 0) {
    targetExamDate = parseIsoDateOrNull(raw);
    if (!targetExamDate) return { ok: false, error: "Enter a valid date." };
  }

  const { error } = await supabase.from("user_settings").upsert(
    { user_id: user.id, target_exam_date: targetExamDate, updated_at: new Date().toISOString() },
    { onConflict: "user_id" },
  );
  if (error) return { ok: false, error: error.message };

  revalidatePath("/profile");
  revalidatePath("/settings");
  revalidatePath("/study-plan");
  return { ok: true };
}

/** Plain (non-status) variant for the one-click "Clear" link on /profile. */
export async function clearTargetExamDate(): Promise<void> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return;

  await supabase
    .from("user_settings")
    .upsert(
      { user_id: user.id, target_exam_date: null, updated_at: new Date().toISOString() },
      { onConflict: "user_id" },
    );

  revalidatePath("/profile");
  revalidatePath("/settings");
  revalidatePath("/study-plan");
}
