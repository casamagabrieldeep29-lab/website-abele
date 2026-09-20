"use client";

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import type { MockArea } from "@/app/mock/actions";

export type RecalledQuestion = {
  questionId: string;
  questionText: string;
  explanation: string | null;
  recalledBatch: string | null;
  topicName: string;
  mockArea: MockArea;
  choices: { text: string; isCorrect: boolean }[];
};

const AREA_ORDER: MockArea[] = ["area_1", "area_2", "area_3"];
const AREA_LABELS: Record<MockArea, string> = {
  area_1: "Area 1",
  area_2: "Area 2",
  area_3: "Area 3",
};

const CHOICE_LETTERS = ["a", "b", "c", "d", "e", "f"];

function YearGroup({ year, questions }: { year: string; questions: RecalledQuestion[] }) {
  return (
    <div className="space-y-3">
      <div className="sticky top-0 z-10 -mx-1 bg-background/95 px-1 py-1.5 backdrop-blur-sm">
        <h3 className="text-sm font-bold text-primary">{year}</h3>
      </div>
      {questions.map((q, i) => (
        <Card key={q.questionId}>
          <CardHeader className="pb-2">
            <p className="text-sm font-medium">
              {i + 1}. {q.questionText}
            </p>
            <p className="text-xs text-muted-foreground">{q.topicName}</p>
          </CardHeader>
          <CardContent className="space-y-1.5">
            {q.choices.map((c, idx) => (
              <div
                key={idx}
                className={`rounded-md border px-2.5 py-1.5 text-sm ${
                  c.isCorrect
                    ? "border-success/40 bg-success/10 font-semibold text-success"
                    : "border-border/60 text-foreground/80"
                }`}
              >
                <span className="mr-1.5 font-mono text-xs opacity-70">{CHOICE_LETTERS[idx] ?? idx + 1}.</span>
                {c.text}
              </div>
            ))}
            {q.explanation && <p className="pt-1 text-xs text-muted-foreground">{q.explanation}</p>}
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

function AreaDocument({ questions }: { questions: RecalledQuestion[] }) {
  if (questions.length === 0) {
    return <p className="py-8 text-center text-sm text-muted-foreground">No recalled questions published for this area yet.</p>;
  }

  const byYear = new Map<string, RecalledQuestion[]>();
  for (const q of questions) {
    const year = q.recalledBatch ?? "Undated";
    const list = byYear.get(year) ?? [];
    list.push(q);
    byYear.set(year, list);
  }
  const years = [...byYear.keys()].sort();

  return (
    <div className="space-y-6">
      {years.map((year) => (
        <YearGroup key={year} year={year} questions={byYear.get(year)!} />
      ))}
    </div>
  );
}

export function RecalledBrowser({ questions }: { questions: RecalledQuestion[] }) {
  const byArea = new Map<MockArea, RecalledQuestion[]>();
  for (const q of questions) {
    const list = byArea.get(q.mockArea) ?? [];
    list.push(q);
    byArea.set(q.mockArea, list);
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

      {AREA_ORDER.map((area) => (
        <TabsContent key={area} value={area}>
          <div className="mt-3">
            <AreaDocument questions={byArea.get(area) ?? []} />
          </div>
        </TabsContent>
      ))}
    </Tabs>
  );
}
