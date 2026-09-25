import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { PaesQuizSession, type PaesChoice, type PaesQuestion } from "./paes-quiz-session";

/**
 * Phase 2 PAES Quiz session route — a standalone, distraction-free page
 * outside the (app) route group, mirroring /practice/[attemptId] and
 * /mock/[attemptId]'s own top-level convention. This REPLACES
 * /practice/[attemptId] as startPaesQuizAttempt's redirect target (see that
 * function's comment in practice/actions.ts) so the PAES Quizzer gets its
 * own full-screen Kahoot-style look instead of the generic two-column
 * practice-session layout.
 *
 * Scoped to the attempt's own user_id, same as every other session route —
 * a student can only ever open their own attempts.
 */
export default async function PaesQuizAttemptPage({
  params,
}: {
  params: Promise<{ attemptId: string }>;
}) {
  const { attemptId } = await params;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: attempt } = await supabase
    .from("attempts")
    .select("id, status, correct_count, total_questions, config")
    .eq("id", attemptId)
    .eq("user_id", user.id)
    .eq("mode", "practice")
    .single();

  if (!attempt) notFound();

  const config =
    (attempt.config as { question_ids?: string[]; timed_seconds?: number; paes_reference?: string } | null) ?? {};
  const questionIds = config.question_ids ?? [];
  const safeIds = questionIds.length ? questionIds : ["00000000-0000-0000-0000-000000000000"];

  const [{ data: questions }, { data: choices }, { data: existingAnswers }] = await Promise.all([
    supabase.from("student_questions").select("id, question_text, paes_reference").in("id", safeIds),
    supabase
      .from("student_choices")
      .select("id, question_id, choice_text, sort_order")
      .in("question_id", safeIds)
      .order("sort_order"),
    supabase.from("attempt_answers").select("question_id, selected_choice_ids, is_correct").eq("attempt_id", attemptId),
  ]);

  const questionById = new Map((questions ?? []).map((q) => [q.id, q]));
  const choicesByQuestion = new Map<string, PaesChoice[]>();
  for (const c of choices ?? []) {
    const list = choicesByQuestion.get(c.question_id) ?? [];
    list.push({ id: c.id, text: c.choice_text });
    choicesByQuestion.set(c.question_id, list);
  }

  // Preserve the original sampled order from attempt.config.question_ids —
  // same pattern as the Mock Exam session, not re-sorted by id.
  const paesQuestions: PaesQuestion[] = questionIds
    .map((id) => questionById.get(id))
    .filter((q): q is { id: string; question_text: string; paes_reference: string | null } => Boolean(q))
    .map((q) => ({
      id: q.id,
      text: q.question_text,
      paesReference: q.paes_reference,
      choices: choicesByQuestion.get(q.id) ?? [],
    }));

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <Link href="/dashboard" className="text-lg font-bold text-primary">
          ABELIEVER
        </Link>
        <Link href="/paes" className="text-sm text-muted-foreground hover:underline">
          Exit quiz
        </Link>
      </header>

      {paesQuestions.length === 0 ? (
        <p className="p-10 text-sm text-muted-foreground">
          This quiz has no questions (they may have been unpublished after it started).
        </p>
      ) : (
        <PaesQuizSession
          attemptId={attempt.id}
          questions={paesQuestions}
          initialAnswers={existingAnswers ?? []}
          timedSeconds={config.timed_seconds ?? null}
          alreadyCompleted={attempt.status === "completed"}
          finalScore={
            attempt.status === "completed"
              ? { correct: attempt.correct_count, total: attempt.total_questions }
              : null
          }
        />
      )}
    </main>
  );
}
