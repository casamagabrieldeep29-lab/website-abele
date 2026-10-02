import "server-only";
import { unstable_cache } from "next/cache";
import { createAdminClient } from "@/lib/supabase/admin";
import { fetchAllRows } from "@/lib/supabase/paginate";

export type PublishedSnapshot = {
  /** Every published question id, sorted — the daily question indexes into this. */
  ids: string[];
  byTopic: Record<string, number>;
  bySubtopic: Record<string, number>;
  byMockArea: { area_1: number; area_2: number; area_3: number };
};

type Row = {
  id: string;
  topic_id: string;
  subtopic_id: string | null;
  topic_mock_area: string;
  additional_mock_areas: string[] | null;
};

/**
 * Practice, Mock, Question Bank and the Dashboard each used to re-download the
 * entire `student_questions` view (4,000+ rows = 5+ paginated round trips) on
 * every page view just to count questions per topic. That data is identical
 * for every user (published questions only, no per-user filtering), so it is
 * computed once and shared via the Next data cache instead.
 *
 * Uses the service-role client because a cached entry is shared across users
 * and must not depend on any one user's session. It only ever reads the
 * published-only view. Counts can lag a publish/unpublish by up to
 * REVALIDATE_SECONDS; admin publish actions call revalidateTag(TAG) to make
 * it immediate.
 */
export const PUBLISHED_COUNTS_TAG = "published-counts";
const REVALIDATE_SECONDS = 600;

export const getPublishedSnapshot = unstable_cache(
  async (): Promise<PublishedSnapshot> => {
    const admin = createAdminClient();
    const rows = await fetchAllRows<Row>((from, to) =>
      admin
        .from("student_questions")
        .select("id, topic_id, subtopic_id, topic_mock_area, additional_mock_areas")
        .order("id")
        .range(from, to),
    );

    const snapshot: PublishedSnapshot = {
      ids: [],
      byTopic: {},
      bySubtopic: {},
      byMockArea: { area_1: 0, area_2: 0, area_3: 0 },
    };

    for (const q of rows) {
      snapshot.ids.push(q.id);
      snapshot.byTopic[q.topic_id] = (snapshot.byTopic[q.topic_id] ?? 0) + 1;
      if (q.subtopic_id) snapshot.bySubtopic[q.subtopic_id] = (snapshot.bySubtopic[q.subtopic_id] ?? 0) + 1;
      const areas = new Set<string>([q.topic_mock_area, ...(q.additional_mock_areas ?? [])]);
      for (const a of areas) {
        if (a in snapshot.byMockArea) snapshot.byMockArea[a as keyof PublishedSnapshot["byMockArea"]] += 1;
      }
    }

    return snapshot;
  },
  ["published-snapshot-v1"],
  { revalidate: REVALIDATE_SECONDS, tags: [PUBLISHED_COUNTS_TAG] },
);
