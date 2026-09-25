import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import { startPaesQuizAttempt } from "@/app/practice/actions";
import { PRACTICE_LENGTH_OPTIONS } from "@/lib/study-preferences";

const QUICKFIRE_COUNT = 10;
const QUICKFIRE_SECONDS = 18;
const PAES_50_COUNT = 50;

/**
 * Phase 2 PAES Quizzer setup: three modes, all going through
 * startPaesQuizAttempt into the Kahoot-style /paes/[attemptId] session.
 *
 * - Quickfire: fixed 10 questions, 18s/question — speed pressure.
 * - PAES 50: fixed 50 questions, untimed — volume recall, not speed.
 * - Specialized/Mixed: the original Phase 1 count-picker (+ optional
 *   ?paes= single-reference filter), untimed — study mode.
 */
export default async function PaesQuizPage({
  searchParams,
}: {
  searchParams: Promise<{ paes?: string }>;
}) {
  const { paes } = await searchParams;
  const paesReference = paes?.trim() || undefined;

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  let query = supabase.from("student_questions").select("id", { count: "exact", head: true }).eq("is_paes", true);
  if (paesReference) query = query.ilike("paes_reference", `${paesReference}%`);
  const { count: available } = await query;
  const pool = available ?? 0;
  const disabled = pool === 0;

  return (
    <div className="mx-auto max-w-2xl">
      <PageHeader
        title="PAES Quizzer"
        description={
          paesReference ? (
            <>
              Scoped to <strong className="text-foreground">{paesReference}</strong>.{" "}
              <Link href="/paes/quiz" className="text-primary hover:underline">
                Clear filter
              </Link>
            </>
          ) : (
            "Pick a mode and take a scored, Kahoot-style quiz pooled from published PAES-tagged questions."
          )
        }
      />

      {paesReference && (
        <div className="mt-3">
          <Badge variant="secondary">{paesReference}</Badge>
        </div>
      )}

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle>Quickfire</CardTitle>
            <CardDescription>
              {disabled
                ? "No published PAES questions available yet"
                : `${Math.min(QUICKFIRE_COUNT, pool)} of ${pool} available · ${QUICKFIRE_SECONDS}s per question`}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form action={startPaesQuizAttempt.bind(null, QUICKFIRE_COUNT, paesReference, QUICKFIRE_SECONDS)}>
              <Button type="submit" disabled={disabled} className="w-full">
                Start Quickfire
              </Button>
            </form>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>PAES 50</CardTitle>
            <CardDescription>
              {disabled
                ? "No published PAES questions available yet"
                : `${Math.min(PAES_50_COUNT, pool)} of ${pool} available · untimed, volume recall`}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form action={startPaesQuizAttempt.bind(null, PAES_50_COUNT, paesReference, undefined)}>
              <Button type="submit" disabled={disabled} className="w-full">
                Start PAES 50
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>

      <div className="mt-8">
        <h2 className="text-sm font-medium text-muted-foreground">Specialized / Mixed</h2>
        <p className="mt-1 text-xs text-muted-foreground">
          Pick an exact length, untimed — good for focused study{paesReference ? ` on ${paesReference}` : ""}.
        </p>
        <div className="mt-3 space-y-3">
          {PRACTICE_LENGTH_OPTIONS.map((n) => (
            <Card key={n}>
              <CardHeader>
                <CardTitle>PAES {n}</CardTitle>
                <CardDescription>
                  {disabled
                    ? paesReference
                      ? `No published questions for ${paesReference} yet`
                      : "No published PAES questions available yet"
                    : `${Math.min(n, pool)} of ${pool} available questions`}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <form action={startPaesQuizAttempt.bind(null, n, paesReference, undefined)}>
                  <Button type="submit" disabled={disabled} className="w-full">
                    Start
                  </Button>
                </form>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
}
