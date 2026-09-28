"use server";

import { createClient } from "@/lib/supabase/server";

export type MistakeDetail = {
  questionText: string;
  choices: { text: string; is_correct: boolean }[];
  explanation: string | null;
  topicName: string;
  subtopicName: string | null;
  examAreaName: string;
};

/**
 * Free, instant "why you missed this" reveal — the static explanation and
 * correct answer, no AI call. Reuses get_teach_me_context() (patch
 * 006_ai_gemini_usage.sql), the same RPC <TeachMeThis> calls for its own
 * deeper AI explanation, so the ownership check (this question was actually
 * answered in this attempt, by this user) and the underlying data are both
 * already correct — this is just a thinner, non-AI read of the same thing.
 */
export async function getMistakeDetail(attemptId: string, questionId: string): Promise<MistakeDetail | null> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const { data, error } = await supabase.rpc("get_teach_me_context", {
    p_attempt_id: attemptId,
    p_question_id: questionId,
  });
  if (error || !data?.length) return null;

  const row = data[0];
  return {
    questionText: row.question_text,
    choices: (row.choices ?? []) as { text: string; is_correct: boolean }[],
    explanation: row.explanation,
    topicName: row.topic_name,
    subtopicName: row.subtopic_name,
    examAreaName: row.exam_area_name,
  };
}
