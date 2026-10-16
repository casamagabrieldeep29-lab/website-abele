import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";
import { getAuthContext } from "@/lib/auth/session";

/**
 * Where the question text and choices for a session come from.
 *
 *   CONTENT_SOURCE=supabase     (default) read from Supabase, exactly as before
 *   CONTENT_SOURCE=turso:admin  admins only read from the Worker (first rollout step)
 *   CONTENT_SOURCE=turso        everyone reads from the Worker
 *
 * The Worker (api/, https://api.abelieverofficial.com) serves a copy of the PUBLISHED content, so it never
 * holds answers or explanations: grading stays in Supabase. It is a copy, so:
 *   - any id the Worker doesn't have yet (a question published after the last export) is filled in from Supabase;
 *   - any Worker error or a response slower than 3 s falls back to Supabase completely.
 * A student therefore never sees an error because of the Worker.
 */
export type QuestionRow = { id: string; question_text: string; category: "term" | "solving" | null; paes_reference: string | null };
export type ChoiceRow = { id: string; question_id: string; choice_text: string; sort_order: number };
export type QuestionContent = { questions: QuestionRow[]; choices: ChoiceRow[] };

const WORKER_URL = process.env.CONTENT_API_URL ?? "https://api.abelieverofficial.com";
const WORKER_TIMEOUT_MS = 3000;
const MAX_IDS_PER_CALL = 50;

async function workerEnabled(): Promise<boolean> {
  const mode = process.env.CONTENT_SOURCE ?? "supabase";
  if (mode === "turso") return true;
  if (mode === "turso:admin") {
    try {
      const { profile } = await getAuthContext();
      return profile?.role === "admin";
    } catch {
      return false;
    }
  }
  return false;
}

async function fromWorker(ids: string[]): Promise<QuestionContent> {
  const key = process.env.CONTENT_API_KEY;
  if (!key) throw new Error("CONTENT_API_KEY is not set");
  const chunks: string[][] = [];
  for (let i = 0; i < ids.length; i += MAX_IDS_PER_CALL) chunks.push(ids.slice(i, i + MAX_IDS_PER_CALL));

  type WorkerQuestion = QuestionRow & { choices: { id: string; choice_text: string; sort_order: number }[] };
  const parts = await Promise.all(
    chunks.map(async (chunk) => {
      const res = await fetch(`${WORKER_URL}/v1/questions?ids=${chunk.join(",")}`, {
        headers: { "x-internal-key": key },
        signal: AbortSignal.timeout(WORKER_TIMEOUT_MS),
        cache: "no-store",
      });
      if (!res.ok) throw new Error(`Worker answered ${res.status}`);
      return (await res.json()) as WorkerQuestion[];
    }),
  );

  const questions: QuestionRow[] = [];
  const choices: ChoiceRow[] = [];
  for (const q of parts.flat()) {
    questions.push({ id: q.id, question_text: q.question_text, category: q.category ?? null, paes_reference: q.paes_reference ?? null });
    for (const c of q.choices) choices.push({ id: c.id, question_id: q.id, choice_text: c.choice_text, sort_order: c.sort_order });
  }
  return { questions, choices };
}

async function fromSupabase(supabase: SupabaseClient, ids: string[]): Promise<QuestionContent> {
  const [{ data: questions }, { data: choices }] = await Promise.all([
    supabase.from("student_questions").select("id, question_text, category, paes_reference").in("id", ids),
    supabase.from("student_choices").select("id, question_id, choice_text, sort_order").in("question_id", ids).order("sort_order"),
  ]);
  return { questions: (questions ?? []) as QuestionRow[], choices: (choices ?? []) as ChoiceRow[] };
}

/** Question text + choices for exactly these ids (any order). Never throws because of the Worker. */
export async function loadQuestionContent(supabase: SupabaseClient, ids: string[]): Promise<QuestionContent> {
  if (ids.length === 0) return { questions: [], choices: [] };
  if (await workerEnabled()) {
    try {
      const w = await fromWorker(ids);
      const have = new Set(w.questions.map((q) => q.id));
      const missing = ids.filter((id) => !have.has(id));
      if (missing.length === 0) return w;
      const rest = await fromSupabase(supabase, missing);
      return { questions: [...w.questions, ...rest.questions], choices: [...w.choices, ...rest.choices] };
    } catch (err) {
      console.error("[content] Worker unavailable, using Supabase:", err instanceof Error ? err.message : err);
    }
  }
  return fromSupabase(supabase, ids);
}
