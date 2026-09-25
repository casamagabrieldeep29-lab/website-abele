import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { fetchAllAnsweredRows } from "@/lib/study-stats";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { StudyAssistant } from "@/components/study-assistant";
import { PageHeader } from "@/components/page-header";
import { MasteryTree, type MasteryStatus, type MasteryTOS } from "./mastery-tree";

type TopicMastery = {
  topic_id: string;
  topic_name: string;
  exam_area_id: string;
  exam_area_name: string;
  subject_id: string | null;
  subject_name: string | null;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: MasteryStatus;
};

type MockAttempt = {
  id: string;
  total_questions: number;
  correct_count: number;
  completed_at: string;
};

const WEEKS_OF_HISTORY = 6;

/** Simple mean of the already-computed per-topic mastery numbers — no separate calculation system, just an aggregation of get_topic_mastery()'s own output. Topics without enough data yet (mastery === null) are excluded rather than counted as 0. */
function avgMastery(rows: { mastery: number | null }[]): number | null {
  const scored = rows.filter((r) => r.mastery !== null).map((r) => r.mastery as number);
  if (scored.length === 0) return null;
  return Math.round(scored.reduce((sum, m) => sum + m, 0) / scored.length);
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

  const [{ data: masteryRows }, answeredRows, { data: mockAttempts }, { data: allMocks }, { data: examAreas }, { data: subjects }] =
    await Promise.all([
      supabase.rpc("get_topic_mastery"),
      // Paginated — a plain `.select()` here silently caps at 1000 rows once
      // total answered questions across the account passes 1000, which
      // would truncate the accuracy trend and Preparation Profile stats
      // below. See study-stats.ts.
      fetchAllAnsweredRows(supabase, user.id),
      supabase
        .from("attempts")
        .select("id, total_questions, correct_count, completed_at")
        .eq("user_id", user.id)
        .eq("mode", "mock")
        .eq("status", "completed")
        .order("completed_at", { ascending: false })
        .limit(5),
      supabase
        .from("attempts")
        .select("total_questions, correct_count")
        .eq("user_id", user.id)
        .eq("mode", "mock")
        .eq("status", "completed"),
      supabase.from("exam_areas").select("id, name, weight_percent, sort_order").order("sort_order"),
      supabase.from("subjects").select("id, exam_area_id, name, sort_order").order("sort_order"),
    ]);

  const mastery = (masteryRows ?? []) as TopicMastery[];
  const answered = (answeredRows ?? []) as { answered_at: string; is_correct: boolean }[];

  // --- Mastery by TOS: same get_topic_mastery() rows, regrouped under the
  // official TOS -> Subject hierarchy instead of a flat list. A topic whose
  // subject_id hasn't been assigned yet (see supabase/patches/013_official_
  // subjects.sql) falls into an "Other Topics" bucket for its TOS rather
  // than disappearing or being force-fit into the wrong subject. ---
  const subjectDefs = (subjects ?? []) as { id: string; exam_area_id: string; name: string; sort_order: number }[];
  const subjectDefsByArea = new Map<string, typeof subjectDefs>();
  for (const s of subjectDefs) {
    const list = subjectDefsByArea.get(s.exam_area_id) ?? [];
    list.push(s);
    subjectDefsByArea.set(s.exam_area_id, list);
  }

  const topicsBySubject = new Map<string, TopicMastery[]>();
  const unmappedTopicsByArea = new Map<string, TopicMastery[]>();
  for (const m of mastery) {
    if (m.subject_id) {
      const list = topicsBySubject.get(m.subject_id) ?? [];
      list.push(m);
      topicsBySubject.set(m.subject_id, list);
    } else {
      const list = unmappedTopicsByArea.get(m.exam_area_id) ?? [];
      list.push(m);
      unmappedTopicsByArea.set(m.exam_area_id, list);
    }
  }

  function toTreeTopic(m: TopicMastery) {
    return {
      id: m.topic_id,
      name: m.topic_name,
      mastery: m.mastery,
      status: m.status,
      totalAttempts: m.total_attempts,
      overallAccuracy: m.overall_accuracy,
      recentAccuracy: m.recent_accuracy,
    };
  }

  const tosList: MasteryTOS[] = (examAreas ?? []).map((area) => {
    const subjectNodes = subjectDefsByArea.get(area.id)?.map((s) => {
      const topics = (topicsBySubject.get(s.id) ?? []).map(toTreeTopic);
      return { id: s.id, name: s.name, mastery: avgMastery(topics), topics };
    }) ?? [];

    const unmapped = unmappedTopicsByArea.get(area.id) ?? [];
    if (unmapped.length > 0) {
      const topics = unmapped.map(toTreeTopic);
      subjectNodes.push({ id: `other:${area.id}`, name: "Other Topics", mastery: avgMastery(topics), topics });
    }

    const allTopicsInArea = subjectNodes.flatMap((s) => s.topics);
    return {
      id: area.id,
      name: area.name,
      weightPercent: area.weight_percent,
      mastery: avgMastery(allTopicsInArea),
      subjects: subjectNodes,
    };
  });
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
    <div className="mx-auto w-full max-w-5xl space-y-6">
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
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-6">
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

      {mastery.length === 0 ? (
        <div>
          <h2 className="text-sm font-semibold text-muted-foreground">Mastery by TOS</h2>
          <p className="mt-2 text-sm text-muted-foreground">No topics with published content yet.</p>
        </div>
      ) : (
        <MasteryTree tos={tosList} />
      )}

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
