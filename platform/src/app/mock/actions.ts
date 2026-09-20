"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { fillUnitsToTarget, groupIntoUnits } from "@/lib/series";

export type MockArea = "area_1" | "area_2" | "area_3";

const MOCK_EXAM_ITEM_COUNT = 100;
const MOCK_EXAM_TIME_LIMIT_MINUTES = 180; // 3 hours per area, matching the real board exam.

/**
 * Exact "Number of Items and Distribution" per official TOS subject, from
 * the 2025 ABE Table of Specifications Annex "A" (Subjects A/B/C, each
 * summing to 100 items — see 25_DECISION_LOG.md's 2026-09-21 entry). Not
 * modeled in the schema (subjects only has sort_order), so it's a fixed
 * lookup by exact subject name here. If the official TOS is ever revised,
 * update these numbers directly — don't derive them from anything else.
 */
const OFFICIAL_SUBJECT_ITEM_TARGETS: Record<string, number> = {
  // Area 1 (Subject A, 100 items)
  "Agricultural and Biosystems Power Engineering": 12,
  "Agricultural and Biosystems Mechanization Planning, Operation, Maintenance, Management and Manufacturing": 25,
  "Agricultural and Biosystems Machinery Specifications, Testing and Evaluation": 10,
  "Agricultural and Biosystems Automation, Instrumentation and Control System": 12,
  "Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension, and Information System on Agricultural and Biosystems Engineering": 22,
  "Laws, Professional Standards and Ethics": 19,
  // Area 2 (Subject B, 100 items)
  "Hydrology": 8,
  "Irrigation and Drainage Engineering": 25,
  "Soil and Water Conservation Engineering": 20,
  "Aquaculture Engineering": 4,
  "Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences": 18,
  "Mathematics and Basic Engineering": 25,
  // Area 3 (Subject C, 100 items)
  "Agricultural Buildings and Structures": 25,
  "Farm Electrification": 10,
  "Environment Engineering": 15,
  "Agricultural and Bioprocess Engineering": 39,
  "Food Engineering": 11,
};

/**
 * The real PRC ABE board exam is three separate 100-item, 3-hour subject
 * exams (Area 1/2/3) — not a freely-configurable quiz. Each topic has one
 * default `mock_area`; a question can also be individually tagged into an
 * additional area by an admin (`additional_mock_areas`) when it's judged
 * topically relevant there. See `supabase/patches/007_mock_exam_areas.sql`.
 *
 * Each official subject is sampled to its exact target item count above
 * (or fewer if that subject doesn't have enough published questions yet),
 * so the generated exam's subject mix matches the real board exam's
 * distribution instead of just pooling every candidate and filling to 100
 * regardless of which subject they came from. A topic without a subject_id
 * (or one that isn't part of this area's official six) isn't part of any
 * real TOS subject, so it doesn't participate — that mirrors the real
 * exam, which only tests officially-classified content.
 */
export async function startAreaMockExam(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const area = String(formData.get("area") ?? "") as MockArea;
  if (!["area_1", "area_2", "area_3"].includes(area)) {
    throw new Error("Invalid exam area.");
  }

  const [{ data: candidates, error: qErr }, { data: topics }, { data: subjects }] = await Promise.all([
    supabase
      .from("student_questions")
      .select("id, topic_id, series_key, series_position")
      .or(`topic_mock_area.eq.${area},additional_mock_areas.cs.{${area}}`),
    supabase.from("topics").select("id, subject_id"),
    supabase.from("subjects").select("id, name"),
  ]);
  if (qErr) throw new Error(qErr.message);

  const subjectIdByTopicId = new Map((topics ?? []).map((t) => [t.id, t.subject_id]));
  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const bySubjectId = new Map<string, typeof candidates>();
  for (const c of candidates ?? []) {
    const subjectId = subjectIdByTopicId.get(c.topic_id);
    const name = subjectId ? subjectNameById.get(subjectId) : null;
    if (!subjectId || !name || !(name in OFFICIAL_SUBJECT_ITEM_TARGETS)) continue;
    const list = bySubjectId.get(subjectId) ?? [];
    list.push(c);
    bySubjectId.set(subjectId, list);
  }

  const selected = [...bySubjectId.entries()].flatMap(([subjectId, subjectCandidates]) => {
    const name = subjectNameById.get(subjectId)!;
    const target = OFFICIAL_SUBJECT_ITEM_TARGETS[name];
    // Connected multi-part questions (same series_key) are never split
    // across a subject's cap — see src/lib/series.ts. A subject may land
    // slightly under its target rather than ever breaking a series apart.
    return fillUnitsToTarget(groupIntoUnits(subjectCandidates ?? []), target);
  });
  if (selected.length === 0) {
    throw new Error("No published questions in this area yet.");
  }

  const { data: attempt, error } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      mode: "mock",
      total_questions: selected.length,
      config: {
        question_ids: selected.map((q) => q.id),
        time_limit_minutes: MOCK_EXAM_TIME_LIMIT_MINUTES,
        area,
      },
    })
    .select("id")
    .single();

  if (error || !attempt) {
    throw new Error(error?.message ?? "Failed to start mock exam");
  }

  redirect(
    selected.length < MOCK_EXAM_ITEM_COUNT
      ? `/mock/${attempt.id}?requested=${MOCK_EXAM_ITEM_COUNT}`
      : `/mock/${attempt.id}`,
  );
}

export async function completeMockExam(attemptId: string) {
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
