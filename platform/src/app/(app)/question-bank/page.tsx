import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { PageHeader } from "@/components/page-header";
import {
  QuestionBankBrowser,
  type QuestionBankArea,
  type QuestionBankHighlight,
  type QuestionBankOfficialSubject,
} from "./question-bank-browser";

export default async function QuestionBankPage({
  searchParams,
}: {
  searchParams: Promise<{ areaId?: string; subjectId?: string; topicId?: string; subtopicId?: string; questionId?: string }>;
}) {
  const { areaId, subjectId, topicId, subtopicId, questionId } = await searchParams;
  const { supabase, user } = await getAuthContext();
  if (!user) redirect("/login");

  const [{ data: examAreas }, { data: officialSubjects }, { data: topics }, { data: subtopics }, published] =
    await Promise.all([
      supabase.from("exam_areas").select("id, name, weight_percent, sort_order").order("sort_order"),
      supabase.from("subjects").select("id, exam_area_id, name, sort_order").order("sort_order"),
      supabase.from("topics").select("id, name, exam_area_id, subject_id").order("name"),
      supabase.from("subtopics").select("id, name, topic_id").order("name"),
      // student_questions now has 1800+ published rows — a plain `.select()`
      // would silently cap at PostgREST's 1000-row default and understate
      // per-topic/per-subtopic question counts below. Paginated.
      fetchAllRows<{ topic_id: string; subtopic_id: string | null }>((from, to) =>
        supabase.from("student_questions").select("topic_id, subtopic_id").range(from, to),
      ),
    ]);

  const topicCount = new Map<string, number>();
  const subtopicCount = new Map<string, number>();
  for (const q of published) {
    topicCount.set(q.topic_id, (topicCount.get(q.topic_id) ?? 0) + 1);
    if (q.subtopic_id) subtopicCount.set(q.subtopic_id, (subtopicCount.get(q.subtopic_id) ?? 0) + 1);
  }

  const subtopicsByTopic = new Map<string, typeof subtopics>();
  for (const s of subtopics ?? []) {
    const list = subtopicsByTopic.get(s.topic_id) ?? [];
    list.push(s);
    subtopicsByTopic.set(s.topic_id, list);
  }

  function buildSubject(topic: { id: string; name: string }) {
    return {
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
    };
  }

  // Groups the existing topics-table rows (unchanged "Subject" level from
  // the original Question Bank redesign) under the official TOS Subject
  // they belong to (supabase/patches/013_official_subjects.sql). A topic
  // without a subject_id yet falls into "Other Topics" for its TOS rather
  // than disappearing.
  const officialSubjectsByArea = new Map<string, typeof officialSubjects>();
  for (const os of officialSubjects ?? []) {
    const list = officialSubjectsByArea.get(os.exam_area_id) ?? [];
    list.push(os);
    officialSubjectsByArea.set(os.exam_area_id, list);
  }

  const topicsBySubjectId = new Map<string, typeof topics>();
  const unmappedTopicsByArea = new Map<string, typeof topics>();
  for (const t of topics ?? []) {
    if (t.subject_id) {
      const list = topicsBySubjectId.get(t.subject_id) ?? [];
      list.push(t);
      topicsBySubjectId.set(t.subject_id, list);
    } else {
      const list = unmappedTopicsByArea.get(t.exam_area_id) ?? [];
      list.push(t);
      unmappedTopicsByArea.set(t.exam_area_id, list);
    }
  }

  const areas: QuestionBankArea[] = (examAreas ?? []).map((area) => {
    const officialSubjectNodes: QuestionBankOfficialSubject[] = (officialSubjectsByArea.get(area.id) ?? []).map((os) => ({
      id: os.id,
      name: os.name,
      subjects: (topicsBySubjectId.get(os.id) ?? []).map(buildSubject),
    }));

    const unmapped = unmappedTopicsByArea.get(area.id) ?? [];
    if (unmapped.length > 0) {
      officialSubjectNodes.push({
        id: `other:${area.id}`,
        name: "Other Topics",
        subjects: unmapped.map(buildSubject),
      });
    }

    return {
      id: area.id,
      name: area.name,
      weightPercent: area.weight_percent,
      officialSubjects: officialSubjectNodes,
    };
  });

  // Deep-link from the global search: reconstruct the exact ancestor-key
  // set QuestionBankBrowser's own openIds state uses (a:/os:/s:/t: — see
  // that file) so only the one relevant branch opens, never the whole
  // tree. subjectId here is the official-subject id; when a topic has none
  // assigned yet it lives in the synthetic "Other Topics" bucket the tree
  // builder above creates as `other:${areaId}`.
  const initialOpenIds: string[] = [];
  let highlight: QuestionBankHighlight = null;
  if (areaId) {
    initialOpenIds.push(`a:${areaId}`);
    if (subjectId) {
      initialOpenIds.push(`os:${subjectId}`);
    } else if (topicId || questionId) {
      initialOpenIds.push(`os:other:${areaId}`);
    }
    if (topicId) initialOpenIds.push(`s:${topicId}`);
    if (subtopicId) initialOpenIds.push(`t:${subtopicId}`);

    if (questionId) highlight = { kind: "question", targetId: questionId };
    else if (topicId) highlight = { kind: "topic", targetId: topicId };
    else if (subjectId) highlight = { kind: "os", targetId: subjectId };
    else highlight = { kind: "area", targetId: areaId };
  }

  return (
    <div className="mx-auto w-full max-w-4xl space-y-6">
      <PageHeader
        title="Question Bank"
        description="Browse by TOS area, subject, and topic. Drill into a topic to see and practice its questions."
      />
      <QuestionBankBrowser areas={areas} initialOpenIds={initialOpenIds} highlight={highlight} />
    </div>
  );
}
