import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { createFlashcard, deleteFlashcard, publishFlashcard, unpublishFlashcard, updateFlashcard } from "./actions";

type Topic = { id: string; name: string };
type Subtopic = { id: string; name: string; topic_id: string };

function TopicSubtopicFields({
  topics,
  subtopics,
  defaultTopicId,
  defaultSubtopicId,
}: {
  topics: Topic[];
  subtopics: Subtopic[];
  defaultTopicId?: string;
  defaultSubtopicId?: string | null;
}) {
  return (
    <div className="grid grid-cols-2 gap-2">
      <select name="topicId" defaultValue={defaultTopicId ?? ""} required className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
        <option value="" disabled>
          Topic…
        </option>
        {topics.map((t) => (
          <option key={t.id} value={t.id}>
            {t.name}
          </option>
        ))}
      </select>
      <select name="subtopicId" defaultValue={defaultSubtopicId ?? ""} className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
        <option value="">(no subtopic / concept)</option>
        {subtopics.map((s) => (
          <option key={s.id} value={s.id}>
            {s.name}
          </option>
        ))}
      </select>
    </div>
  );
}

export default async function AdminFlashcardsPage() {
  await requireAdmin();
  const supabase = await createClient();

  const [{ data: cards }, { data: topics }, { data: subtopics }] = await Promise.all([
    supabase.from("flashcards").select("*").order("created_at", { ascending: false }),
    supabase.from("topics").select("id, name").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
  ]);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Flashcards</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10 space-y-4">
        <p className="text-sm text-muted-foreground">
          Front/back study cards for active recall. Never invent content — only enter verified terms/definitions.
        </p>

        {(cards ?? []).map((c) => (
          <Card key={c.id}>
            <CardContent className="py-3">
              <div className="flex items-start justify-between gap-2">
                <p className="text-sm font-medium">{c.front}</p>
                <Badge variant={c.status === "published" ? "default" : "secondary"}>{c.status}</Badge>
              </div>
              <p className="mt-1 text-sm text-muted-foreground">{c.back}</p>

              <details className="mt-2 border-t pt-2">
                <summary className="cursor-pointer text-xs font-medium text-primary">Edit</summary>
                <form action={updateFlashcard.bind(null, c.id)} className="mt-3 space-y-2">
                  <textarea name="front" defaultValue={c.front} placeholder="Front (term/question)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
                  <textarea name="back" defaultValue={c.back} placeholder="Back (definition/answer)" required rows={2} className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
                  <TopicSubtopicFields topics={topics ?? []} subtopics={subtopics ?? []} defaultTopicId={c.topic_id} defaultSubtopicId={c.subtopic_id} />
                  <input name="source" defaultValue={c.source ?? ""} placeholder="Source / reference" className="w-full rounded-md border border-border bg-background px-2 py-1.5 text-sm" />
                  <Button type="submit" size="sm">
                    Save changes
                  </Button>
                </form>
              </details>

              <div className="mt-3 flex gap-2">
                {c.status === "draft" ? (
                  <form action={publishFlashcard.bind(null, c.id)}>
                    <Button type="submit" size="sm">
                      Publish
                    </Button>
                  </form>
                ) : (
                  <form action={unpublishFlashcard.bind(null, c.id)}>
                    <Button type="submit" size="sm" variant="outline">
                      Unpublish
                    </Button>
                  </form>
                )}
                <form action={deleteFlashcard.bind(null, c.id)}>
                  <Button type="submit" size="sm" variant="ghost" className="text-destructive">
                    Delete
                  </Button>
                </form>
              </div>
            </CardContent>
          </Card>
        ))}
        {(cards ?? []).length === 0 && <p className="text-sm text-muted-foreground">No flashcards yet.</p>}

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
