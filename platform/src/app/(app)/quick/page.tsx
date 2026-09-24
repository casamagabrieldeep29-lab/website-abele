import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { startQuickPractice } from "@/app/practice/actions";
import { getUserSettings, PRACTICE_LENGTH_OPTIONS, PRACTICE_MODE_OPTIONS } from "@/lib/study-preferences";
import { PageHeader } from "@/components/page-header";

const MINUTES_PER_QUESTION = 1.2; // rough board-exam pace estimate, not a hard timer

export default async function QuickPracticePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ count: totalPublished }, settings] = await Promise.all([
    supabase.from("student_questions").select("id", { count: "exact", head: true }),
    getUserSettings(supabase, user.id),
  ]);

  const modeLabel = PRACTICE_MODE_OPTIONS.find((m) => m.value === settings.defaultPracticeMode)?.label ?? "Mixed";

  return (
    <div className="mx-auto max-w-md">
      <PageHeader
        title="Quick Practice"
        description={
          <>
            For when you only have a few minutes. Uses your default practice mode —{" "}
            <strong className="text-foreground">{modeLabel}</strong> — mixed with variety as needed.{" "}
            <Link href="/settings" className="text-primary hover:underline">
              Change in Settings
            </Link>
            .
          </>
        }
      />

      <div className="mt-6 space-y-3">
        {PRACTICE_LENGTH_OPTIONS.map((n) => {
          const available = totalPublished ?? 0;
          const disabled = available === 0;
          // Always estimated from the chosen length (n), not the pool-
          // clamped actual count — a smaller number here would otherwise
          // quietly disclose that the question bank has fewer than n
          // published questions available.
          const minutes = Math.round(n * MINUTES_PER_QUESTION);
          const isDefault = settings.defaultPracticeLength === n;
          return (
            <Card key={n}>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  Quick {n}
                  {isDefault && <Badge variant="secondary">Your default</Badge>}
                </CardTitle>
                <CardDescription>{disabled ? "No published questions available yet" : `About ${minutes} min`}</CardDescription>
              </CardHeader>
              <CardContent>
                <form action={startQuickPractice.bind(null, n, settings.defaultPracticeMode)}>
                  <Button type="submit" disabled={disabled} className="w-full">
                    Start
                  </Button>
                </form>
              </CardContent>
            </Card>
          );
        })}
      </div>
    </div>
  );
}
