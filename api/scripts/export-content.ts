/**
 * One-time (and repeatable) export of SHARED content from Supabase into the Worker's database:
 * taxonomy + PUBLISHED questions + their choices. Correct answers and explanations are never
 * exported. Read-only on Supabase (about 3 MB of egress per run). Replaces the target's content
 * in one batch, then checks the counts against Supabase.
 *
 *   npm run content:export                 # into api/.local/abeliever.db
 *   TURSO_URL=... TURSO_TOKEN=... npm run content:export
 */
import { createClient } from "@libsql/client";
import { existsSync, mkdirSync, readFileSync } from "node:fs";
import { applyMigrations } from "../src/migrate";
import { loadDevVars } from "./env";

loadDevVars(); // TURSO_URL / TURSO_TOKEN for the target database (omit both to use the local file)

// Local convenience: reuse the web app's env file for the Supabase URL and service key.
function loadEnvFile(path: string) {
  if (!existsSync(path)) return;
  for (const line of readFileSync(path, "utf8").split(/\r?\n/)) {
    const m = /^([A-Z_]+)=(.*)$/.exec(line);
    if (m && !(m[1] in process.env)) process.env[m[1]] = m[2].trim().replace(/^["']|["']$/g, "");
  }
}
loadEnvFile("../platform/.env.local");

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!SUPABASE_URL || !KEY) throw new Error("Need NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY");

async function fetchAll<T>(path: string): Promise<T[]> {
  const out: T[] = [];
  for (let from = 0; ; from += 1000) {
    const res = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
      headers: { apikey: KEY!, Authorization: `Bearer ${KEY}`, Range: `${from}-${from + 999}` },
    });
    if (!res.ok) throw new Error(`${path}: ${res.status} ${await res.text()}`);
    const rows = (await res.json()) as T[];
    out.push(...rows);
    if (rows.length < 1000) return out;
  }
}

type T = Record<string, string | number | boolean | null | string[]>;

mkdirSync(".local", { recursive: true });
const client = createClient({ url: process.env.TURSO_URL ?? "file:.local/abeliever.db", authToken: process.env.TURSO_TOKEN });
await applyMigrations(client);

const [areas, subjects, topics, subtopics, questions, choices] = await Promise.all([
  fetchAll<T>("exam_areas?select=id,name,sort_order,weight_percent&order=sort_order"),
  fetchAll<T>("subjects?select=id,exam_area_id,name,sort_order&order=sort_order"),
  fetchAll<T>("topics?select=id,name,mock_area,exam_area_id,subject_id&order=name"),
  fetchAll<T>("subtopics?select=id,name,topic_id&order=name"),
  fetchAll<T>(
    "questions?select=id,topic_id,subtopic_id,question_text,question_type,difficulty,category,series_key,series_position,is_paes,paes_reference,additional_mock_areas&status=eq.published&order=id",
  ),
  // The student view: published questions only, and it has no is_correct column.
  fetchAll<T>("student_choices?select=id,question_id,choice_text,sort_order&order=question_id,sort_order"),
]);

const mockArea = new Map(topics.map((t) => [t.id as string, t.mock_area as string | null]));
const stmts: { sql: string; args: (string | number | null)[] }[] = [];
for (const t of ["choices", "questions", "subtopics", "topics", "subjects", "exam_areas", "content_meta"]) {
  stmts.push({ sql: `DELETE FROM ${t}`, args: [] });
}
const ins = (table: string, cols: string[], row: (string | number | null)[]) =>
  stmts.push({ sql: `INSERT INTO ${table} (${cols.join(",")}) VALUES (${cols.map(() => "?").join(",")})`, args: row });
const s = (v: unknown) => (v == null ? null : String(v));
const n = (v: unknown) => (v == null ? null : Number(v));

for (const a of areas) ins("exam_areas", ["id", "name", "sort_order", "weight_percent"], [s(a.id), s(a.name), n(a.sort_order) ?? 0, n(a.weight_percent)]);
for (const x of subjects) ins("subjects", ["id", "exam_area_id", "name", "sort_order"], [s(x.id), s(x.exam_area_id), s(x.name), n(x.sort_order) ?? 0]);
for (const x of topics) ins("topics", ["id", "name", "mock_area", "exam_area_id", "subject_id"], [s(x.id), s(x.name), s(x.mock_area), s(x.exam_area_id), s(x.subject_id)]);
for (const x of subtopics) ins("subtopics", ["id", "name", "topic_id"], [s(x.id), s(x.name), s(x.topic_id)]);
for (const q of questions) {
  ins(
    "questions",
    ["id", "topic_id", "subtopic_id", "question_text", "question_type", "difficulty", "category", "series_key", "series_position", "is_paes", "paes_reference", "topic_mock_area", "additional_mock_areas"],
    [s(q.id), s(q.topic_id), s(q.subtopic_id), s(q.question_text), s(q.question_type), s(q.difficulty), s(q.category), s(q.series_key), n(q.series_position), q.is_paes ? 1 : 0, s(q.paes_reference), mockArea.get(String(q.topic_id)) ?? null, JSON.stringify(q.additional_mock_areas ?? [])],
  );
}
for (const c of choices) ins("choices", ["id", "question_id", "choice_text", "sort_order"], [s(c.id), s(c.question_id), s(c.choice_text), n(c.sort_order) ?? 0]);
ins("content_meta", ["key", "value"], ["exported_at", new Date().toISOString()]);
ins("content_meta", ["key", "value"], ["counts", JSON.stringify({ questions: questions.length, choices: choices.length })]);

// Batches keep each request small enough for Turso.
for (let i = 0; i < stmts.length; i += 400) await client.batch(stmts.slice(i, i + 400), "write");

// Verify: counts match, and every question has exactly 4 choices.
const count = async (t: string) => Number((await client.execute(`SELECT COUNT(*) AS c FROM ${t}`)).rows[0].c);
const [qc, cc] = [await count("questions"), await count("choices")];
const bad = (await client.execute("SELECT COUNT(*) AS c FROM (SELECT question_id FROM choices GROUP BY question_id HAVING COUNT(*) != 4)")).rows[0].c;
const noChoices = (await client.execute("SELECT COUNT(*) AS c FROM questions q WHERE NOT EXISTS (SELECT 1 FROM choices c WHERE c.question_id = q.id)")).rows[0].c;
console.log(`exported: ${areas.length} areas, ${subjects.length} subjects, ${topics.length} topics, ${subtopics.length} subtopics, ${qc} questions, ${cc} choices`);
console.log(`check: questions match Supabase: ${qc === questions.length}; choices match: ${cc === choices.length}; questions without exactly 4 choices: ${Number(bad) + Number(noChoices)}`);
if (qc !== questions.length || cc !== choices.length) process.exitCode = 1;
client.close();
