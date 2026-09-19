import type { SupabaseClient } from "@supabase/supabase-js";

export const PRACTICE_LENGTH_OPTIONS = [10, 20, 30, 50] as const;
export type PracticeLength = (typeof PRACTICE_LENGTH_OPTIONS)[number];

export const PRACTICE_MODE_OPTIONS = [
  { value: "mixed", label: "Mixed", description: "General practice using the app's existing question selection." },
  { value: "weak_areas", label: "Weak Areas", description: "Prioritizes topics where your mastery is currently lowest." },
  { value: "mistakes", label: "Mistakes", description: "Prioritizes questions you've previously gotten wrong." },
  { value: "unanswered", label: "Unanswered", description: "Prioritizes questions you haven't tried yet." },
] as const;
export type PracticeMode = (typeof PRACTICE_MODE_OPTIONS)[number]["value"];

export const DEFAULT_PRACTICE_LENGTH: PracticeLength = 20;
export const DEFAULT_PRACTICE_MODE: PracticeMode = "mixed";

export function isValidPracticeLength(value: unknown): value is PracticeLength {
  return typeof value === "number" && (PRACTICE_LENGTH_OPTIONS as readonly number[]).includes(value);
}

export function isValidPracticeMode(value: unknown): value is PracticeMode {
  return typeof value === "string" && PRACTICE_MODE_OPTIONS.some((o) => o.value === value);
}

export type UserSettings = {
  targetExamDate: string | null;
  defaultPracticeLength: PracticeLength;
  defaultPracticeMode: PracticeMode;
};

/**
 * Reads this user's Settings row, falling back to defaults when they've
 * never saved one (no row is created until the first save). Used by
 * /profile, /settings, /quick, and /study-plan so they all agree on what
 * the student's current preferences are.
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function getUserSettings(supabase: SupabaseClient<any>, userId: string): Promise<UserSettings> {
  const { data } = await supabase
    .from("user_settings")
    .select("target_exam_date, default_practice_length, default_practice_mode")
    .eq("user_id", userId)
    .maybeSingle();

  return {
    targetExamDate: data?.target_exam_date ?? null,
    defaultPracticeLength: isValidPracticeLength(data?.default_practice_length)
      ? data.default_practice_length
      : DEFAULT_PRACTICE_LENGTH,
    defaultPracticeMode: isValidPracticeMode(data?.default_practice_mode)
      ? data.default_practice_mode
      : DEFAULT_PRACTICE_MODE,
  };
}
