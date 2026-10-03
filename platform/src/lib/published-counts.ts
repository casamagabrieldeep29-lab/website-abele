import "server-only";
import { unstable_cache } from "next/cache";
import { createAdminClient } from "@/lib/supabase/admin";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { countWords } from "@/lib/word-count";

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
 * published-only view. Counts can lag a change made outside the admin screens (e.g. a raw SQL import) by up to
 * REVALIDATE_SECONDS; admin publish actions call revalidateTag(TAG) to make
 * it immediate.
 */
export const PUBLISHED_COUNTS_TAG = "published-counts";
const REVALIDATE_SECONDS = 24 * 60 * 60;

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

export type CandidateQuestion = {
  id: string;
  topic_id: string;
  series_key: string | null;
  series_position: number | null;
};

/**
 * Every published question as the minimal row adaptive sampling needs. Quick
 * Practice used to download this whole list (~4,000 rows, ~540 KB) from Supabase
 * on every session start; it is the same for every student, so it is cached
 * and shared like the counts above (same tag, so publish/unpublish expires it).
 */
export const getCandidatePool = unstable_cache(
  async (): Promise<CandidateQuestion[]> => {
    const admin = createAdminClient();
    return fetchAllRows<CandidateQuestion>((from, to) =>
      admin
        .from("student_questions")
        .select("id, topic_id, series_key, series_position")
        .order("id")
        .range(from, to),
    );
  },
  ["candidate-pool-v1"],
  { revalidate: REVALIDATE_SECONDS, tags: [PUBLISHED_COUNTS_TAG] },
);

export type MockPoolRow = {
  id: string;
  topic_id: string;
  series_key: string | null;
  series_position: number | null;
  mock_area: string;
  extra_areas: string[];
  /** Word count of the question text, precomputed so the text itself never leaves the cache. */
  words: number;
};

/**
 * Everything a mock-exam start needs to choose questions, without the question
 * text: starting a mock used to download every question of the area WITH its
 * full text (~1 MB) from Supabase. Questions flagged "FLAGGED FOR REVIEW" are
 * already excluded here. Shared and cached like the rest; publish/unpublish
 * expires it through the same tag.
 */
export const getMockPool = unstable_cache(
  async (): Promise<MockPoolRow[]> => {
    const admin = createAdminClient();
    const [rows, flagged] = await Promise.all([
      fetchAllRows<{
        id: string;
        topic_id: string;
        series_key: string | null;
        series_position: number | null;
        question_text: string | null;
        topic_mock_area: string;
        additional_mock_areas: string[] | null;
      }>((from, to) =>
        admin
          .from("student_questions")
          .select("id, topic_id, series_key, series_position, question_text, topic_mock_area, additional_mock_areas")
          .order("id")
          .range(from, to),
      ),
      fetchAllRows<{ id: string }>((from, to) =>
        admin.from("questions").select("id").ilike("explanation", "%FLAGGED FOR REVIEW%").order("id").range(from, to),
      ),
    ]);
    const flaggedIds = new Set(flagged.map((r) => r.id));
    return rows
      .filter((r) => !flaggedIds.has(r.id))
      .map((r) => ({
        id: r.id,
        topic_id: r.topic_id,
        series_key: r.series_key,
        series_position: r.series_position,
        mock_area: r.topic_mock_area,
        extra_areas: r.additional_mock_areas ?? [],
        words: countWords(r.question_text),
      }));
  },
  ["mock-pool-v1"],
  { revalidate: REVALIDATE_SECONDS, tags: [PUBLISHED_COUNTS_TAG] },
);

export type RecalledQuestionRow = {
  question_id: string;
  question_text: string;
  explanation: string | null;
  recalled_batch: string | null;
  topic_name: string;
  mock_area: string;
  choices: { text: string; is_correct: boolean }[] | null;
};

/**
 * The Recalled Questions document (every recalled question with its choices and
 * answers, ~240 KB) is identical for every student, so it is fetched once and
 * shared instead of being re-downloaded on each visit. Same tag as the rest:
 * publishing/unpublishing expires it.
 */
export const getRecalledQuestions = unstable_cache(
  async (): Promise<RecalledQuestionRow[]> => {
    const admin = createAdminClient();
    const { data, error } = await admin.rpc("get_recalled_questions");
    if (error) throw new Error(error.message);
    return (data ?? []) as RecalledQuestionRow[];
  },
  ["recalled-questions-v1"],
  { revalidate: REVALIDATE_SECONDS, tags: [PUBLISHED_COUNTS_TAG] },
);
