import "server-only";
import { revalidateTag, unstable_cache } from "next/cache";
import { createAdminClient } from "@/lib/supabase/admin";
import { fetchAllRows } from "@/lib/supabase/paginate";

/**
 * Content that is identical for every student (published reviewer entries and
 * the topic/subject taxonomy) is read once and shared through the Next data
 * cache instead of being re-downloaded from Supabase on every page view.
 *
 * Why this exists: Supabase Free allows only 5 GB of egress per month. The
 * Reviewers page alone pulled ~1.3 MB per visit and the PAES Library ~1 MB,
 * which at a few hundred students used up the whole allowance. Never read a
 * whole shared table per request again — add it here (cached, tagged, and
 * expired by the matching admin action).
 *
 * Service-role client on purpose: a cached entry is shared across users so it
 * can't depend on one user's session. Only published rows are ever read.
 * Vercel's data cache refuses items over 2 MB; the reviewer snapshot is ~1.4 MB,
 * so it warns loudly well before that point.
 */
export const REVIEWER_CONTENT_TAG = "reviewer-content";
export const TAXONOMY_TAG = "taxonomy";
const CACHE_TTL_SECONDS = 24 * 60 * 60; // admin edits expire the tags immediately, so a long TTL is safe
const CACHE_ITEM_WARN_BYTES = 1_700_000;

export type SharedReviewerRow = {
  id: string;
  kind: "formula" | "table" | "constant";
  title: string;
  formula: string | null;
  variables: string | null;
  symbol: string | null;
  value: string | null;
  unit: string | null;
  table_content: string | null;
  description: string | null;
  notes: string | null;
  source: string | null;
  topic_id: string;
  subtopic_id: string | null;
  paes_reference: string | null;
};

export const getPublishedReviewerEntries = unstable_cache(
  async (): Promise<SharedReviewerRow[]> => {
    const admin = createAdminClient();
    const rows = await fetchAllRows<SharedReviewerRow>((from, to) =>
      admin
        .from("reviewer_entries")
        .select(
          "id, kind, title, formula, variables, symbol, value, unit, table_content, description, notes, source, topic_id, subtopic_id, paes_reference",
        )
        .eq("status", "published")
        .order("title")
        .order("id")
        .range(from, to),
    );
    const bytes = JSON.stringify(rows).length;
    if (bytes > CACHE_ITEM_WARN_BYTES) {
      console.warn(
        `[shared-content] reviewer snapshot is ${bytes} bytes — close to the 2 MB data-cache limit; split it before it stops being cached.`,
      );
    }
    return rows;
  },
  ["reviewer-entries-v1"],
  { revalidate: CACHE_TTL_SECONDS, tags: [REVIEWER_CONTENT_TAG] },
);

export type SharedTaxonomy = {
  topics: { id: string; name: string; mock_area: string; exam_area_id: string; subject_id: string | null }[];
  subtopics: { id: string; name: string; topic_id: string }[];
  examAreas: { id: string; name: string; sort_order: number; weight_percent: number | null }[];
  subjects: { id: string; exam_area_id: string; name: string; sort_order: number }[];
};

export const getTaxonomy = unstable_cache(
  async (): Promise<SharedTaxonomy> => {
    const admin = createAdminClient();
    const [topics, subtopics, examAreas, subjects] = await Promise.all([
      admin.from("topics").select("id, name, mock_area, exam_area_id, subject_id").order("name"),
      admin.from("subtopics").select("id, name, topic_id").order("name"),
      admin.from("exam_areas").select("id, name, sort_order, weight_percent").order("sort_order"),
      admin.from("subjects").select("id, exam_area_id, name, sort_order").order("sort_order"),
    ]);
    for (const r of [topics, subtopics, examAreas, subjects]) {
      if (r.error) throw r.error;
    }
    return {
      topics: topics.data ?? [],
      subtopics: subtopics.data ?? [],
      examAreas: examAreas.data ?? [],
      subjects: subjects.data ?? [],
    };
  },
  ["taxonomy-v1"],
  { revalidate: CACHE_TTL_SECONDS, tags: [TAXONOMY_TAG] },
);

export function expireReviewerContent() {
  revalidateTag(REVIEWER_CONTENT_TAG, { expire: 0 });
}

export function expireTaxonomy() {
  revalidateTag(TAXONOMY_TAG, { expire: 0 });
}
