"use client";

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { startPracticeAttempt } from "@/app/practice/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import type { MockArea } from "@/app/mock/actions";

export type PracticeTopic = {
  id: string;
  name: string;
  mockArea: MockArea;
  examAreaName: string | null;
  questionCount: number;
};

const AREA_ORDER: MockArea[] = ["area_1", "area_2", "area_3"];
const AREA_LABELS: Record<MockArea, string> = {
  area_1: "Area 1",
  area_2: "Area 2",
  area_3: "Area 3",
};

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
        {AREA_ORDER.map((area) => {
          const areaTopics = byArea.get(area) ?? [];
          const totalQuestions = areaTopics.reduce((sum, t) => sum + t.questionCount, 0);
          return (
            <TabsTrigger key={area} value={area}>
              {AREA_LABELS[area]} ({totalQuestions})
            </TabsTrigger>
          );
        })}
      </TabsList>

      {AREA_ORDER.map((area) => {
        const areaTopics = byArea.get(area) ?? [];

        return (
          <TabsContent key={area} value={area}>
            <div className="mt-3 space-y-3">
              {areaTopics.map((topic) => {
                const accent = getHarmonizedAccent(topic.examAreaName ?? topic.name);
                const count = topic.questionCount;

                return (
                  <Card key={topic.id} className={`border-l-4 ${accent.border} ${accent.bg}`}>
                    <CardHeader>
                      <div className="flex items-center justify-between">
                        <div>
                          <CardTitle>{topic.name}</CardTitle>
                          <CardDescription>{topic.examAreaName}</CardDescription>
                        </div>
                        <Badge className={count > 0 ? accent.badge : undefined} variant={count > 0 ? undefined : "secondary"}>
                          {count} question{count === 1 ? "" : "s"}
                        </Badge>
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
              })}

              {areaTopics.length === 0 && (
                <p className="text-sm text-muted-foreground">No topics assigned to this area yet.</p>
              )}
            </div>
          </TabsContent>
        );
      })}
    </Tabs>
  );
}
