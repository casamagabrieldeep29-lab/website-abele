import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/page-header";
import {
  startFlashcardsByArea,
  startFlashcardsByTopic,
  startMistakeFlashcards,
  startQuickFlashcards,
  startSavedFlashcards,
  startWeakAreaFlashcards,
} from "@/app/flashcards/actions";

export default async function FlashcardsPage({
  searchParams,
}: {
  searchParams: Promise<{ empty?: string }>;
}) {
  const { empty } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ count: publishedCount, error }, { data: examAreas }, { data: topics }] = await Promise.all([
    supabase.from("flashcards").select("id", { count: "exact", head: true }).eq("status", "published"),
    supabase.from("exam_areas").select("id, name").order("sort_order"),
    supabase.from("topics").select("id, name, exam_area_id").order("name"),
  ]);

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load flashcards: {error.message}</p>;
  }

  const totalPublished = publishedCount ?? 0;

  return (
    <div className="mx-auto max-w-2xl">
      <PageHeader title="Flashcards" description="Active recall for ABE terms, definitions, and formulas." />

      {empty && (
        <p className="mt-3 rounded-md bg-secondary px-3 py-2 text-xs text-secondary-foreground">
          No flashcards matched that mode yet.
        </p>
      )}

      {totalPublished === 0 ? (
        <p className="mt-6 text-sm text-muted-foreground">
          No flashcards published yet. Ask your administrator to add some.
        </p>
      ) : (
        <div className="mt-6 space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Quick study</CardTitle>
              <CardDescription>{totalPublished} published flashcards available.</CardDescription>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {[10, 20].map((n) => (
                <form key={n} action={startQuickFlashcards}>
                  <input type="hidden" name="count" value={n} />
                  <Button type="submit" variant="secondary" size="sm">
                    Quick {n}
                  </Button>
                </form>
              ))}
              <form action={startQuickFlashcards}>
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
              <form action={startWeakAreaFlashcards}>
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
              <form action={startMistakeFlashcards}>
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
              <form action={startSavedFlashcards}>
                <Button type="submit" size="sm" variant="outline">
                  Start →
                </Button>
              </form>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">By Area</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {(examAreas ?? []).map((area) => (
                <form key={area.id} action={startFlashcardsByArea.bind(null, area.id)}>
                  <Button type="submit" size="sm" variant="outline">
                    {area.name}
                  </Button>
                </form>
              ))}
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">By Topic</CardTitle>
            </CardHeader>
            <CardContent className="flex flex-wrap gap-2">
              {(topics ?? []).map((topic) => (
                <form key={topic.id} action={startFlashcardsByTopic.bind(null, topic.id)}>
                  <Button type="submit" size="sm" variant="outline">
                    {topic.name}
                  </Button>
                </form>
              ))}
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  );
}
