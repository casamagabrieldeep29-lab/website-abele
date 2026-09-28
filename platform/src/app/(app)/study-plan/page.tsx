import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { generateStudyPlan, type PlanDay } from "@/app/study-plan/actions";
import { startAdaptivePracticeAttempt } from "@/app/practice/actions";
import { getUserSettings } from "@/lib/study-preferences";
import { PageHeader } from "@/components/page-header";
import { PageContainer } from "@/components/page-container";

const WEEKDAY_OPTIONS = [
  { value: "mon", label: "Mon" },
  { value: "tue", label: "Tue" },
  { value: "wed", label: "Wed" },
  { value: "thu", label: "Thu" },
  { value: "fri", label: "Fri" },
  { value: "sat", label: "Sat" },
  { value: "sun", label: "Sun" },
];

const SESSION_SIZE = 20;

function daysUntil(dateStr: string): number {
  return Math.ceil((new Date(dateStr).getTime() - Date.now()) / (24 * 60 * 60 * 1000));
}

export default async function StudyPlanPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: plan }, settings] = await Promise.all([
    supabase
      .from("study_plans")
      .select("target_exam_date, study_days, minutes_per_day, generated_plan")
      .eq("user_id", user.id)
      .maybeSingle(),
    getUserSettings(supabase, user.id),
  ]);

  const days = (plan?.generated_plan ?? []) as PlanDay[];
  const upcoming = days.filter((d) => d.date >= new Date().toISOString().slice(0, 10)).slice(0, 14);

  const examDateForSummary = plan?.target_exam_date ?? settings.targetExamDate ?? null;
  const daysUntilExam = examDateForSummary ? daysUntil(examDateForSummary) : null;
  const chosenDayLabels = WEEKDAY_OPTIONS.filter((d) => plan?.study_days?.includes(d.value)).map((d) => d.label);

  return (
    <PageContainer size="wide" className="space-y-6">
      <PageHeader
        title="Study Plan"
        description="A schedule built around your actual weak areas — regenerate anytime as your mastery changes."
      />

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-[420px_1fr]">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">{plan ? "Update your plan" : "Set up your plan"}</CardTitle>
            <CardDescription>
              Regenerating replaces your current plan and re-checks your latest mastery data.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form action={generateStudyPlan} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="targetExamDate">Target exam date</Label>
                <input
                  id="targetExamDate"
                  name="targetExamDate"
                  type="date"
                  required
                  defaultValue={plan?.target_exam_date ?? settings.targetExamDate ?? undefined}
                  className="w-full max-w-xs rounded-md border border-border bg-background px-3 py-2 text-sm"
                />
              </div>

              <div className="space-y-2">
                <Label>Study days</Label>
                <div className="flex flex-wrap gap-3">
                  {WEEKDAY_OPTIONS.map((d) => (
                    <label key={d.value} className="flex items-center gap-1.5 text-sm">
                      <input
                        type="checkbox"
                        name="studyDays"
                        value={d.value}
                        defaultChecked={plan?.study_days?.includes(d.value) ?? ["mon", "wed", "fri", "sat"].includes(d.value)}
                        className="h-4 w-4 rounded border-border"
                      />
                      {d.label}
                    </label>
                  ))}
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="minutesPerDay">Minutes per day</Label>
                <input
                  id="minutesPerDay"
                  name="minutesPerDay"
                  type="number"
                  min={15}
                  max={240}
                  defaultValue={plan?.minutes_per_day ?? 60}
                  className="w-full max-w-32 rounded-md border border-border bg-background px-3 py-2 text-sm"
                />
              </div>

              {error === "missing-fields" && (
                <p className="text-sm text-destructive">Pick a target date and at least one study day.</p>
              )}

              <Button type="submit" className="w-full">
                {plan ? "Regenerate plan" : "Generate plan"}
              </Button>
            </form>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Plan overview</CardTitle>
            <CardDescription>
              {plan ? "What your current plan is set up to do." : "Set up your plan on the left to see it here."}
            </CardDescription>
          </CardHeader>
          <CardContent>
            {plan ? (
              <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
                <div>
                  <p className="text-xs text-muted-foreground">Target exam date</p>
                  <p className="mt-1 text-lg font-semibold">
                    {new Date(plan.target_exam_date).toLocaleDateString(undefined, { month: "short", day: "numeric", year: "numeric" })}
                  </p>
                  {daysUntilExam !== null && (
                    <p className="text-xs text-muted-foreground">
                      {daysUntilExam > 0 ? `${daysUntilExam} days away` : "Today or past"}
                    </p>
                  )}
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Study days</p>
                  <p className="mt-1 text-lg font-semibold">{chosenDayLabels.length} / week</p>
                  <p className="text-xs text-muted-foreground">{chosenDayLabels.join(", ") || "None selected"}</p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Minutes per day</p>
                  <p className="mt-1 text-lg font-semibold">{plan.minutes_per_day}</p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Sessions scheduled</p>
                  <p className="mt-1 text-lg font-semibold">{days.length}</p>
                  <p className="text-xs text-muted-foreground">{upcoming.length} in the next 2 weeks</p>
                </div>
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">No plan yet — fill out the form to generate one.</p>
            )}
          </CardContent>
        </Card>
      </div>

      {plan && (
        <div>
          <h2 className="text-sm font-semibold text-muted-foreground">Next 2 weeks</h2>
          <div className="mt-2 grid grid-cols-1 gap-3 md:grid-cols-2 xl:grid-cols-3">
            {upcoming.map((d) => (
              <Card key={d.date}>
                <CardContent className="flex items-center justify-between gap-3 py-3">
                  <div className="min-w-0">
                    <p className="text-xs text-muted-foreground">
                      {new Date(d.date).toLocaleDateString(undefined, { weekday: "short", month: "short", day: "numeric" })}
                    </p>
                    <p className="truncate text-sm font-medium">{d.activity}</p>
                  </div>
                  {d.topicId ? (
                    <form action={startAdaptivePracticeAttempt.bind(null, d.topicId, SESSION_SIZE)}>
                      <Button type="submit" size="sm" variant="outline" className="shrink-0">
                        Start →
                      </Button>
                    </form>
                  ) : (
                    <Button
                      render={<Link href={d.href ?? "/dashboard"}>Start →</Link>}
                      nativeButton={false}
                      size="sm"
                      variant="outline"
                      className="shrink-0"
                    />
                  )}
                </CardContent>
              </Card>
            ))}
            {upcoming.length === 0 && (
              <p className="text-sm text-muted-foreground">
                Your plan has no sessions between now and your exam date on the selected days.
              </p>
            )}
          </div>
        </div>
      )}
    </PageContainer>
  );
}
