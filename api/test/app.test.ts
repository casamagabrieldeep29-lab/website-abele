import { createClient, type Client } from "@libsql/client";
import { beforeAll, describe, expect, it } from "vitest";
import { createApp, MAX_IDS } from "../src/app";
import { makeDb, type DbStats } from "../src/db";
import { applyMigrations } from "../src/migrate";
import { SQL } from "../src/sql";
import type { Env } from "../src/types";

const Q1 = "11111111-1111-4111-8111-111111111111";
const Q2 = "22222222-2222-4222-8222-222222222222";
const T1 = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";

let client: Client;
beforeAll(async () => {
  client = createClient({ url: ":memory:" });
  await applyMigrations(client);
  await client.batch(
    [
      "INSERT INTO exam_areas (id, name, sort_order) VALUES ('ea1', 'Area 1', 1)",
      `INSERT INTO topics (id, name, mock_area, exam_area_id) VALUES ('${T1}', 'Pumps', 'area_1', 'ea1')`,
      `INSERT INTO questions (id, topic_id, question_text, question_type, difficulty, topic_mock_area, additional_mock_areas) VALUES ('${Q1}', '${T1}', 'What is NPSH?', 'single_choice', 'easy', 'area_1', '["area_2"]')`,
      `INSERT INTO questions (id, topic_id, question_text, question_type, difficulty, topic_mock_area) VALUES ('${Q2}', '${T1}', 'Pump power?', 'single_choice', 'hard', 'area_1')`,
      ...[0, 1, 2, 3].map((i) => `INSERT INTO choices (id, question_id, choice_text, sort_order) VALUES ('c1${i}', '${Q1}', 'option ${i}', ${i})`),
      ...[0, 1, 2, 3].map((i) => `INSERT INTO choices (id, question_id, choice_text, sort_order) VALUES ('c2${i}', '${Q2}', 'choice ${i}', ${i})`),
    ],
    "write",
  );
});

function appFor(stats?: DbStats) {
  const env: Env = { ALLOWED_ORIGINS: "https://www.abelieverofficial.com" };
  return createApp({ db: makeDb(() => client, stats), env, verifyToken: async (t) => (t === "good" ? { id: "u1", email: null } : null) });
}
const authed = { headers: { authorization: "Bearer good" } };
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const j = async (res: Response) => (await res.json()) as any;

describe("auth", () => {
  it("/health needs no token", async () => {
    expect((await appFor().request("/health")).status).toBe(200);
  });
  it("rejects missing and bad tokens on every /v1 route", async () => {
    for (const path of ["/v1/taxonomy", "/v1/snapshot", `/v1/questions?ids=${Q1}`]) {
      expect((await appFor().request(path)).status).toBe(401);
      expect((await appFor().request(path, { headers: { authorization: "Bearer nope" } })).status).toBe(401);
    }
  });
});

describe("server-to-server key", () => {
  const withKey = () => createApp({ db: makeDb(() => client), env: { INTERNAL_KEY: "s3cret-key" }, verifyToken: async () => null });
  it("lets the app in with the right key, and nothing else", async () => {
    expect((await withKey().request("/v1/taxonomy", { headers: { "x-internal-key": "s3cret-key" } })).status).toBe(200);
    expect((await withKey().request("/v1/taxonomy", { headers: { "x-internal-key": "wrong" } })).status).toBe(401);
    expect((await withKey().request("/v1/taxonomy", { headers: { "x-internal-key": "" } })).status).toBe(401);
    expect((await withKey().request("/v1/taxonomy")).status).toBe(401);
  });
  it("is off when no key is configured, even if a header is sent", async () => {
    const noKey = createApp({ db: makeDb(() => client), env: {}, verifyToken: async () => null });
    expect((await noKey.request("/v1/taxonomy", { headers: { "x-internal-key": "anything" } })).status).toBe(401);
  });
});

describe("content", () => {
  it("returns the taxonomy", async () => {
    const body = await j(await appFor().request("/v1/taxonomy", authed));
    expect(body.topics).toHaveLength(1);
    expect(body.examAreas[0].name).toBe("Area 1");
  });

  it("snapshot counts match the published questions", async () => {
    const body = await j(await appFor().request("/v1/snapshot", authed));
    expect(body.ids).toEqual([Q1, Q2].sort());
    expect(body.byTopic[T1]).toBe(2);
    expect(body.byMockArea).toEqual({ area_1: 2, area_2: 1, area_3: 0 });
  });

  it("returns questions with 4 choices and NEVER an answer or explanation", async () => {
    const res = await appFor().request(`/v1/questions?ids=${Q2},${Q1}`, authed);
    const body = await j(res);
    expect(body).toHaveLength(2);
    for (const q of body) {
      expect(q.choices).toHaveLength(4);
      expect(Object.keys(q)).not.toContain("explanation");
      for (const c of q.choices) expect(Object.keys(c).sort()).toEqual(["choice_text", "id", "sort_order"]);
    }
    expect(JSON.stringify(body)).not.toMatch(/is_correct/);
  });

  it("rejects bad id lists", async () => {
    const app = appFor();
    expect((await app.request("/v1/questions", authed)).status).toBe(400);
    expect((await app.request("/v1/questions?ids=not-a-uuid", authed)).status).toBe(400);
    const many = Array.from({ length: MAX_IDS + 1 }, (_, i) => `00000000-0000-4000-8000-${String(i).padStart(12, "0")}`).join(",");
    expect((await app.request(`/v1/questions?ids=${many}`, authed)).status).toBe(400);
  });
});

describe("budget: database statements per request", () => {
  it("each route stays within its budget", async () => {
    const budgets: [string, number][] = [["/v1/taxonomy", 4], ["/v1/snapshot", 1], [`/v1/questions?ids=${Q1},${Q2}`, 2]];
    for (const [path, max] of budgets) {
      const stats: DbStats = { statements: 0, rowsReturned: 0 };
      await appFor(stats).request(path, authed);
      expect(stats.statements, path).toBeLessThanOrEqual(max);
    }
  });
});

describe("plan: no query scans a whole table (except the cached snapshot)", () => {
  const plan = async (sql: string, args: string[]) =>
    (await client.execute({ sql: `EXPLAIN QUERY PLAN ${sql}`, args })).rows.map((r) => String(r.detail)).join(" | ");
  it("question and choice lookups use their indexes", async () => {
    expect(await plan(SQL.questionsByIds(2), [Q1, Q2])).not.toMatch(/SCAN questions/);
    expect(await plan(SQL.choicesByQuestionIds(2), [Q1, Q2])).toMatch(/choices_question_idx/);
    expect(await plan(SQL.choicesByQuestionIds(2), [Q1, Q2])).not.toMatch(/SCAN choices/);
  });
});

describe("sync (admin edits pushed to the Worker)", () => {
  const KEY = "sync-key";
  const app = () => createApp({ db: makeDb(() => client), env: { INTERNAL_KEY: KEY }, verifyToken: async (t) => (t === "good" ? { id: "u1", email: null } : null) });
  const Q3 = "33333333-3333-4333-8333-333333333333";
  const C = (n: number) => `c3c3c3c3-0000-4000-8000-00000000000${n}`;
  const q3 = (text: string, choices = 4) => ({
    id: Q3, topic_id: T1, question_text: text, question_type: "single_choice", difficulty: "easy", topic_mock_area: "area_1",
    choices: Array.from({ length: choices }, (_, i) => ({ id: C(i), choice_text: `${text} option ${i}`, sort_order: i })),
  });
  const post = (body: unknown, headers: Record<string, string> = { "x-internal-key": KEY }) =>
    app().request("/v1/admin/sync", { method: "POST", headers: { "content-type": "application/json", ...headers }, body: JSON.stringify(body) });
  const read = async () => j(await app().request(`/v1/questions?ids=${Q3}`, { headers: { "x-internal-key": KEY } }));

  it("never lets a student's login write", async () => {
    expect((await post({ upsert: [q3("x")] }, { authorization: "Bearer good" })).status).toBe(403);
    expect((await post({ upsert: [q3("x")] }, {})).status).toBe(401);
    expect(await read()).toEqual([]);
  });

  it("rejects malformed bodies", async () => {
    expect((await post({ upsert: [{ ...q3("x"), id: "nope" }] })).status).toBe(400);
    expect((await post({ upsert: [q3("x", 1)] })).status).toBe(400);
    expect((await post({ upsert: [{ ...q3("  ") }] })).status).toBe(400);
    expect((await post({ remove: Array.from({ length: 101 }, () => Q3) })).status).toBe(400);
  });

  it("adds, edits (choices replaced) and removes a question", async () => {
    expect((await post({ upsert: [q3("first text")] })).status).toBe(200);
    let rows = await read();
    expect(rows).toHaveLength(1);
    expect(rows[0].question_text).toBe("first text");
    expect(rows[0].choices).toHaveLength(4);

    // an edit with only 3 choices must replace the old 4, not add to them
    expect((await post({ upsert: [q3("edited text", 3)] })).status).toBe(200);
    rows = await read();
    expect(rows[0].question_text).toBe("edited text");
    expect(rows[0].choices).toHaveLength(3);
    expect(JSON.stringify(rows)).not.toMatch(/is_correct|explanation/);

    expect((await post({ remove: [Q3] })).status).toBe(200);
    expect(await read()).toEqual([]);
    const left = await client.execute({ sql: "SELECT COUNT(*) AS c FROM choices WHERE question_id = ?", args: [Q3] });
    expect(Number(left.rows[0].c)).toBe(0);
  });
});
