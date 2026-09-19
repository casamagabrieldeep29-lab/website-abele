import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { PageHeader } from "@/components/page-header";
import { PracticeAreaTabs, type PracticeTopic } from "./practice-area-tabs";
import type { MockArea } from "@/app/mock/actions";

export default async function PracticePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // PostgREST can't embed through a view via a topics(...) join, so fetch
  // topics and published-question counts separately and merge in JS.
  const [{ data: topics }, { data: publishedQuestions }] = await Promise.all([
    supabase.from("topics").select("id, name, mock_area, exam_areas(name)").order("name"),
    supabase.from("student_questions").select("id, topic_id"),
  ]);

  const countByTopic = new Map<string, number>();
  for (const q of publishedQuestions ?? []) {
    countByTopic.set(q.topic_id, (countByTopic.get(q.topic_id) ?? 0) + 1);
  }

  const practiceTopics: PracticeTopic[] = (topics ?? []).map((topic) => ({
    id: topic.id,
    name: topic.name,
    mockArea: topic.mock_area as MockArea,
    examAreaName: (topic.exam_areas as unknown as { name: string } | null)?.name ?? null,
    questionCount: countByTopic.get(topic.id) ?? 0,
  }));

  return (
    <div className="mx-auto max-w-3xl">
      <PageHeader
        title="Practice"
        description="Pick a topic. Questions are answered one at a time with immediate feedback."
      />

      <div className="mt-6">
        <PracticeAreaTabs topics={practiceTopics} />

        {!practiceTopics.length && (
          <p className="mt-3 text-sm text-muted-foreground">No topics yet.</p>
        )}
      </div>
    </div>
  );
}
