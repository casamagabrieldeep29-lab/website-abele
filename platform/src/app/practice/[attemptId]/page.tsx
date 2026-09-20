import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { PracticeSession, type PracticeChoice, type PracticeQuestion } from "./practice-session";

const SESSION_LABELS: Record<string, string> = {
  quick: "Quick Practice",
  custom: "Custom Quiz",
  concept: "Concept Practice",
  daily: "Question of the Day",
};

export default async function PracticeAttemptPage({
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
    .select("id, topic_id, status, correct_count, total_questions, config, topics(name)")
    .eq("id", attemptId)
    .eq("user_id", user.id)
    .single();

  if (!attempt) notFound();

  const config = (attempt.config as { question_ids?: string[]; kind?: string } | null) ?? {};
  const isCustomSet = Boolean(config.question_ids?.length);

  const topicName = isCustomSet
    ? SESSION_LABELS[config.kind ?? ""] ?? "Adaptive session"
    : (attempt.topics as unknown as { name: string } | null)?.name ?? "Practice";

  // A custom question set (adaptive/mistake-retry sessions) carries an
  // explicit, pre-selected id list in attempt.config — fetch exactly those,
  // preserving their order. Otherwise fall back to the original behavior:
  // every published question in the attempt's topic, in id order.
  let questions: { id: string; question_text: string }[] | null;
  if (isCustomSet) {
    const { data } = await supabase
      .from("student_questions")
      .select("id, question_text")
      .in("id", config.question_ids!);
    const byId = new Map((data ?? []).map((q) => [q.id, q]));
    questions = config.question_ids!.map((id) => byId.get(id)).filter((q): q is { id: string; question_text: string } => Boolean(q));
  } else {
    // Ordered so a connected series (same series_key) always stays
    // contiguous and in its intended step order, rather than the
    // effectively-random order plain id ordering would give it.
    const { data } = await supabase
      .from("student_questions")
      .select("id, question_text")
      .eq("topic_id", attempt.topic_id)
      .order("series_key", { nullsFirst: true })
      .order("series_position")
      .order("id");
    questions = data;
  }

  const questionIds = (questions ?? []).map((q) => q.id);

  const { data: choices } = await supabase
    .from("student_choices")
    .select("id, question_id, choice_text, sort_order")
    .in("question_id", questionIds.length ? questionIds : ["00000000-0000-0000-0000-000000000000"])
    .order("sort_order");

  const choicesByQuestion = new Map<string, PracticeChoice[]>();
  for (const c of choices ?? []) {
    const list = choicesByQuestion.get(c.question_id) ?? [];
    list.push({ id: c.id, text: c.choice_text });
    choicesByQuestion.set(c.question_id, list);
  }

  const practiceQuestions: PracticeQuestion[] = (questions ?? []).map((q) => ({
    id: q.id,
    text: q.question_text,
    choices: choicesByQuestion.get(q.id) ?? [],
  }));

  const [{ data: existingAnswers }, { data: notes }, { data: bookmarks }] = await Promise.all([
    supabase
      .from("attempt_answers")
      .select("question_id, selected_choice_ids, is_correct")
      .eq("attempt_id", attemptId),
    supabase
      .from("question_notes")
      .select("question_id, note_text")
      .in("question_id", questionIds.length ? questionIds : ["00000000-0000-0000-0000-000000000000"]),
    supabase
      .from("bookmarks")
      .select("question_id")
      .eq("user_id", user.id)
      .in("question_id", questionIds.length ? questionIds : ["00000000-0000-0000-0000-000000000000"]),
  ]);

  const notesByQuestion = Object.fromEntries((notes ?? []).map((n) => [n.question_id, n.note_text]));
  const bookmarkedQuestionIds = (bookmarks ?? []).map((b) => b.question_id);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <Link href="/dashboard" className="text-lg font-bold text-primary">
          ABELIEVER
        </Link>
        <Link href="/practice" className="text-sm text-muted-foreground hover:underline">
          Exit practice
        </Link>
      </header>

      <div className="mx-auto max-w-5xl px-6 py-10">
        <p className="text-sm text-muted-foreground">{topicName}</p>

        {requested && (
          <p className="mt-2 rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
            Only {practiceQuestions.length} questions matched your filters (you asked for {requested}) — no questions were repeated to make up the difference.
          </p>
        )}

        {practiceQuestions.length === 0 ? (
          <p className="mt-4 text-sm text-muted-foreground">
            No published questions in this topic right now.
          </p>
        ) : (
          <PracticeSession
            attemptId={attempt.id}
            questions={practiceQuestions}
            initialAnswers={existingAnswers ?? []}
            initialNotes={notesByQuestion}
            initialBookmarkedIds={bookmarkedQuestionIds}
            alreadyCompleted={attempt.status === "completed"}
            finalScore={
              attempt.status === "completed"
                ? { correct: attempt.correct_count, total: attempt.total_questions }
                : null
            }
          />
        )}
      </div>
    </main>
  );
}
