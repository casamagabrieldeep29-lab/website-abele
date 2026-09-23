"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import type { SupabaseClient } from "@supabase/supabase-js";
import { pickDailyQuestionId, todayStartIso } from "@/lib/daily-question";
import { getUserSettings, type PracticeMode } from "@/lib/study-preferences";
import { weighAndSampleCandidates, type SeriesCandidate } from "@/lib/series";
import type { MockArea } from "@/app/mock/actions";

export async function startPracticeAttempt(topicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { count } = await supabase
    .from("student_questions")
    .select("id", { count: "exact", head: true })
    .eq("topic_id", topicId);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      topic_id: topicId,
      total_questions: count ?? 0,
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start practice attempt");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * Starts an adaptive practice session for one topic: previously-missed
 * questions are weighted 3x, never-attempted 1.5x, previously-correct 1x
 * (see 25_DECISION_LOG.md for why). Unlike startPracticeAttempt, this caps
 * the session at `count` questions rather than serving the whole topic.
 * Connected multi-part questions (same series_key) are never split apart
 * or reordered — see src/lib/series.ts.
 */
export async function startAdaptivePracticeAttempt(topicId: string, count: number) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: candidates } = await supabase
    .from("student_questions")
    .select("id, series_key, series_position")
    .eq("topic_id", topicId);

  if (!candidates || candidates.length === 0) {
    throw new Error("No published questions in this topic yet.");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, count);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      topic_id: topicId,
      total_questions: selected.length,
      config: { question_ids: selected },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start adaptive practice session");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * Same adaptive weighting as startAdaptivePracticeAttempt, but pooled across
 * every topic under one official TOS subject rather than a single topic —
 * a subject can span several topics (see supabase/patches/013_official_
 * subjects.sql), so this omits `topic_id` on the attempt row and stores the
 * subject instead, the same "multi-topic pool" pattern startQuickPractice
 * already uses below.
 */
export async function startSubjectPracticeAttempt(subjectId: string, count: number) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: topicsInSubject } = await supabase.from("topics").select("id").eq("subject_id", subjectId);
  const topicIds = (topicsInSubject ?? []).map((t) => t.id);
  if (topicIds.length === 0) {
    throw new Error("No topics assigned to this subject yet.");
  }

  const { data: candidates } = await supabase
    .from("student_questions")
    .select("id, series_key, series_position")
    .in("topic_id", topicIds);
  if (!candidates || candidates.length === 0) {
    throw new Error("No published questions in this subject yet.");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, count);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: selected.length,
      config: { question_ids: selected, kind: "subject", subject_id: subjectId },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start subject practice session");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * PAES (Philippine Agricultural Engineering Standards) quiz: pools every
 * question tagged is_paes=true, regardless of topic, into one scored
 * practice attempt — the /paes section's "Take PAES Quiz" action. Mirrors
 * startSubjectPracticeAttempt's shape exactly, just filtered by is_paes
 * instead of subject_id.
 */
export async function startPaesQuizAttempt(count: number) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: candidates } = await supabase
    .from("student_questions")
    .select("id, series_key, series_position")
    .eq("is_paes", true);
  if (!candidates || candidates.length === 0) {
    throw new Error("No published PAES questions yet.");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, count);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: selected.length,
      config: { question_ids: selected, kind: "paes" },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start PAES quiz");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * Recalled Questions quiz: pools every published question tagged
 * is_recalled=true within one exam area (Area 1/2/3, the same split the
 * /recalled reference page already tabs by) into one scored practice
 * attempt. Every matching question is included rather than a random
 * subset — these are a finite, specific set of past board-exam recalls a
 * serious reviewee wants to work through in full, not a sample. Reuses an
 * existing in-progress recalled quiz for the same area instead of starting
 * a duplicate, the same reuse pattern startDailyQuestion uses below.
 */
export async function startRecalledQuiz(area: MockArea) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  if (!["area_1", "area_2", "area_3"].includes(area)) {
    throw new Error("Invalid area.");
  }

  const { data: existing } = await supabase
    .from("attempts")
    .select("id")
    .eq("user_id", user.id)
    .eq("status", "in_progress")
    .contains("config", { kind: "recalled", area })
    .maybeSingle();

  if (existing) {
    redirect(`/practice/${existing.id}`);
  }

  const { data: candidates, error } = await supabase
    .from("student_questions")
    .select("id, series_key, series_position")
    .eq("is_recalled", true)
    .or(`topic_mock_area.eq.${area},additional_mock_areas.cs.{${area}}`);
  if (error) throw new Error(error.message);
  if (!candidates || candidates.length === 0) {
    throw new Error("No recalled questions in this area yet.");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, candidates.length);

  const { data: attempt, error: insErr } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: selected.length,
      config: { question_ids: selected, kind: "recalled", area },
    })
    .select("id")
    .single();

  if (insErr || !attempt) {
    throw new Error(insErr?.message ?? "Failed to start recalled questions quiz");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * Narrows a candidate pool to one of the four Study Preferences practice
 * modes, using only real, already-existing data sources (get_topic_mastery
 * for "weak areas", get_mistake_bank for "mistakes", attempt_answers for
 * "unanswered") — same RPCs the Dashboard/Mistake Bank already use, nothing
 * new computed just for this. "mixed" is a no-op: it's exactly the existing
 * missed-weighted selection every other mode also builds on.
 */
async function scopeToPracticeMode(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: SupabaseClient<any>,
  candidates: (SeriesCandidate & { topic_id: string })[],
  mode: PracticeMode,
): Promise<(SeriesCandidate & { topic_id: string })[]> {
  if (mode === "mixed") return candidates;

  if (mode === "weak_areas") {
    const { data: masteryRows } = await supabase.rpc("get_topic_mastery");
    const weakTopicIds = new Set(
      (masteryRows ?? [])
        .filter((m: { status: string }) => m.status === "developing" || m.status === "needs_review")
        .map((m: { topic_id: string }) => m.topic_id),
    );
    const scoped = candidates.filter((c) => weakTopicIds.has(c.topic_id));
    return scoped.length > 0 ? scoped : candidates;
  }

  if (mode === "mistakes") {
    const { data: mistakes } = await supabase.rpc("get_mistake_bank");
    const mistakeIds = new Set((mistakes ?? []).map((m: { question_id: string }) => m.question_id));
    const scoped = candidates.filter((c) => mistakeIds.has(c.id));
    return scoped.length > 0 ? scoped : candidates;
  }

  // unanswered
  const { data: answered } = await supabase
    .from("attempt_answers")
    .select("question_id")
    .in("question_id", candidates.map((c) => c.id));
  const answeredIds = new Set((answered ?? []).map((a) => a.question_id));
  const scoped = candidates.filter((c) => !answeredIds.has(c.id));
  return scoped.length > 0 ? scoped : candidates;
}

/**
 * Quick Practice: adaptive session drawn from EVERY published question
 * (not scoped to one topic) — for students with limited time who just want
 * "give me N good questions to work on right now." `mode` defaults to the
 * caller's Study Preferences (Settings) when not passed explicitly; if a
 * mode's scoped pool is empty (e.g. "Mistakes" with zero current mistakes),
 * it falls back to the full pool rather than dead-ending the session.
 */
export async function startQuickPractice(count: number, mode?: PracticeMode) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const resolvedMode = mode ?? (await getUserSettings(supabase, user.id)).defaultPracticeMode;

  const { data: candidates } = await supabase.from("student_questions").select("id, topic_id, series_key, series_position");
  if (!candidates || candidates.length === 0) {
    throw new Error("No published questions yet.");
  }

  const scoped = await scopeToPracticeMode(supabase, candidates, resolvedMode);
  const selected = await weighAndSampleCandidates(supabase, scoped, count);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: selected.length,
      config: { question_ids: selected, kind: "quick", practice_mode: resolvedMode },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start quick practice session");
  }

  redirect(`/practice/${attempt.id}`);
}

type CustomQuizFilters = {
  topicIds: string[];
  difficulties: string[];
  category: "all" | "term" | "solving";
  source: "all" | "incorrect" | "unanswered";
  count: number;
};

/**
 * Custom Quiz Builder: at least one topic must be checked (no "leave
 * everything unchecked to mean every topic" fallback) — the generated quiz
 * strictly draws only from the exact topics the student picked, never
 * anything outside that set. Also respects the actual available pool —
 * never duplicates questions to hit the requested count. If fewer
 * questions match than requested, the session is just built from however
 * many exist and `adjustedFrom` is returned so the UI can tell the student
 * plainly, rather than silently serving a shorter quiz.
 */
export async function startCustomQuiz(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const filters: CustomQuizFilters = {
    topicIds: formData.getAll("topicIds").map(String).filter(Boolean),
    difficulties: formData.getAll("difficulties").map(String).filter(Boolean),
    category: (formData.get("category") as CustomQuizFilters["category"]) ?? "all",
    source: (formData.get("source") as CustomQuizFilters["source"]) ?? "all",
    count: Number(formData.get("count") ?? 20),
  };

  // At least one topic must be checked — strictly enforced, no "leave
  // everything unchecked to include every topic" fallback. A quiz only
  // ever draws from the exact topics the student picked.
  if (filters.topicIds.length === 0) {
    redirect("/quiz-builder?error=no-topics");
  }

  let query = supabase
    .from("student_questions")
    .select("id, topic_id, difficulty, series_key, series_position")
    .in("topic_id", filters.topicIds);
  if (filters.difficulties.length > 0) query = query.in("difficulty", filters.difficulties);
  if (filters.category !== "all") query = query.eq("category", filters.category);

  const { data: candidatesData } = await query;
  let candidates = candidatesData ?? [];

  if (filters.source === "incorrect") {
    const { data: mistakes } = await supabase.rpc("get_mistake_bank");
    const mistakeIds = new Set((mistakes ?? []).map((m: { question_id: string }) => m.question_id));
    candidates = candidates.filter((c) => mistakeIds.has(c.id));
  } else if (filters.source === "unanswered") {
    const { data: answered } = await supabase
      .from("attempt_answers")
      .select("question_id")
      .in("question_id", candidates.length ? candidates.map((c) => c.id) : ["00000000-0000-0000-0000-000000000000"]);
    const answeredIds = new Set((answered ?? []).map((a) => a.question_id));
    candidates = candidates.filter((c) => !answeredIds.has(c.id));
  }

  if (candidates.length === 0) {
    redirect("/quiz-builder?error=no-match");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, filters.count);
  const adjustedFrom = selected.length < filters.count ? filters.count : null;

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: selected.length,
      config: { question_ids: selected, kind: "custom" },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start custom quiz");
  }

  redirect(adjustedFrom ? `/practice/${attempt.id}?requested=${adjustedFrom}` : `/practice/${attempt.id}`);
}

/** Starts a practice session against the caller's exact current mistake list. */
export async function startMistakeRetryAttempt(questionIds: string[]) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  if (questionIds.length === 0) {
    throw new Error("No mistakes to retry.");
  }

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: questionIds.length,
      config: { question_ids: questionIds },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start mistake retry session");
  }

  redirect(`/practice/${attempt.id}`);
}

export async function completePracticeAttempt(attemptId: string) {
  const supabase = await createClient();
  const [{ data: { user } }, { count: correctCount }] = await Promise.all([
    supabase.auth.getUser(),
    supabase
      .from("attempt_answers")
      .select("id", { count: "exact", head: true })
      .eq("attempt_id", attemptId)
      .eq("is_correct", true),
  ]);
  if (!user) redirect("/login");

  const { error } = await supabase
    .from("attempts")
    .update({
      status: "completed",
      completed_at: new Date().toISOString(),
      correct_count: correctCount ?? 0,
    })
    .eq("id", attemptId)
    .eq("user_id", user.id);

  if (error) throw new Error(error.message);
  await supabase.rpc("check_and_award_achievements");
}

/**
 * Same adaptive weighting as startAdaptivePracticeAttempt, scoped to a
 * single subtopic ("concept") rather than a whole topic — the Question
 * Bank's drill-down practice entry point.
 */
export async function startSubtopicPracticeAttempt(subtopicId: string, count: number) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: candidates } = await supabase
    .from("student_questions")
    .select("id, topic_id, series_key, series_position")
    .eq("subtopic_id", subtopicId);

  if (!candidates || candidates.length === 0) {
    throw new Error("No published questions in this concept yet.");
  }

  const selected = await weighAndSampleCandidates(supabase, candidates, count);

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      topic_id: candidates![0].topic_id,
      total_questions: selected.length,
      config: { question_ids: selected, kind: "concept" },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start concept practice session");
  }

  redirect(`/practice/${attempt.id}`);
}

/**
 * Question of the Day: deterministically picks the same question for every
 * user on a given date (hash of the date over the published pool, ordered
 * by id so it's stable) — no scheduler, no table, no admin step needed.
 */
export async function startDailyQuestion() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: candidates } = await supabase.from("student_questions").select("id").order("id");
  const candidateIds = (candidates ?? []).map((c) => c.id);
  const questionId = pickDailyQuestionId(candidateIds);
  if (!questionId) {
    throw new Error("No published questions yet.");
  }

  // Reuse today's question if already attempted today (don't start a new
  // attempt every time the page is visited).
  const { data: existing } = await supabase
    .from("attempts")
    .select("id")
    .eq("user_id", user.id)
    .contains("config", { kind: "daily" })
    .gte("started_at", todayStartIso())
    .maybeSingle();

  if (existing) {
    redirect(`/practice/${existing.id}`);
  }

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "practice",
      total_questions: 1,
      config: { question_ids: [questionId], kind: "daily" },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start today's question");
  }

  redirect(`/practice/${attempt.id}`);
}
