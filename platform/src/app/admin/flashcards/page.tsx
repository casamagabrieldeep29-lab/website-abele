import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { createFlashcard, publishAllDraftFlashcards, unpublishAllFlashcards } from "./actions";
import { FlashcardsAdminBrowser, TopicSubtopicFields, type TopicGroup } from "./flashcards-admin-browser";

export default async function AdminFlashcardsPage() {
  await requireAdmin();
  const supabase = await createClient();

  const [{ data: cards }, { data: topics }, { data: subtopics }] = await Promise.all([
    supabase.from("flashcards").select("*").order("created_at", { ascending: false }),
    supabase.from("topics").select("id, name").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  const topicNameById = new Map((topics ?? []).map((t) => [t.id, t.name]));
  const cardsByTopic = new Map<string, typeof cards>();
  for (const c of cards ?? []) {
    const list = cardsByTopic.get(c.topic_id) ?? [];
    list.push(c);
    cardsByTopic.set(c.topic_id, list);
  }
  const totalDraftCount = (cards ?? []).filter((c) => c.status === "draft").length;
  const totalPublishedCount = (cards ?? []).filter((c) => c.status === "published").length;

  const groups: TopicGroup[] = [...cardsByTopic.entries()]
    .map(([topicId, topicCards]) => ({
      topicId,
      topicName: topicNameById.get(topicId) ?? "(unknown topic)",
      cards: topicCards ?? [],
    }))
    .sort((a, b) => a.topicName.localeCompare(b.topicName));

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Flashcards</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10 space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <p className="text-sm text-muted-foreground">
            Front/back study cards for active recall. Never invent content — only enter verified terms/definitions.
          </p>
          <div className="flex flex-wrap gap-2">
            {totalDraftCount > 0 && (
              <form action={publishAllDraftFlashcards.bind(null, undefined)}>
                <Button type="submit" size="sm">
                  Publish all drafts ({totalDraftCount})
                </Button>
              </form>
            )}
            {totalPublishedCount > 0 && (
              <form action={unpublishAllFlashcards.bind(null, undefined)}>
                <Button type="submit" size="sm" variant="outline">
                  Unpublish all ({totalPublishedCount})
                </Button>
              </form>
            )}
          </div>
        </div>

        <FlashcardsAdminBrowser groups={groups} topics={topics ?? []} subtopics={subtopics ?? []} />
        {groups.length === 0 && <p className="text-sm text-muted-foreground">No flashcards yet.</p>}

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Add a flashcard</CardTitle>
          </CardHeader>
          <CardContent>
            <form action={createFlashcard} className="space-y-2">
              <textarea name="front" placeholder="Front (term/question)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <textarea name="back" placeholder="Back (definition/answer)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <TopicSubtopicFields topics={topics ?? []} subtopics={subtopics ?? []} />
              <input name="source" placeholder="Source / reference" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <Button type="submit" size="sm">
                Add flashcard (as draft)
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    </main>
  );
}
