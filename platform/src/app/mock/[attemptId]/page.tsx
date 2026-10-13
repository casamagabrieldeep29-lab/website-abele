import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { MockExamSession, type MockChoice, type MockQuestion } from "./mock-exam-session";
import { getSessionUser } from "@/lib/auth/session";
import { MOCK_EXAM_TIME_LIMIT_MINUTES, nowMs, remainingMs } from "@/lib/mock-timing";
import { completeMockExam } from "../actions";

const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

export default async function MockExamAttemptPage({
  params,
}: {
  params: Promise<{ attemptId: string }>;
}) {
  const { attemptId } = await params;
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
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

  // The server owns the clock (see src/lib/mock-timing.ts). An attempt whose time
  // is already up is finished here and sent to its results instead of being
  // opened and instantly auto-submitted in the browser.
  const timeLimitMinutes = config.time_limit_minutes ?? MOCK_EXAM_TIME_LIMIT_MINUTES;
  const timeLeftMs = remainingMs(attempt.started_at, timeLimitMinutes, nowMs());
  if (Number.isFinite(timeLeftMs) && timeLeftMs <= 0) {
    await completeMockExam(attemptId);
    redirect(`/mock/${attemptId}/results`);
  }

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

      {mockQuestions.length === 0 ? (
        <p className="p-10 text-sm text-muted-foreground">
          This exam has no questions (they may have been unpublished after it started).
        </p>
      ) : (
        <MockExamSession
          attemptId={attempt.id}
          questions={mockQuestions}
          initialAnswers={Object.fromEntries(answersByQuestion)}
          initialRemainingMs={Number.isFinite(timeLeftMs) ? timeLeftMs : timeLimitMinutes * 60_000}
        />
      )}
    </main>
  );
}
