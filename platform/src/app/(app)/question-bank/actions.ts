"use server";

import { createClient } from "@/lib/supabase/server";

export type QuestionBankQuestion = { id: string; question_text: string };

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

  return data ?? [];
}
