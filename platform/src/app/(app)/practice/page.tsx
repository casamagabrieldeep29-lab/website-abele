import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { PageHeader } from "@/components/page-header";
import { PracticeAreaTabs, type PracticeTopic } from "./practice-area-tabs";
import type { MockArea } from "@/app/mock/actions";

export default async function PracticePage() {
  const { supabase, user, profile } = await getAuthContext();
  if (!user) redirect("/login");

  const isAdmin = profile?.role === "admin";

  // PostgREST can't embed through a view via a topics(...) join, so fetch
  // topics and published-question counts separately and merge in JS.
  const [{ data: topics }, { data: publishedQuestions }, { data: subjects }] = await Promise.all([
    supabase.from("topics").select("id, name, mock_area, exam_area_id, subject_id, exam_areas(name)").order("name"),
    supabase.from("student_questions").select("id, topic_id"),
    supabase.from("subjects").select("id, name"),
  ]);

  const countByTopic = new Map<string, number>();
  for (const q of publishedQuestions ?? []) {
    countByTopic.set(q.topic_id, (countByTopic.get(q.topic_id) ?? 0) + 1);
  }

  const subjectNameById = new Map((subjects ?? []).map((s) => [s.id, s.name]));

  const practiceTopics: PracticeTopic[] = (topics ?? []).map((topic) => ({
    id: topic.id,
    name: topic.name,
    mockArea: topic.mock_area as MockArea,
    examAreaId: topic.exam_area_id,
    examAreaName: (topic.exam_areas as unknown as { name: string } | null)?.name ?? null,
    subjectId: topic.subject_id,
    subjectName: topic.subject_id ? (subjectNameById.get(topic.subject_id) ?? null) : null,
    questionCount: countByTopic.get(topic.id) ?? 0,
  }));

  return (
    <div className="mx-auto max-w-3xl">
      <PageHeader
        title="Practice"
        description="Pick a topic. Questions are answered one at a time with immediate feedback."
      />

      <div className="mt-6">
        <PracticeAreaTabs topics={practiceTopics} showCounts={isAdmin} />

        {!practiceTopics.length && (
          <p className="mt-3 text-sm text-muted-foreground">No topics yet.</p>
        )}
      </div>
    </div>
  );
}
