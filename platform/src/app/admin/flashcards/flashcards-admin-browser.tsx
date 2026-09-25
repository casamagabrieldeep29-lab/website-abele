"use client";

import { useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  deleteFlashcard,
  publishAllDraftFlashcards,
  publishFlashcard,
  unpublishAllFlashcards,
  unpublishFlashcard,
  updateFlashcard,
} from "./actions";

export type FlashcardRow = {
  id: string;
  front: string;
  back: string;
  status: string;
  source: string | null;
  topic_id: string;
  subtopic_id: string | null;
};

export type Topic = { id: string; name: string };
export type Subtopic = { id: string; name: string; topic_id: string };
export type TopicGroup = { topicId: string; topicName: string; cards: FlashcardRow[] };

export function TopicSubtopicFields({
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

const DEFAULT_TAB_PAGE_SIZE = 50;

export function FlashcardsAdminBrowser({
  groups,
  topics,
  subtopics,
}: {
  groups: TopicGroup[];
  topics: Topic[];
  subtopics: Subtopic[];
}) {
  const [search, setSearch] = useState("");

  if (groups.length === 0) return null;

  const query = search.trim().toLowerCase();

  return (
    <Tabs defaultValue={groups[0].topicId}>
      <TabsList className="h-auto w-full flex-wrap justify-start gap-1">
        {groups.map((g) => (
          <TabsTrigger key={g.topicId} value={g.topicId}>
            {g.topicName} ({g.cards.length})
          </TabsTrigger>
        ))}
      </TabsList>

      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search this topic's cards (front/back)…"
        className="mt-2 max-w-md"
      />

      {groups.map((g) => {
        const draftCount = g.cards.filter((c) => c.status === "draft").length;
        const publishedCount = g.cards.filter((c) => c.status === "published").length;

        // A topic can run 300+ cards — rendering every one as a full
        // edit-form unfiltered was the same slowness pattern fixed on
        // /admin/reviewers. Search bypasses the per-tab cap.
        const matching = query
          ? g.cards.filter((c) => c.front.toLowerCase().includes(query) || c.back.toLowerCase().includes(query))
          : g.cards;
        const visible = query ? matching : matching.slice(0, DEFAULT_TAB_PAGE_SIZE);

        return (
          <TabsContent key={g.topicId} value={g.topicId} className="space-y-3">
            <div className="flex flex-wrap items-center justify-between gap-2 border-b pb-2">
              <p className="text-sm text-muted-foreground">
                {query
                  ? `${matching.length} matching of ${g.cards.length} cards`
                  : `Showing ${visible.length} of ${g.cards.length} cards${
                      g.cards.length > visible.length ? " — search above to see the rest" : ""
                    }`}
              </p>
              <div className="flex flex-wrap gap-2">
                {draftCount > 0 && (
                  <form action={publishAllDraftFlashcards.bind(null, g.topicId)}>
                    <Button type="submit" size="sm" variant="outline">
                      Publish all drafts ({draftCount})
                    </Button>
                  </form>
                )}
                {publishedCount > 0 && (
                  <form action={unpublishAllFlashcards.bind(null, g.topicId)}>
                    <Button type="submit" size="sm" variant="outline">
                      Unpublish all ({publishedCount})
                    </Button>
                  </form>
                )}
              </div>
            </div>

            {visible.map((c) => (
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
                      <TopicSubtopicFields topics={topics} subtopics={subtopics} defaultTopicId={c.topic_id} defaultSubtopicId={c.subtopic_id} />
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
          </TabsContent>
        );
      })}
    </Tabs>
  );
}
