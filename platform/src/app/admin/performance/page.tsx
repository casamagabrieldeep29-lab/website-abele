import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { Card, CardContent } from "@/components/ui/card";

const MIN_MISSES_TO_SHOW = 2;

type PerformanceAnswerRow = {
  question_id: string;
  is_correct: boolean;
  attempt_id: string;
  // PostgREST embeds a to-one relation as a single-element array when the
  // client isn't generated from the DB schema (same shape the pre-existing
  // `as unknown as { user_id: string } | null` cast below already expects).
  attempts: { user_id: string }[] | null;
};

export default async function AdminPerformancePage() {
  await requireAdmin();
  const supabase = await createClient();

  // Admin RLS already permits reading every user's rows here (not just the
  // caller's own) — see "attempts_own_or_admin" / "attempt_answers_own_or_admin"
  // policies in schema.sql. No new RPC needed.
  //
  // Both queries below are unfiltered across the whole account (attempt_answers:
  // 7000+ rows; questions: 2200+ rows) — a plain `.select()` would silently
  // cap each at PostgREST's 1000-row default, badly understating topic
  // accuracy and "most-missed questions" group-wide. Paginated.
  const [answers, questions, { data: topics }] = await Promise.all([
    fetchAllRows<PerformanceAnswerRow>((from, to) =>
      supabase
        .from("attempt_answers")
        .select("question_id, is_correct, attempt_id, attempts(user_id)")
        .not("answered_at", "is", null)
        .range(from, to),
    ),
    fetchAllRows<{ id: string; topic_id: string; question_text: string }>((from, to) =>
      supabase.from("questions").select("id, topic_id, question_text").range(from, to),
    ),
    supabase.from("topics").select("id, name"),
  ]);

  const topicById = new Map((topics ?? []).map((t) => [t.id, t.name]));
  const questionById = new Map(questions.map((q) => [q.id, q]));

  type TopicAgg = { total: number; correct: number; students: Set<string> };
  const byTopic = new Map<string, TopicAgg>();
  const missesByQuestion = new Map<string, number>();

  for (const a of answers) {
    const question = questionById.get(a.question_id);
    if (!question) continue;
    const userId = (a.attempts as unknown as { user_id: string } | null)?.user_id;

    const agg = byTopic.get(question.topic_id) ?? { total: 0, correct: 0, students: new Set<string>() };
    agg.total += 1;
    if (a.is_correct) agg.correct += 1;
    if (userId) agg.students.add(userId);
    byTopic.set(question.topic_id, agg);

    if (!a.is_correct) {
      missesByQuestion.set(a.question_id, (missesByQuestion.get(a.question_id) ?? 0) + 1);
    }
  }

  const topicRows = [...byTopic.entries()]
    .map(([topicId, agg]) => ({
      topicId,
      topicName: topicById.get(topicId) ?? "Unknown topic",
      total: agg.total,
      accuracy: agg.total ? Math.round((100 * agg.correct) / agg.total) : 0,
      students: agg.students.size,
    }))
    .sort((a, b) => a.accuracy - b.accuracy);

  const mostMissed = [...missesByQuestion.entries()]
    .filter(([, count]) => count >= MIN_MISSES_TO_SHOW)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 10)
    .map(([questionId, count]) => ({
      questionId,
      count,
      text: questionById.get(questionId)?.question_text ?? "(question no longer exists)",
      topicId: questionById.get(questionId)?.topic_id,
    }));

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Group Performance</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="w-full px-6 py-10 space-y-8">
        <p className="text-sm text-muted-foreground">
          Aggregate accuracy across everyone invited, computed from real answered questions — no fabricated numbers.
        </p>

        <div>
          <h2 className="text-sm font-semibold text-muted-foreground">Accuracy by topic (lowest first)</h2>
          <div className="mt-2 space-y-2">
            {topicRows.map((r) => (
              <Card key={r.topicId}>
                <CardContent className="flex items-center justify-between gap-3 py-3">
                  <div>
                    <p className="text-sm font-medium">{r.topicName}</p>
                    <p className="text-xs text-muted-foreground">
                      {r.total} answers · {r.students} student{r.students === 1 ? "" : "s"}
                    </p>
                  </div>
                  <span className="text-sm font-medium">{r.accuracy}%</span>
                </CardContent>
              </Card>
            ))}
            {topicRows.length === 0 && <p className="text-sm text-muted-foreground">No answered questions yet.</p>}
          </div>
        </div>

        <div>
          <h2 className="text-sm font-semibold text-muted-foreground">Most-missed questions (group-wide)</h2>
          <div className="mt-2 space-y-2">
            {mostMissed.map((q) => (
              <Card key={q.questionId}>
                <CardContent className="flex items-center justify-between gap-3 py-3">
                  <p className="text-sm">{q.text}</p>
                  <div className="flex shrink-0 items-center gap-2">
                    <span className="text-xs text-muted-foreground">missed {q.count}×</span>
                    {q.topicId && (
                      <Link href={`/admin/content/${q.topicId}`} className="text-xs font-medium text-primary hover:underline">
                        Review →
                      </Link>
                    )}
                  </div>
                </CardContent>
              </Card>
            ))}
            {mostMissed.length === 0 && (
              <p className="text-sm text-muted-foreground">
                Nothing missed {MIN_MISSES_TO_SHOW}+ times yet.
              </p>
            )}
          </div>
        </div>
      </div>
    </main>
  );
}
