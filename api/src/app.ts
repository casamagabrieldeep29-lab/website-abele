import { Hono } from "hono";
import { SQL } from "./sql";
import type { AuthUser, Db, Env, Stmt } from "./types";

const MAX_SYNC = 100;
export type SyncQuestion = {
  id: string;
  topic_id: string;
  subtopic_id?: string | null;
  question_text: string;
  question_type: string;
  difficulty?: string | null;
  category?: string | null;
  series_key?: string | null;
  series_position?: number | null;
  is_paes?: boolean;
  paes_reference?: string | null;
  topic_mock_area?: string | null;
  additional_mock_areas?: string[];
  choices: { id: string; choice_text: string; sort_order: number }[];
};

/** Returns a short reason when a sync body is malformed, otherwise null. Never trusts the shape. */
function validateSync(upsert: SyncQuestion[], remove: string[]): string | null {
  const uuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  if (remove.some((id) => typeof id !== "string" || !uuid.test(id))) return "remove: bad id";
  for (const q of upsert) {
    if (!q || typeof q.id !== "string" || !uuid.test(q.id) || typeof q.topic_id !== "string" || !uuid.test(q.topic_id)) return "question: bad id";
    if (typeof q.question_text !== "string" || !q.question_text.trim() || q.question_text.length > 20000) return "question: bad text";
    if (typeof q.question_type !== "string") return "question: bad type";
    if (!Array.isArray(q.choices) || q.choices.length < 2 || q.choices.length > 8) return "question: choice count";
    for (const ch of q.choices) {
      if (typeof ch.id !== "string" || !uuid.test(ch.id) || typeof ch.choice_text !== "string" || ch.choice_text.length > 5000 || !Number.isInteger(ch.sort_order)) return "choice: bad";
    }
  }
  return null;
}

export type EdgeCache = {
  match(url: string): Promise<Response | undefined>;
  put(url: string, res: Response): Promise<void>;
  delete(url: string): Promise<void>;
};

export type Deps = {
  db: Db;
  env: Env;
  verifyToken: (token: string) => Promise<AuthUser | null>;
  /** Optional shared edge cache (Cloudflare Cache API). Absent in tests. */
  cache?: EdgeCache;
};

/** Constant-time string comparison, so the key can't be guessed from response timing. */
function timingSafeEqual(a: string, b: string): boolean {
  const ea = new TextEncoder().encode(a), eb = new TextEncoder().encode(b);
  let diff = ea.length ^ eb.length;
  for (let i = 0; i < Math.max(ea.length, eb.length); i++) diff |= (ea[i] ?? 0) ^ (eb[i] ?? 0);
  return diff === 0;
}

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export const MAX_IDS = 50;

// Browsers may keep a response briefly; the shared edge copy lives longer.
const BROWSER_CACHE = "private, max-age=300";
const EDGE_CACHE = "public, s-maxage=3600";

export function createApp(deps: Deps) {
  const { db, env } = deps;
  const app = new Hono();

  // Browser calls from the web app. Same-origin or listed origins only.
  const allowed = new Set((env.ALLOWED_ORIGINS ?? "").split(",").map((s) => s.trim()).filter(Boolean));
  app.use("*", async (c, next) => {
    const origin = c.req.header("origin");
    if (origin && allowed.has(origin)) {
      c.header("Access-Control-Allow-Origin", origin);
      c.header("Vary", "Origin");
      c.header("Access-Control-Allow-Headers", "Authorization, Content-Type");
      c.header("Access-Control-Allow-Methods", "GET, OPTIONS");
    }
    if (c.req.method === "OPTIONS") return c.body(null, 204);
    await next();
  });

  // Per-IP rate limit. Fails OPEN: if the binding is missing or errors, requests still work.
  app.use("/v1/*", async (c, next) => {
    try {
      const ip = c.req.header("cf-connecting-ip") ?? "unknown";
      const r = await env.RATE_LIMITER?.limit({ key: ip });
      if (r && !r.success) return c.json({ error: "rate_limited" }, 429);
    } catch {
      // fail open
    }
    await next();
  });

  app.get("/health", (c) => c.json({ ok: true }));

  // Every /v1 route needs either a valid Supabase access token (students keep their accounts) or the
  // server-to-server key the Next.js app sends (the app has already verified the student by then).
  app.use("/v1/*", async (c, next) => {
    const internal = c.req.header("x-internal-key");
    if (internal && env.INTERNAL_KEY && timingSafeEqual(internal, env.INTERNAL_KEY)) return next();
    const h = c.req.header("authorization") ?? "";
    const token = /^Bearer (.+)$/i.exec(h)?.[1];
    if (!token) return c.json({ error: "unauthorized" }, 401);
    const user = await deps.verifyToken(token);
    if (!user) return c.json({ error: "unauthorized" }, 401);
    c.set("user" as never, user as never);
    await next();
  });

  /** Serves from the shared edge cache when possible; otherwise computes once and stores it. */
  async function cached(url: string, compute: () => Promise<unknown>): Promise<Response> {
    const hit = await deps.cache?.match(url);
    if (hit) return hit;
    const body = JSON.stringify(await compute());
    const res = new Response(body, { headers: { "Content-Type": "application/json", "Cache-Control": BROWSER_CACHE } });
    if (deps.cache) {
      await deps.cache.put(url, new Response(body, { headers: { "Content-Type": "application/json", "Cache-Control": EDGE_CACHE } }));
    }
    return res;
  }

  app.get("/v1/taxonomy", (c) =>
    cached(c.req.url, async () => {
      const [examAreas, subjects, topics, subtopics] = await Promise.all([
        db.query(SQL.examAreas),
        db.query(SQL.subjects),
        db.query(SQL.topics),
        db.query(SQL.subtopics),
      ]);
      return { examAreas, subjects, topics, subtopics };
    }),
  );

  // Same shape as the app's published snapshot: every published id (sorted) plus counts.
  app.get("/v1/snapshot", (c) =>
    cached(c.req.url, async () => {
      const rows = await db.query(SQL.snapshot);
      const byTopic: Record<string, number> = {};
      const bySubtopic: Record<string, number> = {};
      const byMockArea: Record<string, number> = { area_1: 0, area_2: 0, area_3: 0 };
      for (const q of rows) {
        const topic = String(q.topic_id);
        byTopic[topic] = (byTopic[topic] ?? 0) + 1;
        if (q.subtopic_id) bySubtopic[String(q.subtopic_id)] = (bySubtopic[String(q.subtopic_id)] ?? 0) + 1;
        const extra = JSON.parse(String(q.additional_mock_areas ?? "[]")) as string[];
        for (const a of new Set([String(q.topic_mock_area), ...extra])) if (a in byMockArea) byMockArea[a]++;
      }
      return { ids: rows.map((r) => String(r.id)), byTopic, bySubtopic, byMockArea };
    }),
  );

  // Questions + choices for specific ids. No correct answers and no explanations, ever.
  app.get("/v1/questions", async (c) => {
    const ids = [...new Set((c.req.query("ids") ?? "").split(",").map((s) => s.trim()).filter(Boolean))];
    if (ids.length === 0 || ids.length > MAX_IDS || ids.some((id) => !UUID.test(id))) {
      return c.json({ error: "bad_ids", max: MAX_IDS }, 400);
    }
    // Not edge-cached: it is only ~50 cheap indexed rows, and an edit made in the admin must show at once.
    const [questions, choices] = await Promise.all([
      db.query(SQL.questionsByIds(ids.length), ids),
      db.query(SQL.choicesByQuestionIds(ids.length), ids),
    ]);
    const byQ = new Map<string, unknown[]>();
    for (const ch of choices) {
      const list = byQ.get(String(ch.question_id)) ?? [];
      list.push({ id: ch.id, choice_text: ch.choice_text, sort_order: ch.sort_order });
      byQ.set(String(ch.question_id), list);
    }
    const body = questions.map((q) => ({ ...q, is_paes: Boolean(q.is_paes), choices: byQ.get(String(q.id)) ?? [] }));
    return c.json(body, 200, { "Cache-Control": "private, no-store" });
  });

  // Keeps this copy in step with the admin: the Next.js server pushes the questions an admin just changed.
  // Server-to-server key ONLY. A student's login token is never enough to write here.
  app.post("/v1/admin/sync", async (c) => {
    const internal = c.req.header("x-internal-key");
    if (!internal || !env.INTERNAL_KEY || !timingSafeEqual(internal, env.INTERNAL_KEY)) return c.json({ error: "forbidden" }, 403);

    let body: { upsert?: SyncQuestion[]; remove?: string[] };
    try {
      body = await c.req.json();
    } catch {
      return c.json({ error: "bad_json" }, 400);
    }
    const upsert = body.upsert ?? [];
    const remove = body.remove ?? [];
    if (!Array.isArray(upsert) || !Array.isArray(remove) || upsert.length > MAX_SYNC || remove.length > MAX_SYNC) {
      return c.json({ error: "too_many", max: MAX_SYNC }, 400);
    }
    const problem = validateSync(upsert, remove);
    if (problem) return c.json({ error: "invalid", detail: problem }, 400);

    const stmts: Stmt[] = [];
    for (const q of upsert) {
      stmts.push({
        sql:
          "INSERT OR REPLACE INTO questions (id, topic_id, subtopic_id, question_text, question_type, difficulty, category, " +
          "series_key, series_position, is_paes, paes_reference, topic_mock_area, additional_mock_areas) " +
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        args: [
          q.id, q.topic_id, q.subtopic_id ?? null, q.question_text, q.question_type, q.difficulty ?? null, q.category ?? null,
          q.series_key ?? null, q.series_position ?? null, q.is_paes ? 1 : 0, q.paes_reference ?? null,
          q.topic_mock_area ?? null, JSON.stringify(q.additional_mock_areas ?? []),
        ],
      });
      stmts.push({ sql: "DELETE FROM choices WHERE question_id = ?", args: [q.id] });
      for (const ch of q.choices) {
        stmts.push({
          sql: "INSERT INTO choices (id, question_id, choice_text, sort_order) VALUES (?,?,?,?)",
          args: [ch.id, q.id, ch.choice_text, ch.sort_order],
        });
      }
    }
    for (const id of remove) {
      stmts.push({ sql: "DELETE FROM choices WHERE question_id = ?", args: [id] });
      stmts.push({ sql: "DELETE FROM questions WHERE id = ?", args: [id] });
    }
    if (stmts.length) await db.batch(stmts);

    // The id list and counts change when questions are added or removed: drop their shared cached copies.
    const origin = new URL(c.req.url).origin;
    await Promise.all([deps.cache?.delete(`${origin}/v1/snapshot`), deps.cache?.delete(`${origin}/v1/taxonomy`)]).catch(() => {});
    return c.json({ ok: true, upserted: upsert.length, removed: remove.length });
  });

  return app;
}
