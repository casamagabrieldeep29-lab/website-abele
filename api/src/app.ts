import { Hono } from "hono";
import { SQL } from "./sql";
import type { AuthUser, Db, Env } from "./types";

export type EdgeCache = { match(url: string): Promise<Response | undefined>; put(url: string, res: Response): Promise<void> };

export type Deps = {
  db: Db;
  env: Env;
  verifyToken: (token: string) => Promise<AuthUser | null>;
  /** Optional shared edge cache (Cloudflare Cache API). Absent in tests. */
  cache?: EdgeCache;
};

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

  // Every /v1 route needs a valid Supabase access token (students keep their accounts).
  app.use("/v1/*", async (c, next) => {
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
    ids.sort(); // one cache entry per set, whatever order the caller used
    const url = new URL(c.req.url);
    url.searchParams.set("ids", ids.join(","));
    return cached(url.toString(), async () => {
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
      return questions.map((q) => ({ ...q, is_paes: Boolean(q.is_paes), choices: byQ.get(String(q.id)) ?? [] }));
    });
  });

  return app;
}
