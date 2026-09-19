import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { startAdaptivePracticeAttempt } from "@/app/practice/actions";
import { StudyAssistant } from "@/components/study-assistant";
import { PageHeader } from "@/components/page-header";

type TopicMastery = {
  topic_id: string;
  topic_name: string;
  exam_area_name: string;
  total_attempts: number;
  mastery: number | null;
  status: "insufficient_data" | "strong" | "developing" | "needs_review";
};

type MockAttempt = {
  id: string;
  total_questions: number;
  correct_count: number;
  completed_at: string;
};

const SESSION_SIZE = 20;
const MIN_ATTEMPTS_FOR_MASTERY = 5;
const WEEKS_OF_HISTORY = 6;

function statusStyle(status: TopicMastery["status"]) {
  switch (status) {
    case "strong":
      return { bar: "bg-success", card: "border-l-4 border-l-success bg-success/5" };
    case "developing":
      return { bar: "bg-gold", card: "border-l-4 border-l-gold bg-gold/5" };
    case "needs_review":
      return { bar: "bg-destructive", card: "border-l-4 border-l-destructive bg-destructive/5" };
    default:
      return { bar: "bg-muted-foreground/40", card: "border-l-4 border-l-muted-foreground/40 bg-muted/30" };
  }
}

/** Buckets already-fetched answer rows into the last N ISO weeks and computes accuracy per week. No new query, no charting dependency. */
function weeklyAccuracy(
  rows: { answered_at: string; is_correct: boolean }[],
  weeks: number,
): { label: string; accuracy: number | null; count: number }[] {
  const now = new Date();
  const buckets: { start: Date; end: Date }[] = [];
  for (let i = weeks - 1; i >= 0; i--) {
    const end = new Date(now);
    end.setDate(end.getDate() - i * 7);
    const start = new Date(end);
    start.setDate(start.getDate() - 6);
    buckets.push({ start, end });
  }

  return buckets.map(({ start, end }) => {
    const inRange = rows.filter((r) => {
      const d = new Date(r.answered_at);
      return d >= start && d <= end;
    });
    return {
      label: `${start.getMonth() + 1}/${start.getDate()}`,
      accuracy: inRange.length ? Math.round((100 * inRange.filter((r) => r.is_correct).length) / inRange.length) : null,
      count: inRange.length,
    };
  });
}

const RECENT_WINDOW = 30;

export default async function ProgressPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: masteryRows }, { data: answeredRows }, { data: mockAttempts }, { data: allMocks }] = await Promise.all([
    supabase.rpc("get_topic_mastery"),
    supabase.from("attempt_answers").select("answered_at, is_correct").not("answered_at", "is", null),
    supabase
      .from("attempts")
      .select("id, total_questions, correct_count, completed_at")
      .eq("mode", "mock")
      .eq("status", "completed")
      .order("completed_at", { ascending: false })
      .limit(5),
    supabase
      .from("attempts")
      .select("total_questions, correct_count")
      .eq("mode", "mock")
      .eq("status", "completed"),
  ]);

  const mastery = (masteryRows ?? []) as TopicMastery[];
  const answered = (answeredRows ?? []) as { answered_at: string; is_correct: boolean }[];
  const mocks = (mockAttempts ?? []) as MockAttempt[];

  const trend = weeklyAccuracy(answered, WEEKS_OF_HISTORY);
  const hasEnoughTrendData = answered.length >= 10;

  // --- Preparation Profile: objective coverage summary, never a pass/fail prediction ---
  const questionsCompleted = answered.length;
  const overallAccuracy = questionsCompleted
    ? Math.round((100 * answered.filter((a) => a.is_correct).length) / questionsCompleted)
    : null;
  const sortedByRecent = [...answered].sort(
    (a, b) => new Date(b.answered_at).getTime() - new Date(a.answered_at).getTime(),
  );
  const recentSlice = sortedByRecent.slice(0, RECENT_WINDOW);
  const recentAccuracy = recentSlice.length
    ? Math.round((100 * recentSlice.filter((a) => a.is_correct).length) / recentSlice.length)
    : null;

  const mockTotals = (allMocks ?? []) as { total_questions: number; correct_count: number }[];
  const mockAverage = mockTotals.length
    ? Math.round(
        (100 * mockTotals.reduce((sum, m) => sum + m.correct_count, 0)) /
          mockTotals.reduce((sum, m) => sum + m.total_questions, 0),
      )
    : null;

  const scoredTopics = mastery.filter((m) => m.status !== "insufficient_data");
  const coveragePercent = mastery.length ? Math.round((100 * scoredTopics.length) / mastery.length) : null;

  const masteryDistribution = {
    strong: mastery.filter((m) => m.status === "strong").length,
    developing: mastery.filter((m) => m.status === "developing").length,
    needs_review: mastery.filter((m) => m.status === "needs_review").length,
    insufficient_data: mastery.filter((m) => m.status === "insufficient_data").length,
  };

  const weakestAreas = scoredTopics
    .filter((m) => m.status !== "strong")
    .sort((a, b) => (a.mastery ?? 0) - (b.mastery ?? 0))
    .slice(0, 3);

  const trendWithData = trend.filter((w) => w.accuracy !== null) as { label: string; accuracy: number; count: number }[];
  const recentImprovement =
    trendWithData.length >= 4
      ? Math.round(
          trendWithData.slice(-2).reduce((s, w) => s + w.accuracy, 0) / 2 -
            trendWithData.slice(0, 2).reduce((s, w) => s + w.accuracy, 0) / 2,
        )
      : null;

  return (
    <div className="mx-auto max-w-3xl space-y-8">
      <PageHeader
        title="Progress"
        description="A full breakdown of your mastery, accuracy trend, and mock exam history."
      />

      {/* Preparation Profile — objective coverage summary. Never a pass/fail prediction. */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Preparation Profile</CardTitle>
          <p className="text-xs text-muted-foreground">
            An objective summary of your coverage and accuracy so far — not a prediction of whether you&apos;ll pass.
          </p>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3">
            <div>
              <p className="text-xl font-semibold">{questionsCompleted}</p>
              <p className="text-xs text-muted-foreground">Questions completed</p>
            </div>
            <div>
              <p className="text-xl font-semibold">{overallAccuracy !== null ? `${overallAccuracy}%` : "—"}</p>
              <p className="text-xs text-muted-foreground">Overall accuracy</p>
            </div>
            <div>
              <p className="text-xl font-semibold">{recentAccuracy !== null ? `${recentAccuracy}%` : "—"}</p>
              <p className="text-xs text-muted-foreground">Recent accuracy (last {Math.min(RECENT_WINDOW, questionsCompleted)})</p>
            </div>
            <div>
              <p className="text-xl font-semibold">{mockAverage !== null ? `${mockAverage}%` : "—"}</p>
              <p className="text-xs text-muted-foreground">Mock exam average ({mockTotals.length} taken)</p>
            </div>
            <div>
              <p className="text-xl font-semibold">{coveragePercent !== null ? `${coveragePercent}%` : "—"}</p>
              <p className="text-xs text-muted-foreground">Topic coverage with enough data</p>
            </div>
            <div>
              <p className={`text-xl font-semibold ${recentImprovement !== null && recentImprovement < 0 ? "text-destructive" : ""}`}>
                {recentImprovement !== null ? `${recentImprovement > 0 ? "+" : ""}${recentImprovement}%` : "—"}
              </p>
              <p className="text-xs text-muted-foreground">Recent trend vs earlier weeks</p>
            </div>
          </div>

          <div className="mt-4 border-t pt-4">
            <p className="text-xs font-medium text-muted-foreground">Mastery distribution ({mastery.length} topics)</p>
            <div className="mt-1.5 flex flex-wrap gap-2 text-xs">
              <span className="rounded-full bg-success/15 px-2 py-0.5 text-success">{masteryDistribution.strong} strong</span>
              <span className="rounded-full bg-gold/15 px-2 py-0.5 text-gold">{masteryDistribution.developing} developing</span>
              <span className="rounded-full bg-destructive/15 px-2 py-0.5 text-destructive">{masteryDistribution.needs_review} needs review</span>
              <span className="rounded-full bg-muted px-2 py-0.5 text-muted-foreground">{masteryDistribution.insufficient_data} gathering data</span>
            </div>
          </div>

          {weakestAreas.length > 0 && (
            <div className="mt-4 border-t pt-4">
              <p className="text-xs font-medium text-muted-foreground">Weakest areas right now</p>
              <ul className="mt-1.5 space-y-1 text-sm">
                {weakestAreas.map((m) => (
                  <li key={m.topic_id} className="flex items-center justify-between">
                    <span>{m.topic_name}</span>
                    <span className="text-muted-foreground">{m.mastery}%</span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </CardContent>
      </Card>

      <StudyAssistant />

      {/* Performance trend */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Accuracy Over Time</CardTitle>
        </CardHeader>
        <CardContent>
          {hasEnoughTrendData ? (
            <div className="flex items-end gap-2" style={{ height: 120 }}>
              {trend.map((w) => (
                <div key={w.label} className="flex flex-1 flex-col items-center gap-1">
                  <div className="flex h-24 w-full items-end">
                    {w.accuracy !== null ? (
                      <div
                        className="w-full rounded-t-sm bg-primary transition-all"
                        style={{ height: `${Math.max(4, w.accuracy)}%` }}
                        title={`${w.accuracy}% (${w.count} answered)`}
                      />
                    ) : (
                      <div className="w-full rounded-t-sm bg-muted" style={{ height: "4%" }} />
                    )}
                  </div>
                  <span className="text-[10px] text-muted-foreground">{w.label}</span>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-sm text-muted-foreground">
              Keep practicing to build your performance trend — needs at least 10 answered questions across a few days.
            </p>
          )}
        </CardContent>
      </Card>

      {/* Mastery by topic */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Mastery by Topic</h2>
        <div className="mt-2 space-y-2">
          {mastery.map((m) => {
            const style = statusStyle(m.status);
            return (
            <Card key={m.topic_id} className={style.card}>
              <CardContent className="py-3">
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <p className="text-sm font-medium">{m.topic_name}</p>
                    <p className="text-xs text-muted-foreground">{m.exam_area_name}</p>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="text-sm font-medium">
                      {m.mastery !== null ? `${m.mastery}%` : "—"}
                    </span>
                    <form action={startAdaptivePracticeAttempt.bind(null, m.topic_id, SESSION_SIZE)}>
                      <Button type="submit" size="sm" variant="outline">
                        Practice →
                      </Button>
                    </form>
                  </div>
                </div>
                <div className="mt-2 h-1.5 overflow-hidden rounded-full bg-muted">
                  <div
                    className={`h-full rounded-full ${style.bar}`}
                    style={{ width: `${m.mastery ?? 8}%` }}
                  />
                </div>
                {m.status === "insufficient_data" && (
                  <p className="mt-1 text-xs text-muted-foreground">
                    Gathering data ({m.total_attempts}/{MIN_ATTEMPTS_FOR_MASTERY} answered)
                  </p>
                )}
              </CardContent>
            </Card>
            );
          })}
          {mastery.length === 0 && (
            <p className="text-sm text-muted-foreground">No topics with published content yet.</p>
          )}
        </div>
      </div>

      {/* Mock exam history */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Recent Mock Exams</h2>
        <div className="mt-2 space-y-2">
          {mocks.length > 0 ? (
            mocks.map((a) => {
              const pct = a.total_questions ? Math.round((100 * a.correct_count) / a.total_questions) : 0;
              return (
                <Card key={a.id} className="border-l-4 border-l-primary bg-primary/5">
                  <CardContent className="flex items-center justify-between gap-3 py-3">
                    <div>
                      <p className="text-sm font-medium">
                        {a.correct_count}/{a.total_questions} correct ({pct}%)
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {new Date(a.completed_at).toLocaleDateString()}
                      </p>
                    </div>
                    <Button
                      render={<Link href={`/mock/${a.id}/results`}>Review →</Link>}
                      nativeButton={false}
                      size="sm"
                      variant="outline"
                    />
                  </CardContent>
                </Card>
              );
            })
          ) : (
            <p className="text-sm text-muted-foreground">
              Your first mock exam will appear here.{" "}
              <Link href="/mock" className="text-primary hover:underline">
                Take a mock exam →
              </Link>
            </p>
          )}
        </div>
      </div>
    </div>
  );
}
