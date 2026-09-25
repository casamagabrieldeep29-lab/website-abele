"use server";

import { createClient } from "@/lib/supabase/server";

export type SearchResultKind = "tos" | "subject" | "topic" | "question" | "material" | "flashcard" | "mistake";

export type SearchResult = {
  kind: SearchResultKind;
  id: string;
  label: string;
  sublabel: string;
  href: string;
  /** Only set on "topic" results — lets the search UI offer an inline Practice action without a second lookup. */
  topicId?: string;
};

export type GlobalSearchResults = {
  tos: SearchResult[];
  subjects: SearchResult[];
  topics: SearchResult[];
  questions: SearchResult[];
  materials: SearchResult[];
  flashcards: SearchResult[];
  mistakes: SearchResult[];
};

const EMPTY: GlobalSearchResults = {
  tos: [],
  subjects: [],
  topics: [],
  questions: [],
  materials: [],
  flashcards: [],
  mistakes: [],
};

const PER_CATEGORY_LIMIT = 5;

/**
 * AND-across-words substring match on one column ("soil water" -> matches
 * "Soil and Water Conservation Engineering") — PostgREST combines repeated
 * conditions on the same column as AND, so chaining .ilike() once per word
 * does the right thing server-side without a second round trip.
 */
function multiWordIlike<T extends { ilike: (col: string, pattern: string) => T }>(
  builder: T,
  column: string,
  query: string,
): T {
  let q = builder;
  for (const word of query.trim().split(/\s+/).filter(Boolean)) {
    q = q.ilike(column, `%${word}%`);
  }
  return q;
}

// Question Bank's collapsible tree keys ancestors as a:<examAreaId>,
// os:<officialSubjectId> (or os:other:<examAreaId> for topics with no
// official subject yet), s:<topicId>, t:<subtopicId> — see
// question-bank-browser.tsx. Search results carry the raw ids so
// question-bank/page.tsx can build that exact key set to auto-expand only
// the relevant branch, never the whole tree.
function questionBankHref(params: {
  areaId: string;
  subjectId: string | null;
  topicId?: string;
  subtopicId?: string | null;
  questionId?: string;
}): string {
  const sp = new URLSearchParams();
  sp.set("areaId", params.areaId);
  if (params.subjectId) sp.set("subjectId", params.subjectId);
  if (params.topicId) sp.set("topicId", params.topicId);
  if (params.subtopicId) sp.set("subtopicId", params.subtopicId);
  if (params.questionId) sp.set("questionId", params.questionId);
  return `/question-bank?${sp.toString()}`;
}

export async function globalSearch(rawQuery: string): Promise<GlobalSearchResults> {
  const query = rawQuery.trim();
  if (query.length < 2) return EMPTY;

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return EMPTY;

  const [
    { data: examAreas },
    { data: subjects },
    { data: topics },
    { data: questionRows },
    { data: materialRows },
    { data: flashcardRows },
    { data: mistakeRows },
  ] = await Promise.all([
    multiWordIlike(supabase.from("exam_areas").select("id, name"), "name", query)
      .order("sort_order")
      .limit(PER_CATEGORY_LIMIT),
    multiWordIlike(
      supabase.from("subjects").select("id, name, exam_area_id, exam_areas(name)"),
      "name",
      query,
    ).limit(PER_CATEGORY_LIMIT),
    multiWordIlike(
      supabase.from("topics").select("id, name, exam_area_id, subject_id, exam_areas(name)"),
      "name",
      query,
    ).limit(PER_CATEGORY_LIMIT),
    // student_questions is a view (published-only, safe columns) — avoid
    // relying on PostgREST embedding through it and instead batch-resolve
    // topic/area names below from a second, ordinary table query.
    multiWordIlike(
      supabase.from("student_questions").select("id, question_text, topic_id, subtopic_id"),
      "question_text",
      query,
    ).limit(PER_CATEGORY_LIMIT),
    multiWordIlike(
      supabase.from("reviewer_entries").select("id, title, kind, topic_id").eq("status", "published"),
      "title",
      query,
    ).limit(PER_CATEGORY_LIMIT),
    multiWordIlike(
      supabase.from("flashcards").select("id, front, topic_id").eq("status", "published"),
      "front",
      query,
    ).limit(PER_CATEGORY_LIMIT),
    supabase.rpc("get_mistake_bank"),
  ]);

  // Batch-resolve topic (name/exam_area_id/subject_id) for every topic_id
  // referenced by questions/materials/flashcards, in one query instead of
  // one per row.
  const referencedTopicIds = new Set<string>();
  for (const q of questionRows ?? []) referencedTopicIds.add(q.topic_id);
  for (const m of materialRows ?? []) referencedTopicIds.add(m.topic_id);
  for (const f of flashcardRows ?? []) referencedTopicIds.add(f.topic_id);

  const { data: referencedTopics } = referencedTopicIds.size
    ? await supabase
        .from("topics")
        .select("id, name, exam_area_id, subject_id, exam_areas(name)")
        .in("id", Array.from(referencedTopicIds))
    : { data: [] as never[] };

  type TopicLookupRow = {
    id: string;
    name: string;
    exam_area_id: string;
    subject_id: string | null;
    exam_areas: { name: string } | null;
  };
  const topicById = new Map<string, TopicLookupRow>(
    ((referencedTopics ?? []) as unknown as TopicLookupRow[]).map((t) => [t.id, t]),
  );

  const tos: SearchResult[] = ((examAreas ?? []) as { id: string; name: string }[]).map((a) => ({
    kind: "tos",
    id: a.id,
    label: a.name,
    sublabel: "TOS Area",
    href: questionBankHref({ areaId: a.id, subjectId: null }),
  }));

  type SubjectRow = { id: string; name: string; exam_area_id: string; exam_areas: { name: string } | null };
  const subjectResults: SearchResult[] = ((subjects ?? []) as unknown as SubjectRow[]).map((s) => ({
    kind: "subject",
    id: s.id,
    label: s.name,
    sublabel: s.exam_areas?.name ?? "Subject",
    href: questionBankHref({ areaId: s.exam_area_id, subjectId: s.id }),
  }));

  type TopicRow = { id: string; name: string; exam_area_id: string; subject_id: string | null; exam_areas: { name: string } | null };
  const topicResults: SearchResult[] = ((topics ?? []) as unknown as TopicRow[]).map((t) => ({
    kind: "topic",
    id: t.id,
    label: t.name,
    sublabel: t.exam_areas?.name ?? "Topic",
    href: questionBankHref({ areaId: t.exam_area_id, subjectId: t.subject_id, topicId: t.id }),
    topicId: t.id,
  }));

  const questions: SearchResult[] = ((questionRows ?? []) as { id: string; question_text: string; topic_id: string; subtopic_id: string | null }[])
    .map((q) => {
      const topic = topicById.get(q.topic_id);
      return {
        kind: "question" as const,
        id: q.id,
        label: q.question_text,
        sublabel: topic ? `${topic.exam_areas?.name ?? "TOS"} · ${topic.name}` : "Question",
        href: questionBankHref({
          areaId: topic?.exam_area_id ?? "",
          subjectId: topic?.subject_id ?? null,
          topicId: q.topic_id,
          subtopicId: q.subtopic_id,
          questionId: q.id,
        }),
      };
    })
    .filter((r) => r.href !== "/question-bank?areaId="); // topic lookup failed — shouldn't happen, but never link somewhere broken

  const KIND_LABEL: Record<string, string> = { formula: "Formula", table: "Table", constant: "Constant" };
  const materials: SearchResult[] = ((materialRows ?? []) as { id: string; title: string; kind: string; topic_id: string }[]).map((m) => {
    const topic = topicById.get(m.topic_id);
    return {
      kind: "material",
      id: m.id,
      label: m.title,
      sublabel: `${KIND_LABEL[m.kind] ?? "Material"}${topic ? ` · ${topic.name}` : ""}`,
      href: `/reviewers?q=${encodeURIComponent(m.title)}`,
    };
  });

  const flashcards: SearchResult[] = ((flashcardRows ?? []) as { id: string; front: string; topic_id: string }[]).map((f) => {
    const topic = topicById.get(f.topic_id);
    return {
      kind: "flashcard",
      id: f.id,
      label: f.front,
      sublabel: topic?.name ?? "Flashcard",
      href: `/flashcards?area=${f.topic_id}`,
    };
  });

  const lowerQuery = query.toLowerCase();
  const mistakes: SearchResult[] = ((mistakeRows ?? []) as { question_id: string; question_text: string; topic_name: string }[])
    .filter((m) => m.question_text.toLowerCase().includes(lowerQuery))
    .slice(0, PER_CATEGORY_LIMIT)
    .map((m) => ({
      kind: "mistake",
      id: m.question_id,
      label: m.question_text,
      sublabel: `Mistake Bank · ${m.topic_name}`,
      href: "/mistakes",
    }));

  return { tos, subjects: subjectResults, topics: topicResults, questions, materials, flashcards, mistakes };
}
