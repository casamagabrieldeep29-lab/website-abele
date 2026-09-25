import Link from "next/link";
import { redirect } from "next/navigation";
import {
  BookOpen,
  Calendar,
  CalendarClock,
  ClipboardList,
  Compass,
  Flame,
  GalleryVerticalEnd,
  Target,
  TrendingUp,
} from "lucide-react";
import { getAuthContext } from "@/lib/auth/session";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { startAdaptivePracticeAttempt, startDailyQuestion } from "@/app/practice/actions";
import { startFlashcardsByTopic } from "@/app/flashcards/actions";
import { pickDailyQuestionId, todayStartIso } from "@/lib/daily-question";
import { ACHIEVEMENTS } from "@/lib/achievements";
import { computeStudyStats, fetchAllAnsweredRows, type TopicMasteryRow } from "@/lib/study-stats";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { BOARD_EXAM_DATE_LABEL, daysUntilBoardExam } from "@/lib/board-exam";
import { StatCard } from "@/components/stat-card";
import type { PlanDay } from "@/app/study-plan/actions";

type TopicMastery = TopicMasteryRow;

type RecentAttempt = {
  id: string;
  mode: "practice" | "mock";
  status: string;
  total_questions: number;
  correct_count: number;
  completed_at: string | null;
  topics: { name: string } | null;
};

const SESSION_SIZE = 20;
const MIN_QUESTIONS_FOR_SESSION = 5;
const MIN_ATTEMPTS_FOR_MASTERY = 5;

function daysSince(iso: string | null): number {
  if (!iso) return 999;
  return Math.floor((Date.now() - new Date(iso).getTime()) / (1000 * 60 * 60 * 24));
}

function greeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return "Good morning";
  if (hour < 18) return "Good afternoon";
  return "Good evening";
}

/**
 * priority = (100 - effective_mastery) + min(days_since_last_practiced, 14)*2
 *            + (insufficient_data bonus)
 * Documented in 26_BUILD_CHECKLIST.md / the approved plan — not random.
 * Topics never practiced (or with too little data to score) get pushed to
 * the front so the group actually builds baseline mastery data over time.
 */
function recommendationPriority(m: TopicMastery): number {
  const effectiveMastery = m.mastery ?? 50;
  const recencyDays = Math.min(daysSince(m.last_answered_at), 14);
  const insufficientBonus = m.status === "insufficient_data" ? 15 : 0;
  return (100 - effectiveMastery) + recencyDays * 2 + insufficientBonus;
}

function statusLabel(status: TopicMastery["status"]) {
  switch (status) {
    case "strong":
      return {
        text: "Strong",
        dot: "bg-success",
        className: "bg-success/15 text-success",
        card: "border-l-4 border-l-success bg-success/5",
      };
    case "developing":
      return {
        text: "Developing",
        dot: "bg-gold",
        className: "bg-gold/15 text-gold",
        card: "border-l-4 border-l-gold bg-gold/5",
      };
    case "needs_review":
      return {
        text: "Needs Review",
        dot: "bg-destructive",
        className: "bg-destructive/15 text-destructive",
        card: "border-l-4 border-l-destructive bg-destructive/5",
      };
    default:
      return {
        text: "Gathering data",
        dot: "bg-muted-foreground",
        className: "bg-muted text-muted-foreground",
        card: "border-l-4 border-l-muted-foreground/40 bg-muted/30",
      };
  }
}

export default async function DashboardPage() {
  const { supabase, user, profile } = await getAuthContext();
  if (!user) redirect("/login");

  const [
    { data: masteryRows },
    { data: publishedQuestions },
    { data: answeredRows },
    { count: mistakeCount },
    { data: recentAttempts },
    { data: todaysDailyAttempt },
    { data: earnedAchievements },
    { data: studyPlan },
  ] = await Promise.all([
    supabase.rpc("get_topic_mastery"),
    // student_questions now has 1800+ published rows — a plain `.select()`
    // would silently cap at PostgREST's 1000-row default and truncate the
    // per-topic published-question-count map below. Paginated via
    // fetchAllRows, same reasoning as fetchAllAnsweredRows in study-stats.ts.
    fetchAllRows<{ id: string; topic_id: string }>((from, to) =>
      supabase.from("student_questions").select("id, topic_id").order("id").range(from, to),
    ).then((data) => ({ data })),
    // attempt_answers grows unbounded per active user — same 1000-row cap
    // risk, already fixed for this exact query in study-stats.ts.
    fetchAllAnsweredRows(supabase, user.id).then((data) => ({ data })),
    supabase.rpc("get_mistake_bank").then((r) => ({ count: r.data?.length ?? 0, error: r.error })),
    supabase
      .from("attempts")
      .select("id, mode, status, total_questions, correct_count, completed_at, topics(name)")
      .eq("user_id", user.id)
      .eq("status", "completed")
      .order("completed_at", { ascending: false })
      .limit(3),
    supabase
      .from("attempts")
      .select("id, status")
      .eq("user_id", user.id)
      .contains("config", { kind: "daily" })
      .gte("started_at", todayStartIso())
      .maybeSingle(),
    supabase.from("user_achievements").select("achievement_code").eq("user_id", user.id),
    supabase.from("study_plans").select("generated_plan").eq("user_id", user.id).maybeSingle(),
  ]);

  const mastery = (masteryRows ?? []) as TopicMastery[];
  const recent = (recentAttempts ?? []) as unknown as RecentAttempt[];

  const publishedCountByTopic = new Map<string, number>();
  for (const q of publishedQuestions ?? []) {
    publishedCountByTopic.set(q.topic_id, (publishedCountByTopic.get(q.topic_id) ?? 0) + 1);
  }

  // --- Real analytics — shared calculation, see src/lib/study-stats.ts.
  // Profile shows the same numbers from the same computeStudyStats() call. ---
  const answered = answeredRows ?? [];
  const { questionsAnswered, overallAccuracy, streak, studiedLast7 } = computeStudyStats(
    mastery,
    answered,
    profile?.current_streak ?? 0,
  );

  const scoredTopics = mastery.filter((m) => m.status !== "insufficient_data");
  const avgMastery = scoredTopics.length
    ? Math.round(scoredTopics.reduce((sum, m) => sum + (m.mastery ?? 0), 0) / scoredTopics.length)
    : null;

  // --- Today's Recommendation ---
  const eligibleForSession = mastery.filter(
    (m) => (publishedCountByTopic.get(m.topic_id) ?? 0) >= MIN_QUESTIONS_FOR_SESSION,
  );
  const recommendation = eligibleForSession.length
    ? eligibleForSession.reduce((best, m) =>
        recommendationPriority(m) > recommendationPriority(best) ? m : best,
      )
    : null;

  // --- Least Mastered Areas ---
  const leastMastered = scoredTopics
    .slice()
    .sort((a, b) => (a.mastery ?? 0) - (b.mastery ?? 0))
    .slice(0, 3);

  // --- Question of the Day ---
  const todaysQuestionId = pickDailyQuestionId((publishedQuestions ?? []).map((q) => q.id));
  const dailyAnsweredToday = todaysDailyAttempt?.status === "completed";
  let dailyStats: { total_answers: number; correct_count: number } | null = null;
  if (dailyAnsweredToday && todaysQuestionId) {
    const { data } = await supabase.rpc("get_daily_question_stats", {
      p_question_id: todaysQuestionId,
      p_since: todayStartIso(),
    });
    dailyStats = data?.[0] ?? null;
  }
  const MIN_RESPONSES_FOR_DAILY_STAT = 5;

  const earnedCodes = new Set((earnedAchievements ?? []).map((a) => a.achievement_code));

  // --- Upcoming Study Plan — same generated_plan data /study-plan reads,
  // just the next 3 sessions from today rather than the full 2-week view. ---
  const planDays = (studyPlan?.generated_plan ?? []) as PlanDay[];
  const upcomingPlanDays = planDays.filter((d) => d.date >= new Date().toISOString().slice(0, 10)).slice(0, 3);

  const displayName = profile?.display_name || user.email?.split("@")[0] || "there";
  const examDaysLeft = daysUntilBoardExam();

  return (
    <div className="mx-auto max-w-5xl space-y-8">
      {/* Hero */}
      <div className="dashboard-hero">
        {examDaysLeft >= 0 && (
          <div className="mb-3 inline-flex items-center gap-2 rounded-full border border-primary/20 bg-primary/10 px-3 py-1 text-primary">
            <Calendar className="size-3.5" />
            <span className="text-sm font-semibold">{examDaysLeft} days</span>
            <span className="text-xs text-primary/80">to the ABE Board Exam · {BOARD_EXAM_DATE_LABEL}</span>
          </div>
        )}
        <h1 className="text-2xl font-bold tracking-tight sm:text-3xl">
          {greeting()}, {displayName} 👋
        </h1>
        <p className="mt-1 text-muted-foreground">
          {questionsAnswered > 0
            ? `You've answered ${questionsAnswered} question${questionsAnswered === 1 ? "" : "s"} so far. Ready for today's review?`
            : "Ready to start your first review session?"}
        </p>
      </div>

      {/* Quick jump row */}
      <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
        {recommendation ? (
          <form action={startAdaptivePracticeAttempt.bind(null, recommendation.topic_id, SESSION_SIZE)} className="contents">
            <button type="submit" className="block h-full text-left">
              <Card className="h-full transition-colors hover:border-primary/50">
                <CardContent className="py-4">
                  <div className="flex size-9 items-center justify-center rounded-md bg-primary/15 text-primary glow-primary">
                    <Target className="size-4.5" />
                  </div>
                  <p className="mt-2.5 text-sm font-semibold">Continue Studying</p>
                  <p className="text-xs text-muted-foreground">Pick up where you left off</p>
                </CardContent>
              </Card>
            </button>
          </form>
        ) : (
          <Link href="/practice" className="block">
            <Card className="h-full transition-colors hover:border-primary/50">
              <CardContent className="py-4">
                <div className="flex size-9 items-center justify-center rounded-md bg-primary/15 text-primary glow-primary">
                  <Target className="size-4.5" />
                </div>
                <p className="mt-2.5 text-sm font-semibold">Continue Studying</p>
                <p className="text-xs text-muted-foreground">Pick up where you left off</p>
              </CardContent>
            </Card>
          </Link>
        )}

        {[
          { href: "/question-bank", icon: Compass, label: "TOS", description: "Explore the curriculum" },
          { href: "/practice", icon: BookOpen, label: "Practice", description: "Sharpen your skills" },
          { href: "/flashcards", icon: GalleryVerticalEnd, label: "Flashcards", description: "Build your memory" },
          { href: "/mock", icon: ClipboardList, label: "Mock Exams", description: "Test your knowledge" },
        ].map((item) => (
          <Link key={item.label} href={item.href} className="block">
            <Card className="h-full transition-colors hover:border-primary/50">
              <CardContent className="py-4">
                <div className="flex size-9 items-center justify-center rounded-md bg-primary/15 text-primary glow-primary">
                  <item.icon className="size-4.5" />
                </div>
                <p className="mt-2.5 text-sm font-semibold">{item.label}</p>
                <p className="text-xs text-muted-foreground">{item.description}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>

      {/* Question of the Day */}
      {todaysQuestionId && (
        <Card className="border-l-4 border-l-gold bg-gold/5">
          <CardContent className="flex items-center justify-between gap-3 py-4">
            <div>
              <p className="flex items-center gap-1.5 text-sm font-medium">
                <Calendar className="size-4" /> Question of the Day
              </p>
              {dailyAnsweredToday ? (
                <p className="text-xs text-muted-foreground">
                  You&apos;ve answered today&apos;s question.{" "}
                  {dailyStats && dailyStats.total_answers >= MIN_RESPONSES_FOR_DAILY_STAT
                    ? `${Math.round((100 * dailyStats.correct_count) / dailyStats.total_answers)}% of reviewees answered correctly.`
                    : "Not enough responses yet for a group stat."}
                </p>
              ) : (
                <p className="text-xs text-muted-foreground">One question, shared by everyone today.</p>
              )}
            </div>
            {dailyAnsweredToday ? (
              <Button render={<Link href={`/practice/${todaysDailyAttempt!.id}`}>Review →</Link>} nativeButton={false} size="sm" variant="outline" />
            ) : (
              <form action={startDailyQuestion}>
                <Button type="submit" size="sm">
                  Answer →
                </Button>
              </form>
            )}
          </CardContent>
        </Card>
      )}

      {/* Today's Recommendation — the primary CTA */}
      {recommendation ? (
        <Card className="border-primary/30 bg-gradient-to-br from-primary/5 to-transparent">
          <CardContent className="py-5">
            <div className="flex items-center gap-2 text-xs font-medium uppercase tracking-wide text-primary">
              <Target className="size-3.5" />
              Your next study session
            </div>
            <h2 className="mt-2 text-xl font-semibold">{recommendation.topic_name}</h2>
            <p className="text-sm text-muted-foreground">{recommendation.exam_area_name}</p>
            <div className="mt-3 flex flex-wrap items-center gap-4 text-sm text-muted-foreground">
              <span>
                Mastery:{" "}
                <strong className="text-foreground">
                  {recommendation.mastery !== null ? `${recommendation.mastery}%` : "still gathering data"}
                </strong>
              </span>
              <span>
                Last practiced:{" "}
                <strong className="text-foreground">
                  {recommendation.last_answered_at ? `${daysSince(recommendation.last_answered_at)}d ago` : "never"}
                </strong>
              </span>
              {/* Estimated from SESSION_SIZE, not the pool-clamped actual
                  count, so a topic with fewer than 20 published questions
                  never has that discrepancy shown to the student. */}
              <span>~{Math.round(SESSION_SIZE * 1.2)} min</span>
            </div>
            <div className="mt-4 flex flex-wrap items-center gap-2">
              <form action={startAdaptivePracticeAttempt.bind(null, recommendation.topic_id, SESSION_SIZE)}>
                <Button type="submit" size="lg">
                  Start session →
                </Button>
              </form>
              <form action={startFlashcardsByTopic.bind(null, recommendation.topic_id)}>
                <Button type="submit" variant="outline" size="sm">
                  Flashcards
                </Button>
              </form>
              <Button
                render={<Link href={`/reviewers?q=${encodeURIComponent(recommendation.topic_name)}`}>Reviewers</Link>}
                nativeButton={false}
                variant="outline"
                size="sm"
              />
              <Button render={<Link href="/mistakes">My Mistakes</Link>} nativeButton={false} variant="outline" size="sm" />
            </div>
          </CardContent>
        </Card>
      ) : (
        <Card>
          <CardContent className="py-5 text-sm text-muted-foreground">
            Not enough published questions yet in any topic to recommend a session (need at least {MIN_QUESTIONS_FOR_SESSION}).
          </CardContent>
        </Card>
      )}

      {/* Compact progress row */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Your Progress</h2>
        <div className="mt-2 grid grid-cols-2 gap-3 sm:grid-cols-4">
          <StatCard icon={BookOpen} label="Questions answered" value={String(questionsAnswered)} accent="primary" />
          <StatCard
            icon={Target}
            label="Overall accuracy"
            value={overallAccuracy !== null ? `${overallAccuracy}%` : "—"}
            barPercent={overallAccuracy}
            accent="secondary"
          />
          <StatCard
            icon={TrendingUp}
            label="Average mastery"
            value={avgMastery !== null ? `${avgMastery}%` : "—"}
            barPercent={avgMastery}
            accent="secondary"
          />
          <StatCard icon={Flame} label="Day streak" value={String(streak)} accent="gold" />
        </div>
        {streak > 0 && (
          <p className="mt-2 flex items-center gap-1.5 text-xs text-muted-foreground">
            <Flame className="size-3.5 text-gold" /> {streak} day streak — you&apos;ve reviewed {studiedLast7} of
            the last 7 days.
          </p>
        )}
      </div>

      {/* Least Mastered Areas */}
      <div>
        <div className="flex items-center justify-between">
          <h2 className="text-sm font-semibold text-muted-foreground">Needs Your Attention</h2>
          <Link href="/progress" className="text-xs text-primary hover:underline">
            View all →
          </Link>
        </div>
        {leastMastered.length > 0 ? (
          <div className="mt-2 grid gap-2 sm:grid-cols-3">
            {leastMastered.map((m) => {
              const label = statusLabel(m.status);
              return (
                <Card key={m.topic_id} className={label.card}>
                  <CardContent className="py-3">
                    <div className="flex items-center gap-1.5">
                      <span className={`size-1.5 rounded-full ${label.dot}`} />
                      <span className={`rounded-full px-1.5 py-0.5 text-[10px] font-medium ${label.className}`}>
                        {label.text}
                      </span>
                    </div>
                    <p className="mt-1.5 text-sm font-medium">{m.topic_name}</p>
                    <p className="text-xs text-muted-foreground">
                      {m.mastery}% mastery · {m.total_attempts} attempted
                    </p>
                    <div className="mt-2 flex gap-1.5">
                      <form action={startAdaptivePracticeAttempt.bind(null, m.topic_id, SESSION_SIZE)} className="flex-1">
                        <Button type="submit" size="sm" variant="outline" className="w-full">
                          Practice →
                        </Button>
                      </form>
                      <form action={startFlashcardsByTopic.bind(null, m.topic_id)}>
                        <Button type="submit" size="sm" variant="ghost" title="Flashcards for this topic">
                          <GalleryVerticalEnd className="size-4" />
                        </Button>
                      </form>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        ) : (
          <p className="mt-2 text-sm text-muted-foreground">
            Mastery estimates need at least {MIN_ATTEMPTS_FOR_MASTERY} answered questions per topic — keep practicing and this will fill in.
          </p>
        )}
      </div>

      {/* Upcoming Study Plan */}
      {upcomingPlanDays.length > 0 && (
        <div>
          <div className="flex items-center justify-between">
            <h2 className="text-sm font-semibold text-muted-foreground">Upcoming Study Plan</h2>
            <Link href="/study-plan" className="text-xs text-primary hover:underline">
              View all →
            </Link>
          </div>
          <div className="mt-2 space-y-2">
            {upcomingPlanDays.map((d) => (
              <Card key={d.date}>
                <CardContent className="flex items-center justify-between gap-3 py-3">
                  <div className="flex items-center gap-3">
                    <div className="flex size-9 shrink-0 flex-col items-center justify-center rounded-md bg-secondary text-secondary-foreground">
                      <CalendarClock className="size-4" />
                    </div>
                    <div>
                      <p className="text-xs text-muted-foreground">
                        {new Date(d.date).toLocaleDateString(undefined, { weekday: "short", month: "short", day: "numeric" })}
                      </p>
                      <p className="text-sm font-medium">{d.activity}</p>
                    </div>
                  </div>
                  {d.topicId ? (
                    <form action={startAdaptivePracticeAttempt.bind(null, d.topicId, SESSION_SIZE)}>
                      <Button type="submit" size="sm" variant="outline">
                        Start →
                      </Button>
                    </form>
                  ) : (
                    <Button
                      render={<Link href={d.href ?? "/study-plan"}>Start →</Link>}
                      nativeButton={false}
                      size="sm"
                      variant="outline"
                    />
                  )}
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      )}

      {/* Recent Activity */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Recent Activity</h2>
        <div className="mt-2 space-y-2">
          {recent.length > 0 ? (
            recent.map((a) => {
              const label = a.mode === "mock" ? "Mock Exam" : a.topics?.name ?? "Practice session";
              const href = a.mode === "mock" ? `/mock/${a.id}/results` : `/practice/${a.id}`;
              const cardAccent = a.mode === "mock" ? "border-l-4 border-l-primary bg-primary/5" : "border-l-4 border-l-border bg-secondary/40";
              return (
                <Card key={a.id} className={cardAccent}>
                  <CardContent className="flex items-center justify-between gap-3 py-3">
                    <div>
                      <p className="text-sm font-medium">{label}</p>
                      <p className="text-xs text-muted-foreground">
                        {a.correct_count}/{a.total_questions} correct
                      </p>
                    </div>
                    <Button render={<Link href={href}>Review →</Link>} nativeButton={false} size="sm" variant="outline" />
                  </CardContent>
                </Card>
              );
            })
          ) : (
            <p className="text-sm text-muted-foreground">
              Your recent practice and mock exam sessions will show up here.
            </p>
          )}
          {mistakeCount! > 0 && (
            <Card className="border-l-4 border-l-destructive bg-destructive/5">
              <CardContent className="flex items-center justify-between gap-3 py-3">
                <div>
                  <p className="text-sm font-medium">Mistake Bank</p>
                  <p className="text-xs text-muted-foreground">
                    {mistakeCount} question{mistakeCount === 1 ? "" : "s"} waiting for review
                  </p>
                </div>
                <Button render={<Link href="/mistakes">Review →</Link>} nativeButton={false} size="sm" variant="outline" />
              </CardContent>
            </Card>
          )}
        </div>
      </div>

      {/* Quick Access */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Quick Access</h2>
        <div className="mt-2 flex flex-wrap gap-2">
          <Button render={<Link href="/quick">Quick 10</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/quiz-builder">Custom Quiz</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/mock">Mock Exam</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/mistakes">Mistake Bank</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/notes">My Notes</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/question-bank">Question Bank</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/flashcards">Flashcards</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/reviewers">Reviewers</Link>} nativeButton={false} variant="secondary" size="sm" />
          <Button render={<Link href="/study-plan">Study Plan</Link>} nativeButton={false} variant="secondary" size="sm" />
        </div>
      </div>

      {/* Achievements */}
      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Achievements</h2>
        <div className="mt-2 flex flex-wrap gap-2">
          {Object.entries(ACHIEVEMENTS).map(([code, a]) => {
            const earned = earnedCodes.has(code);
            return (
              <span
                key={code}
                title={a.description}
                className={`flex items-center gap-1.5 rounded-full border px-2.5 py-1 text-xs font-medium ${
                  earned ? "border-gold/30 bg-gold/10 text-gold" : "border-border text-muted-foreground opacity-50"
                }`}
              >
                <a.icon className="size-3.5" />
                {a.label}
              </span>
            );
          })}
        </div>
      </div>

      <p className="text-xs text-muted-foreground">
        Mastery and recommendations are computed from your own answer history only — scores marked &quot;gathering
        data&quot; mean fewer than {MIN_ATTEMPTS_FOR_MASTERY} answered questions in that topic, not a real percentage.
      </p>
    </div>
  );
}
