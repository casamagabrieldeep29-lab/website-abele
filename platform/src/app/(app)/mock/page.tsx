import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { startAreaMockExam, type MockArea } from "@/app/mock/actions";
import { PageHeader } from "@/components/page-header";

const ITEM_COUNT = 100;
const TIME_LIMIT_HOURS = 3;

// Restrained, non-decorative differentiation — these are exam areas, not
// milestones, so gold stays out of the rotation.
const AREA_META: Record<MockArea, { label: string; accent: string }> = {
  area_1: { label: "Area 1", accent: "border-l-4 border-l-primary bg-primary/5" },
  area_2: { label: "Area 2", accent: "border-l-4 border-l-border bg-secondary/40" },
  area_3: { label: "Area 3", accent: "border-l-4 border-l-muted-foreground/40 bg-muted/30" },
};

const AREA_ORDER: MockArea[] = ["area_1", "area_2", "area_3"];

export default async function MockExamSetupPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: topics }, { data: published }] = await Promise.all([
    supabase.from("topics").select("id, name, mock_area").order("name"),
    supabase.from("student_questions").select("id, topic_mock_area, additional_mock_areas"),
  ]);

  const areaCount: Record<MockArea, number> = { area_1: 0, area_2: 0, area_3: 0 };
  for (const q of published ?? []) {
    const areas = new Set<MockArea>([q.topic_mock_area as MockArea, ...((q.additional_mock_areas ?? []) as MockArea[])]);
    for (const a of areas) areaCount[a] += 1;
  }

  const topicsByArea = new Map<MockArea, { id: string; name: string }[]>();
  for (const t of topics ?? []) {
    const list = topicsByArea.get(t.mock_area as MockArea) ?? [];
    list.push(t);
    topicsByArea.set(t.mock_area as MockArea, list);
  }

  return (
    <div className="mx-auto max-w-2xl">
      <PageHeader
        title="Mock Exam"
        description={`The real PRC ABE board exam, simulated as-is: three separate subject exams, ${ITEM_COUNT} items each, ${TIME_LIMIT_HOURS} hours each, taken one area at a time. No feedback until you submit.`}
      />

      <div className="mt-6 space-y-4">
        {AREA_ORDER.map((area) => {
          const meta = AREA_META[area];
          const count = areaCount[area];
          const areaTopics = topicsByArea.get(area) ?? [];

          return (
            <Card key={area} className={meta.accent}>
              <CardHeader>
                <CardTitle>{meta.label}</CardTitle>
                <CardDescription className="uppercase tracking-wide">
                  {TIME_LIMIT_HOURS}-hour timed exam - {ITEM_COUNT} items
                </CardDescription>
              </CardHeader>
              <CardContent>
                <ul className="space-y-1 text-sm text-muted-foreground">
                  {areaTopics.map((t) => (
                    <li key={t.id}>{t.name}</li>
                  ))}
                  {areaTopics.length === 0 && <li>No topics assigned to this area yet.</li>}
                </ul>

                <form action={startAreaMockExam} className="mt-4">
                  <input type="hidden" name="area" value={area} />
                  <Button type="submit" disabled={count === 0} className="w-full">
                    {count === 0 ? "Not available yet" : `Start ${meta.label} exam →`}
                  </Button>
                </form>
              </CardContent>
            </Card>
          );
        })}
      </div>
    </div>
  );
}
