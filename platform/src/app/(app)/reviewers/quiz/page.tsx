import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import { startFormulaQuiz, startSavedFormulaQuiz } from "@/app/reviewers/quiz-actions";
import { getSessionUser } from "@/lib/auth/session";

export default async function FormulaQuizPage({
  searchParams,
}: {
  searchParams: Promise<{ empty?: string }>;
}) {
  const { empty } = await searchParams;
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login");

  const { count: totalPublished, error } = await supabase
    .from("reviewer_entries")
    .select("id", { count: "exact", head: true })
    .eq("status", "published")
    .eq("kind", "formula");

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load Formula Trainer: {error.message}</p>;
  }

  return (
    <div className="mx-auto w-full max-w-4xl">
      <PageHeader title="Formula Trainer" description="Active recall for ABE formulas — see the name, recall the equation, self-grade." />

      {empty && (
        <p className="mt-3 rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
          No saved formulas yet — save some from a quiz session first.
        </p>
      )}

      {(totalPublished ?? 0) === 0 ? (
        <p className="mt-6 text-sm text-muted-foreground">No formulas published yet.</p>
      ) : (
        <div className="mt-6 grid gap-4 sm:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Quick study</CardTitle>
              <CardDescription>{totalPublished} published formulas available.</CardDescription>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {[10, 20].map((n) => (
                <form key={n} action={startFormulaQuiz}>
                  <input type="hidden" name="count" value={n} />
                  <Button type="submit" variant="secondary" size="sm">
                    Quick {n}
                  </Button>
                </form>
              ))}
              <form action={startFormulaQuiz}>
                <input type="hidden" name="count" value={999} />
                <Button type="submit" variant="secondary" size="sm">
                  Random (all)
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Saved Formulas</CardTitle>
            </CardHeader>
            <CardContent>
              <form action={startSavedFormulaQuiz}>
                <Button type="submit" size="sm" variant="outline">
                  Start →
                </Button>
              </form>
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  );
}
