import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";
import { getTaxonomy } from "@/lib/shared-content";

export type MasteryStatus = "insufficient_data" | "strong" | "developing" | "needs_review";

export type FullTopicMasteryRow = {
  topic_id: string;
  topic_name: string;
  exam_area_id: string;
  exam_area_name: string;
  subject_id: string | null;
  subject_name: string | null;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: MasteryStatus;
  last_answered_at: string | null;
};

export type FullSubtopicMasteryRow = {
  subtopic_id: string;
  subtopic_name: string;
  topic_id: string;
  topic_name: string;
  exam_area_id: string;
  exam_area_name: string;
  subject_id: string | null;
  subject_name: string | null;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: MasteryStatus;
  last_answered_at: string | null;
};

type Compact = [string, number, number | null, number | null, number | null, MasteryStatus, string | null];

const EMPTY = {
  total_attempts: 0,
  overall_accuracy: null,
  recent_accuracy: null,
  mastery: null,
  status: "insufficient_data" as MasteryStatus,
  last_answered_at: null,
};

/**
 * Same rows get_topic_mastery() has always returned, but fetched as a compact
 * numeric array (get_topic_mastery_compact, patch 048: ~3 KB instead of ~20 KB)
 * and re-joined with the topic/area/subject names from the cached taxonomy.
 * Topics the student has never answered are filled in with the same "no data"
 * values the original function returned. If the compact function isn't
 * installed yet, silently falls back to the original so nothing breaks.
 */
export async function fetchTopicMastery(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: SupabaseClient<any>,
): Promise<{ data: FullTopicMasteryRow[] | null }> {
  const { data: compact, error } = await supabase.rpc("get_topic_mastery_compact");
  if (error || !Array.isArray(compact)) {
    const legacy = await supabase.rpc("get_topic_mastery");
    return { data: (legacy.data as FullTopicMasteryRow[] | null) ?? null };
  }

  const taxonomy = await getTaxonomy();
  const areaName = new Map(taxonomy.examAreas.map((a) => [a.id, a.name]));
  const subjectName = new Map(taxonomy.subjects.map((s) => [s.id, s.name]));
  const byTopic = new Map((compact as Compact[]).map((c) => [c[0], c]));

  const rows = taxonomy.topics
    .filter((t) => areaName.has(t.exam_area_id))
    .map((t): FullTopicMasteryRow => {
      const c = byTopic.get(t.id);
      return {
        topic_id: t.id,
        topic_name: t.name,
        exam_area_id: t.exam_area_id,
        exam_area_name: areaName.get(t.exam_area_id)!,
        subject_id: t.subject_id,
        subject_name: t.subject_id ? (subjectName.get(t.subject_id) ?? null) : null,
        ...(c
          ? {
              total_attempts: c[1],
              overall_accuracy: c[2],
              recent_accuracy: c[3],
              mastery: c[4],
              status: c[5],
              last_answered_at: c[6],
            }
          : EMPTY),
      };
    });
  return { data: rows };
}

/** Subtopic ("concept") counterpart of fetchTopicMastery — same approach, same fallback. */
export async function fetchSubtopicMastery(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: SupabaseClient<any>,
): Promise<{ data: FullSubtopicMasteryRow[] | null }> {
  const { data: compact, error } = await supabase.rpc("get_subtopic_mastery_compact");
  if (error || !Array.isArray(compact)) {
    const legacy = await supabase.rpc("get_subtopic_mastery");
    return { data: (legacy.data as FullSubtopicMasteryRow[] | null) ?? null };
  }

  const taxonomy = await getTaxonomy();
  const areaName = new Map(taxonomy.examAreas.map((a) => [a.id, a.name]));
  const subjectName = new Map(taxonomy.subjects.map((s) => [s.id, s.name]));
  const bySubtopic = new Map((compact as Compact[]).map((c) => [c[0], c]));

  // Original order: by topic name, then subtopic name.
  const rows: FullSubtopicMasteryRow[] = [];
  for (const t of taxonomy.topics) {
    if (!areaName.has(t.exam_area_id)) continue;
    for (const st of taxonomy.subtopics) {
      if (st.topic_id !== t.id) continue;
      const c = bySubtopic.get(st.id);
      rows.push({
        subtopic_id: st.id,
        subtopic_name: st.name,
        topic_id: t.id,
        topic_name: t.name,
        exam_area_id: t.exam_area_id,
        exam_area_name: areaName.get(t.exam_area_id)!,
        subject_id: t.subject_id,
        subject_name: t.subject_id ? (subjectName.get(t.subject_id) ?? null) : null,
        ...(c
          ? {
              total_attempts: c[1],
              overall_accuracy: c[2],
              recent_accuracy: c[3],
              mastery: c[4],
              status: c[5],
              last_answered_at: c[6],
            }
          : EMPTY),
      });
    }
  }
  return { data: rows };
}
