import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { PageHeader } from "@/components/page-header";
import { QuestionBankBrowser, type QuestionBankArea } from "./question-bank-browser";

export default async function QuestionBankPage() {
  const { supabase, user, profile } = await getAuthContext();
  if (!user) redirect("/login");

  const isAdmin = profile?.role === "admin";

  const [{ data: examAreas }, { data: topics }, { data: subtopics }, { data: published }] = await Promise.all([
    supabase.from("exam_areas").select("id, name, weight_percent, sort_order").order("sort_order"),
    supabase.from("topics").select("id, name, exam_area_id").order("name"),
    supabase.from("subtopics").select("id, name, topic_id").order("name"),
    supabase.from("student_questions").select("topic_id, subtopic_id"),
  ]);

  const topicCount = new Map<string, number>();
  const subtopicCount = new Map<string, number>();
  for (const q of published ?? []) {
    topicCount.set(q.topic_id, (topicCount.get(q.topic_id) ?? 0) + 1);
    if (q.subtopic_id) subtopicCount.set(q.subtopic_id, (subtopicCount.get(q.subtopic_id) ?? 0) + 1);
  }

  const topicsByArea = new Map<string, typeof topics>();
  for (const t of topics ?? []) {
    const list = topicsByArea.get(t.exam_area_id) ?? [];
    list.push(t);
    topicsByArea.set(t.exam_area_id, list);
  }
  const subtopicsByTopic = new Map<string, typeof subtopics>();
  for (const s of subtopics ?? []) {
    const list = subtopicsByTopic.get(s.topic_id) ?? [];
    list.push(s);
    subtopicsByTopic.set(s.topic_id, list);
  }

  const areas: QuestionBankArea[] = (examAreas ?? []).map((area) => ({
    id: area.id,
    name: area.name,
    weightPercent: area.weight_percent,
    subjects: (topicsByArea.get(area.id) ?? []).map((topic) => ({
      id: topic.id,
      name: topic.name,
      questionCount: topicCount.get(topic.id) ?? 0,
      topics: (subtopicsByTopic.get(topic.id) ?? [])
        .filter((s) => (subtopicCount.get(s.id) ?? 0) > 0)
        .map((s) => ({
          id: s.id,
          name: s.name,
          questionCount: subtopicCount.get(s.id) ?? 0,
        })),
    })),
  }));

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <PageHeader
        title="Question Bank"
        description="Browse by TOS area, subject, and topic. Drill into a topic to see and practice its questions."
      />
      <QuestionBankBrowser areas={areas} isAdmin={isAdmin} />
    </div>
  );
}
