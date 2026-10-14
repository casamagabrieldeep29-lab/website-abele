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
    supabase.from("topics").select("id, name, mock_area").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  // Cards sit on the real topics (Hydrology, Pumps, ...); the picker lists them grouped by Area.
  const pickerTopics = topics ?? [];

  const topicById = new Map((topics ?? []).map((t) => [t.id, t]));
  const cardsByTopic = new Map<string, typeof cards>();
  for (const c of cards ?? []) {
    const list = cardsByTopic.get(c.topic_id) ?? [];
    list.push(c);
    cardsByTopic.set(c.topic_id, list);
  }
  const hasDrafts = (cards ?? []).some((c) => c.status === "draft");
  const hasPublished = (cards ?? []).some((c) => c.status === "published");

  const groups: TopicGroup[] = [...cardsByTopic.entries()]
    .map(([topicId, topicCards]) => ({
      topicId,
      topicName: topicById.get(topicId)?.name ?? "(unknown topic)",
      area: topicById.get(topicId)?.mock_area ?? "",
      cards: topicCards ?? [],
    }))
    .sort((a, b) => a.area.localeCompare(b.area) || a.topicName.localeCompare(b.topicName));

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Flashcards</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="w-full px-6 py-10 space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <p className="text-sm text-muted-foreground">
            Front/back study cards for active recall. Never invent content — only enter verified terms/definitions.
          </p>
          <div className="flex flex-wrap gap-2">
            {hasDrafts && (
              <form action={publishAllDraftFlashcards.bind(null, undefined)}>
                <Button type="submit" size="sm">
                  Publish all drafts
                </Button>
              </form>
            )}
            {hasPublished && (
              <form action={unpublishAllFlashcards.bind(null, undefined)}>
                <Button type="submit" size="sm" variant="outline">
                  Unpublish all
                </Button>
              </form>
            )}
          </div>
        </div>

        <FlashcardsAdminBrowser groups={groups} topics={pickerTopics} subtopics={subtopics ?? []} />
        {groups.length === 0 && <p className="text-sm text-muted-foreground">No flashcards yet.</p>}

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Add a flashcard</CardTitle>
          </CardHeader>
          <CardContent>
            <form action={createFlashcard} className="space-y-2">
              <textarea name="front" placeholder="Front (term/question)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <textarea name="back" placeholder="Back (definition/answer)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
              <TopicSubtopicFields topics={pickerTopics} subtopics={subtopics ?? []} />
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
