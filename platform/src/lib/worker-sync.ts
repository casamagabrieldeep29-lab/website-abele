import "server-only";
import { after } from "next/server";
import { createAdminClient } from "@/lib/supabase/admin";

/**
 * Keeps the Worker's copy of the PUBLISHED questions (api/, Turso) in step with what an admin just changed.
 * Called after an admin action edits, publishes, unpublishes or archives questions. For each id it reads the
 * question and its choices from Supabase, then tells the Worker to store it (when published) or drop it
 * (any other status, or gone). Correct answers and explanations are never sent.
 *
 * Never throws and never blocks the admin: it runs after the response, and a failure only means the Worker's
 * copy may lag until the next full export (`npm run content:export` in api/). The app also fills in any
 * question the Worker lacks from Supabase (src/lib/question-content.ts), so students are not affected either way.
 */
const WORKER_URL = process.env.CONTENT_API_URL ?? "https://api.abelieverofficial.com";
const CHUNK = 100;

type Choice = { id: string; choice_text: string; sort_order: number };
type Row = {
  id: string;
  topic_id: string;
  subtopic_id: string | null;
  question_text: string;
  question_type: string;
  difficulty: string | null;
  category: string | null;
  series_key: string | null;
  series_position: number | null;
  is_paes: boolean | null;
  paes_reference: string | null;
  additional_mock_areas: string[] | null;
  status: string;
  topics: { mock_area: string | null } | { mock_area: string | null }[] | null;
  choices: Choice[] | null;
};

export async function syncQuestionsToWorker(ids: string[]): Promise<void> {
  const key = process.env.CONTENT_API_KEY;
  const unique = [...new Set(ids)];
  if (!key || unique.length === 0) return;
  try {
    const admin = createAdminClient();
    for (let i = 0; i < unique.length; i += CHUNK) {
      const chunk = unique.slice(i, i + CHUNK);
      const { data, error } = await admin
        .from("questions")
        .select(
          "id, topic_id, subtopic_id, question_text, question_type, difficulty, category, series_key, series_position, is_paes, paes_reference, additional_mock_areas, status, topics(mock_area), choices(id, choice_text, sort_order)",
        )
        .in("id", chunk);
      if (error) throw new Error(error.message);

      const rows = (data ?? []) as unknown as Row[];
      const found = new Set(rows.map((r) => r.id));
      const upsert = rows
        .filter((r) => r.status === "published" && (r.choices?.length ?? 0) >= 2)
        .map((r) => ({
          id: r.id,
          topic_id: r.topic_id,
          subtopic_id: r.subtopic_id,
          question_text: r.question_text,
          question_type: r.question_type,
          difficulty: r.difficulty,
          category: r.category,
          series_key: r.series_key,
          series_position: r.series_position,
          is_paes: Boolean(r.is_paes),
          paes_reference: r.paes_reference,
          topic_mock_area: (Array.isArray(r.topics) ? r.topics[0]?.mock_area : r.topics?.mock_area) ?? null,
          additional_mock_areas: r.additional_mock_areas ?? [],
          // Exactly these three fields, whatever else the row carries: no correct-answer flag ever leaves Supabase.
          choices: [...(r.choices ?? [])]
            .sort((a, b) => a.sort_order - b.sort_order)
            .map((c) => ({ id: c.id, choice_text: c.choice_text, sort_order: c.sort_order })),
        }));
      const upserted = new Set(upsert.map((u) => u.id));
      // Anything not published (draft, archived, flagged out) or no longer in the database leaves the copy.
      const remove = chunk.filter((id) => !upserted.has(id) || !found.has(id));

      const res = await fetch(`${WORKER_URL}/v1/admin/sync`, {
        method: "POST",
        headers: { "x-internal-key": key, "content-type": "application/json" },
        body: JSON.stringify({ upsert, remove }),
        signal: AbortSignal.timeout(15000),
        cache: "no-store",
      });
      if (!res.ok) throw new Error(`Worker sync answered ${res.status}`);
    }
  } catch (err) {
    console.error("[worker-sync] failed, the Worker copy may lag until the next export:", err instanceof Error ? err.message : err);
  }
}

/** Run the sync after the response is sent, so an admin click is never slowed down by it. */
export function syncQuestionsInBackground(ids: string[]) {
  after(() => syncQuestionsToWorker(ids));
}
