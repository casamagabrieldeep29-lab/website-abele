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

/**
 * Compact stand-in for "every answer this student ever gave". Dashboard,
 * Progress, Profile and the AI assistant only ever needed totals, the accuracy
 * of the latest few answers, and per-day counts — so they read this (a few KB,
 * from the get_answer_summary() SQL function, patch 048) instead of downloading
 * the whole answer history (~130 bytes/row) on every page view. Days are UTC.
 */
export type AnswerDay = { d: string; n: number; c: number };
export type AnswerSummary = {
  total: number;
  correct: number;
  recentTotal: number;
  recentCorrect: number;
  days: AnswerDay[];
};

const SUMMARY_DAYS = 120;

function summaryFromRows(rows: AnsweredRow[], recentWindow: number): AnswerSummary {
  const dated = rows.filter((r): r is { answered_at: string; is_correct: boolean } => Boolean(r.answered_at));
  const byDay = new Map<string, AnswerDay>();
  const cutoff = Date.now() - SUMMARY_DAYS * 86_400_000;
  for (const r of dated) {
    if (new Date(r.answered_at).getTime() < cutoff) continue;
    const d = new Date(r.answered_at).toISOString().slice(0, 10);
    const e = byDay.get(d) ?? { d, n: 0, c: 0 };
    e.n += 1;
    if (r.is_correct) e.c += 1;
    byDay.set(d, e);
  }
  const recent = [...dated]
    .sort((a, b) => new Date(b.answered_at).getTime() - new Date(a.answered_at).getTime())
    .slice(0, recentWindow);
  return {
    total: dated.length,
    correct: dated.filter((r) => r.is_correct).length,
    recentTotal: recent.length,
    recentCorrect: recent.filter((r) => r.is_correct).length,
    days: [...byDay.values()].sort((a, b) => a.d.localeCompare(b.d)),
  };
}

/**
 * Preferred path: one small RPC. Falls back to the old full-history download
 * only if the function is not installed yet (patch 048 not applied), so
 * deploying this code before running the SQL never breaks a page — it just
 * does not save bandwidth until the SQL is run.
 */
export async function fetchAnswerSummary(
  supabase: Awaited<ReturnType<typeof createClient>>,
  userId: string,
  recentWindow = 30,
): Promise<AnswerSummary> {
  const { data, error } = await supabase.rpc("get_answer_summary", {
    p_recent_window: recentWindow,
    p_days: SUMMARY_DAYS,
  });
  if (!error && data && typeof data === "object") {
    const r = data as {
      total: number;
      correct: number;
      recent_total: number;
      recent_correct: number;
      days: AnswerDay[];
    };
    return {
      total: Number(r.total) || 0,
      correct: Number(r.correct) || 0,
      recentTotal: Number(r.recent_total) || 0,
      recentCorrect: Number(r.recent_correct) || 0,
      days: r.days ?? [],
    };
  }
  return summaryFromRows(await fetchAllAnsweredRows(supabase, userId), recentWindow);
}

/** Weekly accuracy buckets from per-day counts (same windows the old per-row version used). */
export function weeklyAccuracyFromDays(
  days: AnswerDay[],
  weeks: number,
): { label: string; accuracy: number | null; count: number }[] {
  const now = new Date();
  const out: { label: string; accuracy: number | null; count: number }[] = [];
  for (let i = weeks - 1; i >= 0; i--) {
    const end = new Date(now);
    end.setDate(end.getDate() - i * 7);
    const start = new Date(end);
    start.setDate(start.getDate() - 6);
    const from = start.toISOString().slice(0, 10);
    const to = end.toISOString().slice(0, 10);
    let n = 0;
    let c = 0;
    for (const d of days) {
      if (d.d >= from && d.d <= to) {
        n += d.n;
        c += d.c;
      }
    }
    out.push({
      label: `${start.getMonth() + 1}/${start.getDate()}`,
      accuracy: n ? Math.round((100 * c) / n) : null,
      count: n,
    });
  }
  return out;
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
 *
 * `currentStreak` is passed in rather than derived from `answered` here —
 * it's `profiles.current_streak`, a persisted counter bumped by
 * submit_attempt_answer/record_mock_answer (see patch 031). A streak is a
 * practice-consistency habit metric, not a content-mastery stat, so
 * "Reset Progress" (which deletes attempt_answers) must not zero it out —
 * recomputing it live from `answered` would do exactly that.
 */
export function computeStudyStats(
  mastery: TopicMasteryRow[],
  summary: AnswerSummary,
  currentStreak: number,
): StudyStats {
  const questionsAnswered = summary.total;
  const overallAccuracy = questionsAnswered ? Math.round((100 * summary.correct) / questionsAnswered) : null;

  const topicsStudied = mastery.filter((m) => m.total_attempts > 0).length;
  const topicsMastered = mastery.filter((m) => m.status === "strong").length;

  const studyDates = new Set(summary.days.map((d) => d.d));
  let studiedLast7 = 0;
  const check = new Date();
  for (let i = 0; i < 7; i++) {
    if (studyDates.has(check.toISOString().slice(0, 10))) studiedLast7++;
    check.setDate(check.getDate() - 1);
  }

  return { questionsAnswered, overallAccuracy, topicsStudied, topicsMastered, streak: currentStreak, studiedLast7 };
}
