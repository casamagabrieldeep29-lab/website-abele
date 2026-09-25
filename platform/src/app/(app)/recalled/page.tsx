import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { PageHeader } from "@/components/page-header";
import { RecalledBrowser, type RecalledQuestion } from "./recalled-browser";
import type { MockArea } from "@/app/mock/actions";

export default async function RecalledQuestionsPage() {
  const { supabase, user } = await getAuthContext();
  if (!user) redirect("/login");

  const [{ data, error }, { data: mistakes }] = await Promise.all([
    supabase.rpc("get_recalled_questions"),
    supabase.rpc("get_mistake_bank"),
  ]);
  if (error) throw new Error(error.message);

  type RecalledQuestionRow = {
    question_id: string;
    question_text: string;
    explanation: string | null;
    recalled_batch: string | null;
    topic_name: string;
    mock_area: string;
    choices: { text: string; is_correct: boolean }[] | null;
  };

  const questions: RecalledQuestion[] = ((data ?? []) as RecalledQuestionRow[]).map((row) => ({
    questionId: row.question_id,
    questionText: row.question_text,
    explanation: row.explanation,
    recalledBatch: row.recalled_batch,
    topicName: row.topic_name,
    mockArea: row.mock_area as MockArea,
    choices: ((row.choices ?? []) as { text: string; is_correct: boolean }[]).map((c) => ({
      text: c.text,
      isCorrect: c.is_correct,
    })),
  }));

  const mistakeIds = new Set(((mistakes ?? []) as { question_id: string }[]).map((m) => m.question_id));
  const mistakeCountByArea: Record<MockArea, number> = { area_1: 0, area_2: 0, area_3: 0 };
  for (const q of questions) {
    if (mistakeIds.has(q.questionId)) mistakeCountByArea[q.mockArea] += 1;
  }

  return (
    <div className="mx-auto w-full max-w-5xl space-y-6">
      <PageHeader
        title="Recalled Questions"
        description="Questions past examinees remember from the actual board exam (2011-2024), compiled by area. Choices and correct answers are shown directly — this is a reference document, not a timed practice session."
      />
      <RecalledBrowser questions={questions} mistakeCountByArea={mistakeCountByArea} />
    </div>
  );
}
