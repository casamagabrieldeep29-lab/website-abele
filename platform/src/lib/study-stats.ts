import type { createClient } from "@/lib/supabase/server";

export type TopicMasteryRow = {
  topic_id: string;
  topic_name: string;
  exam_area_name: string;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: "insufficient_data" | "strong" | "developing" | "needs_review";
  last_answered_at: string | null;
};

type AnsweredRow = { answered_at: string | null; is_correct: boolean };

/**
 * A plain `.select()` on attempt_answers silently caps at PostgREST's
 * default max-rows (1000) — a student who's answered more than 1000
 * questions total would see "Questions answered" stuck at exactly 1000
 * forever, since every row past that point is dropped by the API layer
 * before it even reaches this code, not just before display. Paginates in
 * batches of 1000 via `.range()` until a page comes back short, so the
 * real total is always fetched regardless of how large it's grown.
 *
 * `userId` is required and enforced via an explicit `attempts!inner(user_id)`
 * filter rather than trusting RLS alone: the `attempt_answers` SELECT policy
 * grants admins unrestricted read access (for the admin panel), so an admin
 * account calling this without the filter would silently get every user's
 * answers merged into their own "Questions answered"/streak/accuracy.
 */
export async function fetchAllAnsweredRows(
  supabase: Awaited<ReturnType<typeof createClient>>,
  userId: string,
): Promise<AnsweredRow[]> {
  const pageSize = 1000;
  const all: AnsweredRow[] = [];
  for (let from = 0; ; from += pageSize) {
    const { data, error } = await supabase
      .from("attempt_answers")
      .select("answered_at, is_correct, attempts!inner(user_id)")
      .eq("attempts.user_id", userId)
      .not("answered_at", "is", null)
      .range(from, from + pageSize - 1);
    if (error) throw error;
    if (!data || data.length === 0) break;
    all.push(...data);
    if (data.length < pageSize) break;
  }
  return all;
}

export type StudyStats = {
  questionsAnswered: number;
  overallAccuracy: number | null;
  topicsStudied: number;
  topicsMastered: number;
  streak: number;
  studiedLast7: number;
};

/**
 * Single source of truth for the study statistics shown on both the
 * Dashboard and the Profile page. Both pages fetch the same get_topic_mastery()
 * rows and attempt_answers rows (each already needed them for other things)
 * and pass them through this one function, so the two pages can never
 * disagree on what "Questions Answered" or "Current Streak" means.
 */
export function computeStudyStats(mastery: TopicMasteryRow[], answered: AnsweredRow[]): StudyStats {
  const questionsAnswered = answered.length;
  const overallAccuracy = questionsAnswered
    ? Math.round((100 * answered.filter((a) => a.is_correct).length) / questionsAnswered)
    : null;

  const topicsStudied = mastery.filter((m) => m.total_attempts > 0).length;
  const topicsMastered = mastery.filter((m) => m.status === "strong").length;

  const studyDates = new Set(answered.map((a) => new Date(a.answered_at!).toISOString().slice(0, 10)));
  let streak = 0;
  const cursor = new Date();
  if (!studyDates.has(cursor.toISOString().slice(0, 10))) cursor.setDate(cursor.getDate() - 1);
  while (studyDates.has(cursor.toISOString().slice(0, 10))) {
    streak++;
    cursor.setDate(cursor.getDate() - 1);
  }
  let studiedLast7 = 0;
  const check = new Date();
  for (let i = 0; i < 7; i++) {
    if (studyDates.has(check.toISOString().slice(0, 10))) studiedLast7++;
    check.setDate(check.getDate() - 1);
  }

  return { questionsAnswered, overallAccuracy, topicsStudied, topicsMastered, streak, studiedLast7 };
}
