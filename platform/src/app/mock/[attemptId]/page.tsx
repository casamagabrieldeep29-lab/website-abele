import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { MockExamSession, type MockChoice, type MockQuestion } from "./mock-exam-session";

const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

export default async function MockExamAttemptPage({
  params,
  searchParams,
}: {
  params: Promise<{ attemptId: string }>;
  searchParams: Promise<{ requested?: string }>;
}) {
  const { attemptId } = await params;
  const { requested } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: attempt } = await supabase
    .from("attempts")
    .select("id, status, started_at, config")
    .eq("id", attemptId)
    .eq("user_id", user.id)
    .eq("mode", "mock")
    .single();

  if (!attempt) notFound();
  if (attempt.status === "completed") redirect(`/mock/${attemptId}/results`);

  const config = attempt.config as { question_ids: string[]; time_limit_minutes: number; area?: string };
  const questionIds = config.question_ids ?? [];

  const [{ data: questions }, { data: choices }, { data: existingAnswers }] = await Promise.all([
    supabase.from("student_questions").select("id, question_text").in("id", questionIds),
    supabase.from("student_choices").select("id, question_id, choice_text, sort_order").in("question_id", questionIds).order("sort_order"),
    supabase.from("attempt_answers").select("question_id, selected_choice_ids").eq("attempt_id", attemptId),
  ]);

  const questionById = new Map((questions ?? []).map((q) => [q.id, q]));
  const choicesByQuestion = new Map<string, MockChoice[]>();
  for (const c of choices ?? []) {
    const list = choicesByQuestion.get(c.question_id) ?? [];
    list.push({ id: c.id, text: c.choice_text });
    choicesByQuestion.set(c.question_id, list);
  }

  // Preserve the original randomized order from when the exam was started.
  const mockQuestions: MockQuestion[] = questionIds
    .map((id) => questionById.get(id))
    .filter((q): q is { id: string; question_text: string } => Boolean(q))
    .map((q) => ({ id: q.id, text: q.question_text, choices: choicesByQuestion.get(q.id) ?? [] }));

  const answersByQuestion = new Map(
    (existingAnswers ?? []).map((a) => [a.question_id, a.selected_choice_ids as string[]]),
  );

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <Link href="/dashboard" className="text-lg font-bold text-primary">
          ABELIEVER
        </Link>
        <span className="text-sm text-muted-foreground">
          Mock Exam{config.area ? ` — ${AREA_LABELS[config.area] ?? config.area}` : ""}
        </span>
      </header>

      {requested && (
        <p className="mx-auto mt-4 max-w-2xl rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
          Only {mockQuestions.length} published questions are available for this area yet (the real exam has {requested}) —
          no questions were repeated to make up the difference.
        </p>
      )}

      {mockQuestions.length === 0 ? (
        <p className="p-10 text-sm text-muted-foreground">
          This exam has no questions (they may have been unpublished after it started).
        </p>
      ) : (
        <MockExamSession
          attemptId={attempt.id}
          questions={mockQuestions}
          initialAnswers={Object.fromEntries(answersByQuestion)}
          startedAt={attempt.started_at}
          timeLimitMinutes={config.time_limit_minutes ?? 60}
        />
      )}
    </main>
  );
}
