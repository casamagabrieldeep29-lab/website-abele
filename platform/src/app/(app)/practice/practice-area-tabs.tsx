"use client";

import { useState } from "react";
import { ChevronRight } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { startPracticeAttempt, startSubjectPracticeAttempt } from "@/app/practice/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import type { MockArea } from "@/app/mock/actions";

const SESSION_SIZE = 20;

export type PracticeTopic = {
  id: string;
  name: string;
  mockArea: MockArea;
  examAreaId: string | null;
  examAreaName: string | null;
  examAreaSortOrder: number;
  subjectId: string | null;
  subjectName: string | null;
  subjectSortOrder: number;
  questionCount: number;
};

const AREA_ORDER: MockArea[] = ["area_1", "area_2", "area_3"];
const AREA_LABELS: Record<MockArea, string> = {
  area_1: "Area 1",
  area_2: "Area 2",
  area_3: "Area 3",
};

type SubjectGroup = {
  id: string;
  name: string;
  topics: PracticeTopic[];
};

/**
 * Groups one Area's topics directly by official Subject — one flat list,
 * not Subject nested inside its TOS category. An Area (e.g. Area 1) can
 * span several TOS categories (Power/Machinery, Project Mgmt/RDE, Laws/
 * Ethics), and showing each as its own collapsible layer just duplicated
 * the same subjects one level deeper for no reason — Subject is the level
 * a student actually picks from, so it's promoted to be the top of this
 * list. Sorted by (TOS sort_order, Subject sort_order) so it reads in the
 * same order as the official Table of Specifications; a topic without a
 * subject_id yet falls into "Other Topics", always last.
 */
function buildSubjectGroups(topics: PracticeTopic[]): SubjectGroup[] {
  const bySubject = new Map<string, { name: string; sortKey: number; topics: PracticeTopic[] }>();
  for (const t of topics) {
    const key = t.subjectId ?? "other";
    const entry = bySubject.get(key) ?? {
      name: t.subjectName ?? "Other Topics",
      sortKey: t.examAreaSortOrder * 1000 + t.subjectSortOrder,
      topics: [],
    };
    entry.topics.push(t);
    bySubject.set(key, entry);
  }

  const groups = [...bySubject.entries()].map(([id, { name, sortKey, topics: subjectTopics }]) => ({
    id,
    name,
    sortKey,
    topics: subjectTopics,
  }));
  groups.sort((a, b) => {
    if (a.id === "other" || b.id === "other") return (a.id === "other" ? 1 : 0) - (b.id === "other" ? 1 : 0);
    return a.sortKey - b.sortKey;
  });

  return groups.map(({ id, name, topics: subjectTopics }) => ({ id, name, topics: subjectTopics }));
}

function TopicCard({ topic }: { topic: PracticeTopic }) {
  const accent = getHarmonizedAccent(topic.examAreaName ?? topic.name);
  const count = topic.questionCount;

  return (
    <Card className={`border-l-4 ${accent.border} ${accent.bg}`}>
      <CardHeader>
        <CardTitle className="text-base">{topic.name}</CardTitle>
      </CardHeader>
      <CardContent>
        <form action={startPracticeAttempt.bind(null, topic.id)}>
          <Button type="submit" disabled={count === 0} className="w-full">
            {count === 0 ? "No published questions yet" : "Start practicing"}
          </Button>
        </form>
      </CardContent>
    </Card>
  );
}

function SubjectAccordion({ groups }: { groups: SubjectGroup[] }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  function toggle(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  if (groups.length === 0) {
    return <p className="text-sm text-muted-foreground">No topics assigned to this area yet.</p>;
  }

  return (
    <div className="space-y-2">
      {groups.map((group) => {
        const isOpen = openIds.has(group.id);
        const canPractice = group.id !== "other";
        return (
          <div key={group.id} className="rounded-lg border border-border/60">
            <div className="flex items-center justify-between gap-2 px-3 py-2.5">
              <Collapsible open={isOpen} onOpenChange={() => toggle(group.id)} className="min-w-0 flex-1">
                <CollapsibleTrigger className="flex w-full min-w-0 items-center gap-2 text-left">
                  <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                  <span className="min-w-0 flex-1 text-sm font-semibold break-words">{group.name}</span>
                </CollapsibleTrigger>
              </Collapsible>
              {canPractice && (
                <form action={startSubjectPracticeAttempt.bind(null, group.id, SESSION_SIZE)}>
                  <Button type="submit" size="sm" variant="outline">
                    Practice →
                  </Button>
                </form>
              )}
            </div>
            <Collapsible open={isOpen}>
              <CollapsibleContent open={isOpen}>
                <div className="space-y-2 px-3 pb-3 pl-6">
                  {group.topics.map((topic) => (
                    <TopicCard key={topic.id} topic={topic} />
                  ))}
                </div>
              </CollapsibleContent>
            </Collapsible>
          </div>
        );
      })}
    </div>
  );
}

export function PracticeAreaTabs({ topics }: { topics: PracticeTopic[] }) {
  const byArea = new Map<MockArea, PracticeTopic[]>();
  for (const topic of topics) {
    const list = byArea.get(topic.mockArea) ?? [];
    list.push(topic);
    byArea.set(topic.mockArea, list);
  }

  return (
    <Tabs defaultValue="area_1">
      <TabsList>
        {AREA_ORDER.map((area) => (
          <TabsTrigger key={area} value={area}>
            {AREA_LABELS[area]}
          </TabsTrigger>
        ))}
      </TabsList>

      {AREA_ORDER.map((area) => {
        const areaTopics = byArea.get(area) ?? [];
        const subjectGroups = buildSubjectGroups(areaTopics);

        return (
          <TabsContent key={area} value={area}>
            <div className="mt-3">
              <SubjectAccordion groups={subjectGroups} />
            </div>
          </TabsContent>
        );
      })}
    </Tabs>
  );
}
