/**
 * Topic / area / subject / subtopic names used to be copied onto all ~2,000
 * reviewer entries by the server (about a quarter of the page payload, mostly
 * the same few dozen strings repeated). Instead the server sends one small
 * lookup table and the browser attaches the names itself.
 */
export type EntryLookup = {
  topics: Record<
    string,
    { name: string; examAreaId: string; examAreaName: string; subjectName: string }
  >;
  subtopics: Record<string, string>;
};

type Taxonomy = {
  topics: { id: string; name: string; exam_area_id: string; subject_id: string | null }[];
  subtopics: { id: string; name: string }[];
  examAreas: { id: string; name: string }[];
  subjects: { id: string; name: string }[];
};

/** Server side: build the small lookup from the cached taxonomy. */
export function buildEntryLookup(taxonomy: Taxonomy): EntryLookup {
  const areaName = new Map(taxonomy.examAreas.map((a) => [a.id, a.name]));
  const subjectName = new Map(taxonomy.subjects.map((s) => [s.id, s.name]));
  const topics: EntryLookup["topics"] = {};
  for (const t of taxonomy.topics) {
    topics[t.id] = {
      name: t.name,
      examAreaId: t.exam_area_id,
      examAreaName: areaName.get(t.exam_area_id) ?? "Unknown area",
      subjectName: t.subject_id ? (subjectName.get(t.subject_id) ?? "Other Topics") : "Other Topics",
    };
  }
  return { topics, subtopics: Object.fromEntries(taxonomy.subtopics.map((s) => [s.id, s.name])) };
}

/** Browser side: attach the names. Same fallbacks the server used to apply. */
export function expandEntry<T extends { topic_id: string; subtopic_id: string | null }>(e: T, lookup: EntryLookup) {
  const topic = lookup.topics[e.topic_id];
  return {
    ...e,
    topic_name: topic?.name ?? "Unknown topic",
    exam_area_id: topic?.examAreaId ?? "unknown",
    exam_area_name: topic?.examAreaName ?? "Unknown area",
    subject_name: topic?.subjectName ?? "Other Topics",
    subtopic_name: e.subtopic_id ? (lookup.subtopics[e.subtopic_id] ?? null) : null,
  };
}
