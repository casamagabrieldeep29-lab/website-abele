import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { startAreaMockExam, type MockArea } from "@/app/mock/actions";
import { PageHeader } from "@/components/page-header";
import { MockTosList, type MockSubject } from "./mock-tos-list";

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

  const [{ data: topics }, { data: published }, { data: examAreas }, { data: subjects }] = await Promise.all([
    supabase.from("topics").select("id, name, mock_area, exam_area_id, subject_id").order("name"),
    supabase.from("student_questions").select("id, topic_mock_area, additional_mock_areas"),
    supabase.from("exam_areas").select("id, name, sort_order").order("sort_order"),
    supabase.from("subjects").select("id, exam_area_id, name, sort_order").order("sort_order"),
  ]);

  const areaCount: Record<MockArea, number> = { area_1: 0, area_2: 0, area_3: 0 };
  for (const q of published ?? []) {
    const areas = new Set<MockArea>([q.topic_mock_area as MockArea, ...((q.additional_mock_areas ?? []) as MockArea[])]);
    for (const a of areas) areaCount[a] += 1;
  }

  const topicsByArea = new Map<MockArea, { id: string; name: string; exam_area_id: string; subject_id: string | null }[]>();
  for (const t of topics ?? []) {
    const list = topicsByArea.get(t.mock_area as MockArea) ?? [];
    list.push(t);
    topicsByArea.set(t.mock_area as MockArea, list);
  }

  const examAreaById = new Map((examAreas ?? []).map((a) => [a.id, a]));
  const subjectDefsByArea = new Map<string, { id: string; name: string; sort_order: number }[]>();
  for (const s of subjects ?? []) {
    const list = subjectDefsByArea.get(s.exam_area_id) ?? [];
    list.push(s);
    subjectDefsByArea.set(s.exam_area_id, list);
  }

  // Flat list of the official Subjects covered by an Area's topics — not
  // grouped under their TOS category, since an Area can span several TOS
  // categories (e.g. Area 1 = Power/Machinery + Project Mgmt/RDE + Laws/
  // Ethics) and that extra layer just duplicated the same subjects one
  // level deeper. Sorted by (TOS sort_order, Subject sort_order) so it
  // reads in official Table-of-Specifications order; a topic without a
  // subject_id yet contributes "Other Topics", always last.
  function buildSubjectList(areaTopics: { exam_area_id: string; subject_id: string | null }[]): MockSubject[] {
    const subjectIds = new Set<string | null>();
    const examAreaIds = new Set<string>();
    for (const t of areaTopics) {
      subjectIds.add(t.subject_id);
      examAreaIds.add(t.exam_area_id);
    }

    const subjectList: (MockSubject & { sortKey: number })[] = [];
    for (const examAreaId of examAreaIds) {
      const examArea = examAreaById.get(examAreaId);
      if (!examArea) continue;
      for (const s of subjectDefsByArea.get(examAreaId) ?? []) {
        if (!subjectIds.has(s.id)) continue;
        subjectList.push({ id: s.id, name: s.name, sortKey: (examArea.sort_order ?? 0) * 1000 + (s.sort_order ?? 0) });
      }
    }
    subjectList.sort((a, b) => a.sortKey - b.sortKey);

    const result: MockSubject[] = subjectList.map(({ id, name }) => ({ id, name }));
    if (subjectIds.has(null)) result.push({ id: "other", name: "Other Topics" });
    return result;
  }

  return (
    <div className="mx-auto max-w-6xl">
      <PageHeader
        title="Mock Exam"
        description={`The real PRC ABE board exam, simulated as-is: three separate subject exams, ${ITEM_COUNT} items each, ${TIME_LIMIT_HOURS} hours each, taken one area at a time. No feedback until you submit.`}
      />

      <div className="mt-6 grid grid-cols-1 gap-4 lg:grid-cols-3">
        {AREA_ORDER.map((area) => {
          const meta = AREA_META[area];
          const count = areaCount[area];
          const subjectList = buildSubjectList(topicsByArea.get(area) ?? []);

          return (
            <Card key={area} className={meta.accent}>
              <CardHeader>
                <CardTitle>{meta.label}</CardTitle>
              </CardHeader>
              <CardContent>
                <MockTosList subjects={subjectList} />

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
