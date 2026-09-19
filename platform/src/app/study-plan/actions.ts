"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

const WEEKDAYS = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"] as const;

type TopicMastery = {
  topic_id: string;
  topic_name: string;
  mastery: number | null;
  status: string;
};

export type PlanDay = {
  date: string; // ISO date
  weekday: string;
  activity: string;
  // Exactly one of these is set: topicId for a specific adaptive-practice
  // slot (needs a form+action to start, not a plain link), href for a
  // static destination (Mock Exam setup, Mistake Bank, etc).
  topicId?: string;
  href?: string;
};

/**
 * Rule-based (not AI) generator: cycles a fixed set of study-activity types
 * across the student's selected weekdays between now and the target exam
 * date, resolving "weak area" slots to real topics from the CURRENT
 * least-mastered list at generation time. Documented here, not a black box.
 */
function generatePlan(targetDate: Date, studyDays: string[], leastMastered: TopicMastery[]): PlanDay[] {
  const cycle: { label: () => string; slot: () => Pick<PlanDay, "topicId" | "href"> }[] = [
    {
      label: () => `Weakest Area: ${leastMastered[0]?.topic_name ?? "Practice"}`,
      slot: () => (leastMastered[0] ? { topicId: leastMastered[0].topic_id } : { href: "/practice" }),
    },
    {
      label: () => `Second Weakest: ${leastMastered[1]?.topic_name ?? "Practice"}`,
      slot: () => (leastMastered[1] ? { topicId: leastMastered[1].topic_id } : { href: "/practice" }),
    },
    { label: () => "Mixed / New Topics", slot: () => ({ href: "/quiz-builder" }) },
    { label: () => "Mistake Bank", slot: () => ({ href: "/mistakes" }) },
    {
      label: () => `Targeted Practice: ${leastMastered[2]?.topic_name ?? "Practice"}`,
      slot: () => (leastMastered[2] ? { topicId: leastMastered[2].topic_id } : { href: "/practice" }),
    },
    { label: () => "Mock Exam", slot: () => ({ href: "/mock" }) },
    { label: () => "Review / Catch-up", slot: () => ({ href: "/progress" }) },
  ];

  const days: PlanDay[] = [];
  const cursor = new Date();
  cursor.setHours(0, 0, 0, 0);
  let cycleIndex = 0;

  while (cursor <= targetDate && days.length < 200) {
    const weekday = WEEKDAYS[cursor.getDay()];
    if (studyDays.includes(weekday)) {
      const item = cycle[cycleIndex % cycle.length];
      days.push({
        date: cursor.toISOString().slice(0, 10),
        weekday,
        activity: item.label(),
        ...item.slot(),
      });
      cycleIndex++;
    }
    cursor.setDate(cursor.getDate() + 1);
  }

  return days;
}

export async function generateStudyPlan(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const targetExamDate = String(formData.get("targetExamDate") ?? "");
  const minutesPerDay = Number(formData.get("minutesPerDay") ?? 60);
  const studyDays = formData.getAll("studyDays").map(String);

  if (!targetExamDate || studyDays.length === 0) {
    redirect("/study-plan?error=missing-fields");
  }

  const { data: masteryRows } = await supabase.rpc("get_topic_mastery");
  const leastMastered = ((masteryRows ?? []) as TopicMastery[])
    .filter((m) => m.status !== "insufficient_data")
    .slice()
    .sort((a, b) => (a.mastery ?? 0) - (b.mastery ?? 0));

  const plan = generatePlan(new Date(targetExamDate), studyDays, leastMastered);

  const { error } = await supabase.from("study_plans").upsert(
    {
      user_id: user.id,
      target_exam_date: targetExamDate,
      study_days: studyDays,
      minutes_per_day: minutesPerDay,
      generated_plan: plan,
      updated_at: new Date().toISOString(),
    },
    { onConflict: "user_id" },
  );

  if (error) throw new Error(error.message);

  // Keep the general Target Exam Date preference (set from /profile) in
  // sync with the date a generated plan actually commits to.
  await supabase.from("user_settings").upsert(
    { user_id: user.id, target_exam_date: targetExamDate, updated_at: new Date().toISOString() },
    { onConflict: "user_id" },
  );

  redirect("/study-plan");
}
