"use client";

import { useState } from "react";
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

export type Topic = { id: string; name: string; mock_area?: string | null };
export type Subtopic = { id: string; name: string; topic_id: string };
export type TopicGroup = { topicId: string; topicName: string; area: string; cards: FlashcardRow[] };

const AREA_LABELS: Record<string, string> = { area_1: "Area 1", area_2: "Area 2", area_3: "Area 3" };

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
  const areas = Object.keys(AREA_LABELS);
  return (
    <div className="grid grid-cols-2 gap-2">
      <select name="topicId" defaultValue={defaultTopicId ?? ""} required className="rounded-md border border-border bg-background px-2 py-1.5 text-sm">
        <option value="" disabled>
          Topic…
        </option>
        {areas.map((area) => {
          const inArea = topics.filter((t) => t.mock_area === area);
          if (inArea.length === 0) return null;
          return (
            <optgroup key={area} label={AREA_LABELS[area]}>
              {inArea.map((t) => (
                <option key={t.id} value={t.id}>
                  {t.name}
                </option>
              ))}
            </optgroup>
          );
        })}
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

const DEFAULT_TOPIC_PAGE_SIZE = 50;

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
  const [activeId, setActiveId] = useState<string | null>(groups[0]?.topicId ?? null);

  if (groups.length === 0) return null;

  const query = search.trim().toLowerCase();
  const active = groups.find((g) => g.topicId === activeId) ?? groups[0];

  const draftCount = active.cards.filter((c) => c.status === "draft").length;
  const publishedCount = active.cards.filter((c) => c.status === "published").length;

  // A topic can run hundreds of cards — render only the first page unless
  // searching (search bypasses the cap).
  const matching = query
    ? active.cards.filter((c) => c.front.toLowerCase().includes(query) || c.back.toLowerCase().includes(query))
    : active.cards;
  const visible = query ? matching : matching.slice(0, DEFAULT_TOPIC_PAGE_SIZE);

  return (
    <div className="space-y-4">
      <div className="space-y-3">
        {Object.entries(AREA_LABELS).map(([area, label]) => {
          const areaGroups = groups.filter((g) => g.area === area);
          if (areaGroups.length === 0) return null;
          return (
            <div key={area}>
              <p className="mb-1.5 text-xs font-semibold uppercase tracking-wide text-muted-foreground">{label}</p>
              <div className="flex flex-wrap gap-2">
                {areaGroups.map((g) => (
                  <button
                    key={g.topicId}
                    type="button"
                    onClick={() => setActiveId(g.topicId)}
                    className={
                      g.topicId === active.topicId
                        ? "rounded-full border border-primary bg-primary px-3 py-1 text-xs font-medium text-primary-foreground"
                        : "rounded-full border border-border bg-background px-3 py-1 text-xs font-medium text-foreground/80 hover:border-primary/60 hover:text-foreground"
                    }
                  >
                    {g.topicName}
                  </button>
                ))}
              </div>
            </div>
          );
        })}
      </div>

      <div className="flex flex-wrap items-center justify-between gap-2 border-b pb-3">
        <Input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search this topic's cards (front/back)…"
          className="max-w-md"
        />
        <div className="flex flex-wrap gap-2">
          {draftCount > 0 && (
            <form action={publishAllDraftFlashcards.bind(null, active.topicId)}>
              <Button type="submit" size="sm" variant="outline">
                Publish all drafts
              </Button>
            </form>
          )}
          {publishedCount > 0 && (
            <form action={unpublishAllFlashcards.bind(null, active.topicId)}>
              <Button type="submit" size="sm" variant="outline">
                Unpublish all
              </Button>
            </form>
          )}
        </div>
      </div>

      {!query && active.cards.length > visible.length && (
        <p className="text-xs text-muted-foreground">Showing the first cards only — search above to find the rest.</p>
      )}
      {query && matching.length === 0 && <p className="text-sm text-muted-foreground">No cards match that search.</p>}

      <div className="space-y-3">
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
      </div>
    </div>
  );
}
