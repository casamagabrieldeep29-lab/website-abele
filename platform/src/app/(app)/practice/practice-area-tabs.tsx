"use client";

import { useState } from "react";
import { ChevronRight } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { startPracticeAttempt } from "@/app/practice/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import type { MockArea } from "@/app/mock/actions";

export type PracticeTopic = {
  id: string;
  name: string;
  mockArea: MockArea;
  examAreaId: string | null;
  examAreaName: string | null;
  subjectId: string | null;
  subjectName: string | null;
  questionCount: number;
};

const AREA_ORDER: MockArea[] = ["area_1", "area_2", "area_3"];
const AREA_LABELS: Record<MockArea, string> = {
  area_1: "Area 1",
  area_2: "Area 2",
  area_3: "Area 3",
};

type TosGroup = {
  id: string;
  name: string;
  subjects: { id: string; name: string; topics: PracticeTopic[] }[];
};

/** Groups one Area's topics as TOS -> official Subject -> topic, mirroring Mock Exam's exact grouping so the two pages feel like the same structure. A topic without a subject_id yet falls into "Other Topics" for its TOS. */
function buildTosGroups(topics: PracticeTopic[]): TosGroup[] {
  const byExamArea = new Map<string, { name: string; topics: PracticeTopic[] }>();
  for (const t of topics) {
    if (!t.examAreaId) continue;
    const entry = byExamArea.get(t.examAreaId) ?? { name: t.examAreaName ?? "Unknown TOS", topics: [] };
    entry.topics.push(t);
    byExamArea.set(t.examAreaId, entry);
  }

  return [...byExamArea.entries()].map(([examAreaId, { name, topics: tosTopics }]) => {
    const bySubject = new Map<string, { name: string; topics: PracticeTopic[] }>();
    for (const t of tosTopics) {
      const key = t.subjectId ?? "other";
      const entry = bySubject.get(key) ?? { name: t.subjectName ?? "Other Topics", topics: [] };
      entry.topics.push(t);
      bySubject.set(key, entry);
    }
    return {
      id: examAreaId,
      name,
      subjects: [...bySubject.entries()].map(([subjectId, { name: subjectName, topics: subjectTopics }]) => ({
        id: subjectId,
        name: subjectName,
        topics: subjectTopics,
      })),
    };
  });
}

function TopicCard({ topic, showCounts }: { topic: PracticeTopic; showCounts: boolean }) {
  const accent = getHarmonizedAccent(topic.examAreaName ?? topic.name);
  const count = topic.questionCount;

  return (
    <Card className={`border-l-4 ${accent.border} ${accent.bg}`}>
      <CardHeader>
        <div className="flex items-center justify-between gap-2">
          <CardTitle className="text-base">{topic.name}</CardTitle>
          {showCounts && (
            <Badge className={count > 0 ? accent.badge : undefined} variant={count > 0 ? undefined : "secondary"}>
              {count} question{count === 1 ? "" : "s"}
            </Badge>
          )}
        </div>
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

function TosAccordion({ groups, showCounts }: { groups: TosGroup[]; showCounts: boolean }) {
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
        const tosOpen = openIds.has(`t:${group.id}`);
        return (
          <div key={group.id} className="rounded-lg border border-border/60">
            <Collapsible open={tosOpen} onOpenChange={() => toggle(`t:${group.id}`)}>
              <CollapsibleTrigger className="flex w-full items-center gap-2 px-3 py-2.5 text-left">
                <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                <span className="min-w-0 flex-1 text-sm font-semibold break-words">{group.name}</span>
              </CollapsibleTrigger>
              <CollapsibleContent open={tosOpen}>
                <div className="space-y-2 px-3 pb-3 pl-6">
                  {group.subjects.map((subject) => {
                    const subjectOpen = openIds.has(`s:${subject.id}`);
                    return (
                      <div key={subject.id} className="rounded-md border border-border/50">
                        <Collapsible open={subjectOpen} onOpenChange={() => toggle(`s:${subject.id}`)}>
                          <CollapsibleTrigger className="flex w-full items-center gap-2 px-2.5 py-1.5 text-left">
                            <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                            <span className="min-w-0 flex-1 text-sm font-medium break-words">{subject.name}</span>
                          </CollapsibleTrigger>
                          <CollapsibleContent open={subjectOpen}>
                            <div className="space-y-2 px-2.5 pb-2.5 pl-5">
                              {subject.topics.map((topic) => (
                                <TopicCard key={topic.id} topic={topic} showCounts={showCounts} />
                              ))}
                            </div>
                          </CollapsibleContent>
                        </Collapsible>
                      </div>
                    );
                  })}
                </div>
              </CollapsibleContent>
            </Collapsible>
          </div>
        );
      })}
    </div>
  );
}

export function PracticeAreaTabs({ topics, showCounts }: { topics: PracticeTopic[]; showCounts: boolean }) {
  const byArea = new Map<MockArea, PracticeTopic[]>();
  for (const topic of topics) {
    const list = byArea.get(topic.mockArea) ?? [];
    list.push(topic);
    byArea.set(topic.mockArea, list);
  }

  return (
    <Tabs defaultValue="area_1">
      <TabsList>
        {AREA_ORDER.map((area) => {
          const areaTopics = byArea.get(area) ?? [];
          const totalQuestions = areaTopics.reduce((sum, t) => sum + t.questionCount, 0);
          return (
            <TabsTrigger key={area} value={area}>
              {AREA_LABELS[area]}
              {showCounts ? ` (${totalQuestions})` : ""}
            </TabsTrigger>
          );
        })}
      </TabsList>

      {AREA_ORDER.map((area) => {
        const areaTopics = byArea.get(area) ?? [];
        const tosGroups = buildTosGroups(areaTopics);

        return (
          <TabsContent key={area} value={area}>
            <div className="mt-3">
              <TosAccordion groups={tosGroups} showCounts={showCounts} />
            </div>
          </TabsContent>
        );
      })}
    </Tabs>
  );
}
