import { redirect } from "next/navigation";
import Link from "next/link";
import { getAuthContext } from "@/lib/auth/session";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import {
  startMistakeFlashcards,
  startQuickFlashcards,
  startSavedFlashcards,
  startWeakAreaFlashcards,
} from "@/app/flashcards/actions";

export default async function FlashcardsPage({
  searchParams,
}: {
  searchParams: Promise<{ empty?: string; area?: string }>;
}) {
  const { empty, area: areaTopicId } = await searchParams;
  const { supabase, user, profile } = await getAuthContext();
  if (!user) redirect("/login");

  const isAdmin = profile?.role === "admin";

  const { data: areaTopics } = await supabase
    .from("topics")
    .select("id, name")
    .in("name", ["Area 1", "Area 2", "Area 3"])
    .order("name");

  const currentArea = (areaTopics ?? []).find((a) => a.id === areaTopicId);

  // No area chosen yet — show the Area 1/2/3 picker first.
  if (!currentArea) {
    return (
      <div className="mx-auto w-full max-w-4xl">
        <PageHeader title="Flashcards" description="Pick an area to study its terms, definitions, and formulas." />

        <div className="mt-6 grid gap-3 sm:grid-cols-3">
          {(areaTopics ?? []).map((area) => (
            <Link key={area.id} href={`/flashcards?area=${area.id}`} className="block">
              <Card className="h-full transition-all duration-150 hover:-translate-y-0.5 hover:shadow-sm hover:ring-primary/40">
                <CardHeader>
                  <CardTitle className="text-base">{area.name}</CardTitle>
                </CardHeader>
              </Card>
            </Link>
          ))}
          {(areaTopics ?? []).length === 0 && (
            <p className="text-sm text-muted-foreground">No flashcards published yet. Ask your administrator to add some.</p>
          )}
        </div>
      </div>
    );
  }

  const { count: totalPublished, error } = await supabase
    .from("flashcards")
    .select("id", { count: "exact", head: true })
    .eq("status", "published")
    .eq("topic_id", currentArea.id);

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load flashcards: {error.message}</p>;
  }

  return (
    <div className="mx-auto w-full max-w-4xl">
      <PageHeader title={currentArea.name} description="Active recall for ABE terms, definitions, and formulas." />
      <Link href="/flashcards" className="mt-2 inline-block text-sm text-muted-foreground hover:underline">
        ← All areas
      </Link>

      {empty && (
        <p className="mt-3 rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
          No flashcards matched that mode yet.
        </p>
      )}

      {(totalPublished ?? 0) === 0 ? (
        <p className="mt-6 text-sm text-muted-foreground">No flashcards published yet for this area.</p>
      ) : (
        <div className="mt-6 grid gap-4 sm:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Quick study</CardTitle>
              {isAdmin && <CardDescription>{totalPublished} published flashcards available.</CardDescription>}
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {[10, 20].map((n) => (
                <form key={n} action={startQuickFlashcards.bind(null, currentArea.id)}>
                  <input type="hidden" name="count" value={n} />
                  <Button type="submit" variant="secondary" size="sm">
                    Quick {n}
                  </Button>
                </form>
              ))}
              <form action={startQuickFlashcards.bind(null, currentArea.id)}>
                <input type="hidden" name="count" value={200} />
                <Button type="submit" variant="secondary" size="sm">
                  Random (all)
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Review My Weak Areas</CardTitle>
              <CardDescription>Uses your real mastery data — topics marked developing or needs review.</CardDescription>
            </CardHeader>
            <CardContent>
              <form action={startWeakAreaFlashcards.bind(null, currentArea.id)}>
                <Button type="submit" size="sm">
                  Start →
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Practice My Mistakes</CardTitle>
              <CardDescription>Flashcards for topics currently in your Mistake Bank.</CardDescription>
            </CardHeader>
            <CardContent>
              <form action={startMistakeFlashcards.bind(null, currentArea.id)}>
                <Button type="submit" size="sm">
                  Start →
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Saved Flashcards</CardTitle>
            </CardHeader>
            <CardContent>
              <form action={startSavedFlashcards.bind(null, currentArea.id)}>
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
