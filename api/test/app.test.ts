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
