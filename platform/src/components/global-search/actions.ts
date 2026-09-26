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

/**
 * Same normalization patch 035's search_normalize() applies in SQL — used
 * here only for the "mistakes" category, which stays a small in-memory
 * substring filter (get_mistake_bank() is already scoped to the caller's
 * own, typically-small mistake list, so it doesn't need a ranked SQL
 * function of its own) and for detecting an empty overall result set.
 */
function normalize(text: string): string {
  return text.trim().toLowerCase().replace(/\s+/g, " ");
}

export type GlobalSearchResponse = {
  results: GlobalSearchResults;
  /** Real, existing names only (from search_suggestions()) — populated
   * exclusively when every category above came back empty. Never
   * fabricated. */
  suggestions: string[];
};

export async function globalSearch(rawQuery: string): Promise<GlobalSearchResponse> {
  const query = normalize(rawQuery);
  if (query.length < 2) return { results: EMPTY, suggestions: [] };

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { results: EMPTY, suggestions: [] };

  // Each RPC (patch 035_search_relevance.sql) does its own tiered
  // relevance scoring — exact > prefix > all-words > some-words > fuzzy
  // (typo) fallback — and returns already limited to PER_CATEGORY_LIMIT,
  // ordered best-first. No client-side re-ranking needed.
  const [
    { data: examAreaRows },
    { data: subjectRows },
    { data: topicRows },
    { data: questionRows },
    { data: materialRows },
    { data: flashcardRows },
    { data: mistakeRows },
  ] = await Promise.all([
    supabase.rpc("search_exam_areas", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("search_subjects", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("search_topics", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("search_questions", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("search_materials", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("search_flashcards", { p_query: query, p_limit: PER_CATEGORY_LIMIT }),
    supabase.rpc("get_mistake_bank"),
  ]);

  const tos: SearchResult[] = ((examAreaRows ?? []) as { id: string; name: string }[]).map((a) => ({
    kind: "tos",
    id: a.id,
    label: a.name,
    sublabel: "TOS Area",
    href: questionBankHref({ areaId: a.id, subjectId: null }),
  }));

  type SubjectRow = { id: string; name: string; exam_area_id: string; exam_area_name: string | null };
  const subjects: SearchResult[] = ((subjectRows ?? []) as SubjectRow[]).map((s) => ({
    kind: "subject",
    id: s.id,
    label: s.name,
    sublabel: s.exam_area_name ?? "Subject",
    href: questionBankHref({ areaId: s.exam_area_id, subjectId: s.id }),
  }));

  type TopicRow = { id: string; name: string; exam_area_id: string; subject_id: string | null; exam_area_name: string | null };
  const topics: SearchResult[] = ((topicRows ?? []) as TopicRow[]).map((t) => ({
    kind: "topic",
    id: t.id,
    label: t.name,
    sublabel: t.exam_area_name ?? "Topic",
    href: questionBankHref({ areaId: t.exam_area_id, subjectId: t.subject_id, topicId: t.id }),
    topicId: t.id,
  }));

  type QuestionRow = {
    id: string;
    question_text: string;
    topic_id: string;
    subtopic_id: string | null;
    topic_name: string | null;
    exam_area_name: string | null;
  };
  const questionRowsTyped = (questionRows ?? []) as QuestionRow[];

  const KIND_LABEL: Record<string, string> = { formula: "Formula", table: "Table", constant: "Constant" };
  type MaterialRow = { id: string; title: string; kind: string; topic_id: string; topic_name: string | null };
  const materialRowsTyped = (materialRows ?? []) as MaterialRow[];

  type FlashcardRow = { id: string; front: string; topic_id: string; topic_name: string | null };
  const flashcardRowsTyped = (flashcardRows ?? []) as FlashcardRow[];

  // Question results are the only category whose href needs the topic's
  // full ancestor chain (exam_area_id + subject_id), which search_questions()
  // doesn't return — batch-resolve those from the topic ids it did return,
  // same one-query-not-N-queries pattern the old implementation used.
  const referencedTopicIds = new Set(questionRowsTyped.map((q) => q.topic_id));
  const { data: ancestorTopics } = referencedTopicIds.size
    ? await supabase.from("topics").select("id, exam_area_id, subject_id").in("id", Array.from(referencedTopicIds))
    : { data: [] as { id: string; exam_area_id: string; subject_id: string | null }[] };
  const ancestorById = new Map((ancestorTopics ?? []).map((t) => [t.id, t]));

  const questions: SearchResult[] = questionRowsTyped
    .map((q) => {
      const ancestors = ancestorById.get(q.topic_id);
      return {
        kind: "question" as const,
        id: q.id,
        label: q.question_text,
        sublabel: q.topic_name ? `${q.exam_area_name ?? "TOS"} · ${q.topic_name}` : "Question",
        href: questionBankHref({
          areaId: ancestors?.exam_area_id ?? "",
          subjectId: ancestors?.subject_id ?? null,
          topicId: q.topic_id,
          subtopicId: q.subtopic_id,
          questionId: q.id,
        }),
      };
    })
    .filter((r) => r.href !== "/question-bank?areaId="); // ancestor lookup failed — shouldn't happen, but never link somewhere broken

  const materials: SearchResult[] = materialRowsTyped.map((m) => ({
    kind: "material",
    id: m.id,
    label: m.title,
    sublabel: `${KIND_LABEL[m.kind] ?? "Material"}${m.topic_name ? ` · ${m.topic_name}` : ""}`,
    href: `/reviewers?q=${encodeURIComponent(m.title)}`,
  }));

  const flashcards: SearchResult[] = flashcardRowsTyped.map((f) => ({
    kind: "flashcard",
    id: f.id,
    label: f.front,
    sublabel: f.topic_name ?? "Flashcard",
    href: `/flashcards?area=${f.topic_id}`,
  }));

  const mistakes: SearchResult[] = ((mistakeRows ?? []) as { question_id: string; question_text: string; topic_name: string }[])
    .filter((m) => normalize(m.question_text).includes(query))
    .slice(0, PER_CATEGORY_LIMIT)
    .map((m) => ({
      kind: "mistake",
      id: m.question_id,
      label: m.question_text,
      sublabel: `Mistake Bank · ${m.topic_name}`,
      href: "/mistakes",
    }));

  const results: GlobalSearchResults = { tos, subjects, topics, questions, materials, flashcards, mistakes };
  const hasAnyResults = Object.values(results).some((list) => list.length > 0);

  let suggestions: string[] = [];
  if (!hasAnyResults) {
    const { data: suggestionRows } = await supabase.rpc("search_suggestions", { p_query: query, p_limit: 3 });
    suggestions = ((suggestionRows ?? []) as { label: string }[]).map((s) => s.label);
  }

  return { results, suggestions };
}
