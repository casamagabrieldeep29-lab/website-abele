import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import { startNumberBankQuiz, startSavedNumberBankQuiz } from "@/app/reviewers/quiz-actions";
import { getSessionUser } from "@/lib/auth/session";

export default async function NumberBankQuizPage({
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
    .in("kind", ["constant", "table"])
    .not("paes_reference", "is", null);

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load Number Bank Quiz: {error.message}</p>;
  }

  return (
    <div className="mx-auto w-full max-w-4xl">
      <PageHeader title="Number Bank Quiz" description="Active recall for PAES standards — constants, dimensions, and space requirements." />

      {empty && (
        <p className="mt-3 rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
          No saved entries yet — save some from a quiz session first.
        </p>
      )}

      {(totalPublished ?? 0) === 0 ? (
        <p className="mt-6 text-sm text-muted-foreground">No PAES numeric content published yet.</p>
      ) : (
        <div className="mt-6 grid gap-4 sm:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Quick study</CardTitle>
              <CardDescription>{totalPublished} published entries available.</CardDescription>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {[10, 20].map((n) => (
                <form key={n} action={startNumberBankQuiz}>
                  <input type="hidden" name="count" value={n} />
                  <Button type="submit" variant="secondary" size="sm">
                    Quick {n}
                  </Button>
                </form>
              ))}
              <form action={startNumberBankQuiz}>
                <input type="hidden" name="count" value={999} />
                <Button type="submit" variant="secondary" size="sm">
                  Random (all)
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Saved Entries</CardTitle>
            </CardHeader>
            <CardContent>
              <form action={startSavedNumberBankQuiz}>
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
