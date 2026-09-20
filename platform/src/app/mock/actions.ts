"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { fillUnitsToTarget, groupIntoUnits } from "@/lib/series";

export type MockArea = "area_1" | "area_2" | "area_3";

const MOCK_EXAM_ITEM_COUNT = 100;
const MOCK_EXAM_TIME_LIMIT_MINUTES = 180; // 3 hours per area, matching the real board exam.

/**
 * The real PRC ABE board exam is three separate 100-item, 3-hour subject
 * exams (Area 1/2/3) — not a freely-configurable quiz. Each topic has one
 * default `mock_area`; a question can also be individually tagged into an
 * additional area by an admin (`additional_mock_areas`) when it's judged
 * topically relevant there. See `supabase/patches/007_mock_exam_areas.sql`.
 */
export async function startAreaMockExam(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const area = String(formData.get("area") ?? "") as MockArea;
  if (!["area_1", "area_2", "area_3"].includes(area)) {
    throw new Error("Invalid exam area.");
  }

  const { data: candidates, error: qErr } = await supabase
    .from("student_questions")
    .select("id, series_key, series_position")
    .or(`topic_mock_area.eq.${area},additional_mock_areas.cs.{${area}}`);
  if (qErr) throw new Error(qErr.message);

  // Connected multi-part questions (same series_key) are never split across
  // the 100-item cap — see src/lib/series.ts. May land slightly under 100 in
  // rare cases rather than ever breaking a series apart.
  const selected = fillUnitsToTarget(groupIntoUnits(candidates ?? []), MOCK_EXAM_ITEM_COUNT);
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
