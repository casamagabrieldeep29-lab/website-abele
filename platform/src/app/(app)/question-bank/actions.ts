"use server";

import { createClient } from "@/lib/supabase/server";
import { fetchSeriesInfo } from "@/lib/series";
import type { SeriesInfo } from "@/components/series-banner";

export type QuestionBankQuestion = { id: string; question_text: string; series?: SeriesInfo };

/**
 * Individual question text is only fetched once a Topic node is actually
 * expanded in the UI — the page itself only loads TOS/Subject/Topic names
 * and counts up front, so opening the tree doesn't mean pulling every
 * question in the bank on first load.
 */
export async function getSubtopicQuestions(subtopicId: string): Promise<QuestionBankQuestion[]> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return [];

  const { data } = await supabase
    .from("student_questions")
    .select("id, question_text")
    .eq("subtopic_id", subtopicId)
    .order("id");

  const questions: QuestionBankQuestion[] = data ?? [];
  // Follow-up parts of a connected problem carry the opening question with them.
  const seriesInfo = await fetchSeriesInfo(supabase, questions.map((q) => q.id));
  return questions.map((q) => (seriesInfo[q.id] ? { ...q, series: seriesInfo[q.id] } : q));
}
