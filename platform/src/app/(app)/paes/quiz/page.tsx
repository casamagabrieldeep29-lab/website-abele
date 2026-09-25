import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import { startPaesQuizAttempt } from "@/app/practice/actions";
import { PRACTICE_LENGTH_OPTIONS } from "@/lib/study-preferences";

/**
 * Phase 1 PAES Quizzer: pick a question count, optionally scoped to one PAES
 * standard via `?paes=`, and take it through the existing /practice/[id]
 * session — same infrastructure every other quiz mode already uses. The full
 * 5-mode Kahoot-style quizzer (Quickfire/Specialized/Number Quiz/Mixed/
 * PAES-50) is explicitly Phase 2 scope; this only wires up "start a quiz",
 * per the Phase 1 plan.
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

  return (
    <div className="mx-auto max-w-md">
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
            "Pick a length and start a quiz pooled from every published PAES-tagged question."
          )
        }
      />

      {paesReference && (
        <div className="mt-3">
          <Badge variant="secondary">{paesReference}</Badge>
        </div>
      )}

      <div className="mt-6 space-y-3">
        {PRACTICE_LENGTH_OPTIONS.map((n) => {
          const disabled = (available ?? 0) === 0;
          return (
            <Card key={n}>
              <CardHeader>
                <CardTitle>PAES {n}</CardTitle>
                <CardDescription>
                  {disabled
                    ? paesReference
                      ? `No published questions for ${paesReference} yet`
                      : "No published PAES questions available yet"
                    : `${Math.min(n, available ?? 0)} of ${available} available questions`}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <form action={startPaesQuizAttempt.bind(null, n, paesReference)}>
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
