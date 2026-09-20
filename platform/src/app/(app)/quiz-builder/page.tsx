import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { QuizBuilderForm } from "@/app/quiz-builder/quiz-builder-form";
import { PageHeader } from "@/components/page-header";
import type { TopicPickerArea } from "@/app/quiz-builder/topic-picker";

export default async function QuizBuilderPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: examAreas }, { data: subjects }, { data: topics }] = await Promise.all([
    supabase.from("exam_areas").select("id, name, sort_order").order("sort_order"),
    supabase.from("subjects").select("id, exam_area_id, name, sort_order").order("sort_order"),
    supabase.from("topics").select("id, name, exam_area_id, subject_id").order("name"),
  ]);

  // Same TOS Area -> official Subject grouping used by Question Bank/Progress
  // (supabase/patches/013_official_subjects.sql) — a topic without a
  // subject_id yet falls into "Other Topics" for its area.
  const subjectsByArea = new Map<string, typeof subjects>();
  for (const s of subjects ?? []) {
    const list = subjectsByArea.get(s.exam_area_id) ?? [];
    list.push(s);
    subjectsByArea.set(s.exam_area_id, list);
  }

  const topicsBySubject = new Map<string, typeof topics>();
  const unmappedTopicsByArea = new Map<string, typeof topics>();
  for (const t of topics ?? []) {
    if (t.subject_id) {
      const list = topicsBySubject.get(t.subject_id) ?? [];
      list.push(t);
      topicsBySubject.set(t.subject_id, list);
    } else {
      const list = unmappedTopicsByArea.get(t.exam_area_id) ?? [];
      list.push(t);
      unmappedTopicsByArea.set(t.exam_area_id, list);
    }
  }

  const areas: TopicPickerArea[] = (examAreas ?? []).map((area) => {
    const subjectNodes = (subjectsByArea.get(area.id) ?? []).map((s) => ({
      id: s.id,
      name: s.name,
      topics: (topicsBySubject.get(s.id) ?? []).map((t) => ({ id: t.id, name: t.name })),
    }));

    const unmapped = unmappedTopicsByArea.get(area.id) ?? [];
    if (unmapped.length > 0) {
      subjectNodes.push({
        id: `other:${area.id}`,
        name: "Other Topics",
        topics: unmapped.map((t) => ({ id: t.id, name: t.name })),
      });
    }

    return { id: area.id, name: area.name, subjects: subjectNodes };
  });

  return (
    <div className="mx-auto max-w-xl">
      <PageHeader title="Custom Quiz" description="Build a quiz exactly the way you want it." />

      <QuizBuilderForm areas={areas} errorCode={error === "no-match" || error === "no-topics" ? error : null} />
    </div>
  );
}
