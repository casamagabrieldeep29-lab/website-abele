import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

// The module is server-only and uses Next's after(); both are stubbed so it can run under vitest.
vi.mock("server-only", () => ({}));
vi.mock("next/server", () => ({ after: (fn: () => unknown) => void fn() }));

const rows: unknown[] = [];
let queryError: { message: string } | null = null;
vi.mock("@/lib/supabase/admin", () => ({
  createAdminClient: () => ({
    from: () => ({
      select: () => ({ in: async () => ({ data: rows, error: queryError }) }),
    }),
  }),
}));

import { syncQuestionsToWorker } from "./worker-sync";

const A = "11111111-1111-4111-8111-111111111111"; // published
const B = "22222222-2222-4222-8222-222222222222"; // draft now
const C = "33333333-3333-4333-8333-333333333333"; // deleted
const T = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";

const q = (id: string, status: string, extra: Record<string, unknown> = {}) => ({
  id, topic_id: T, subtopic_id: null, question_text: `text ${id.slice(0, 4)}`, question_type: "single_choice",
  difficulty: "easy", category: "term", series_key: null, series_position: null, is_paes: false, paes_reference: null,
  additional_mock_areas: ["area_2"], status, topics: { mock_area: "area_1" },
  choices: [3, 1, 0, 2].map((n) => ({ id: `c${n}`, choice_text: `opt ${n}`, sort_order: n })),
  ...extra,
});

let sent: { url: string; body: { upsert: Record<string, unknown>[]; remove: string[] }; key: string | null }[] = [];

beforeEach(() => {
  rows.length = 0;
  queryError = null;
  sent = [];
  process.env.CONTENT_API_KEY = "test-key";
  vi.stubGlobal("fetch", async (url: string, init: { body: string; headers: Record<string, string> }) => {
    sent.push({ url, body: JSON.parse(init.body), key: init.headers["x-internal-key"] });
    return new Response("{}", { status: 200 });
  });
});
afterEach(() => {
  vi.unstubAllGlobals();
  vi.restoreAllMocks();
});

describe("syncQuestionsToWorker", () => {
  it("upserts published questions (choices in order, mock area attached) and removes everything else", async () => {
    rows.push(q(A, "published", { topics: [{ mock_area: "area_3" }] }), q(B, "draft"));
    await syncQuestionsToWorker([A, B, C]);
    expect(sent).toHaveLength(1);
    expect(sent[0].key).toBe("test-key");
    const { upsert, remove } = sent[0].body;
    expect(upsert.map((u) => u.id)).toEqual([A]);
    expect(upsert[0].topic_mock_area).toBe("area_3"); // embedded relation returned as an array
    expect((upsert[0].choices as { sort_order: number }[]).map((c) => c.sort_order)).toEqual([0, 1, 2, 3]);
    expect(remove.sort()).toEqual([B, C].sort()); // draft and deleted both leave the copy
  });

  it("never sends a correct-answer flag or an explanation", async () => {
    rows.push(q(A, "published", { explanation: "secret", choices: [{ id: "c0", choice_text: "x", sort_order: 0, is_correct: true }, { id: "c1", choice_text: "y", sort_order: 1, is_correct: false }] }));
    await syncQuestionsToWorker([A]);
    expect(JSON.stringify(sent[0].body)).not.toMatch(/is_correct|explanation|secret/);
  });

  it("is a no-op without a key or ids", async () => {
    delete process.env.CONTENT_API_KEY;
    await syncQuestionsToWorker([A]);
    process.env.CONTENT_API_KEY = "test-key";
    await syncQuestionsToWorker([]);
    expect(sent).toHaveLength(0);
  });

  it("works in chunks of 100 ids", async () => {
    const ids = Array.from({ length: 250 }, (_, i) => `00000000-0000-4000-8000-${String(i).padStart(12, "0")}`);
    await syncQuestionsToWorker(ids);
    expect(sent.map((s) => s.body.remove.length)).toEqual([100, 100, 50]);
  });

  it("never throws when the database or the Worker fails", async () => {
    queryError = { message: "db down" };
    const log = vi.spyOn(console, "error").mockImplementation(() => {});
    await expect(syncQuestionsToWorker([A])).resolves.toBeUndefined();
    queryError = null;
    rows.push(q(A, "published"));
    vi.stubGlobal("fetch", async () => new Response("no", { status: 500 }));
    await expect(syncQuestionsToWorker([A])).resolves.toBeUndefined();
    expect(log).toHaveBeenCalledTimes(2);
  });
});
