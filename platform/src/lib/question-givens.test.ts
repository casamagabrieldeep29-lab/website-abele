import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { questionMissingGivens } from "./question-givens";

describe("questionMissingGivens", () => {
  it("flags a problem whose numbers live only in the solution", () => {
    expect(
      questionMissingGivens(
        "A rural farm-to-market road project has the cost and benefit streams shown. Compute the benefit-cost ratio.",
        "Given: Cost Year0=800,000, Year1=200,000; r=10%. PV of costs = 981,818.18",
      ),
    ).toBe(true);
  });

  it("accepts a problem that states its givens", () => {
    expect(
      questionMissingGivens(
        "A pump delivers 0.025 m³/s against a head of 10 m at 70% efficiency. Determine the power.",
        "Given: Q = 0.025 m³/s; H = 10 m; e = 0.70. P = ...",
      ),
    ).toBe(false);
  });

  it("ignores concept questions with no Given clause", () => {
    expect(questionMissingGivens("What is the power factor of a purely inductive circuit?", "cos(90°) = 0.")).toBe(false);
  });
});

/**
 * Guard for every seed file that ships questions: no question may open its
 * explanation with "Given:" while its text states no data. Fix the question
 * text (put the values in the problem), do not loosen this test.
 */
describe("seed files state their givens", () => {
  const dir = join(__dirname, "../../supabase/seed/content");
  const insert =
    /VALUES \(\s*v_topic_id,\s*[^,]+,\s*'((?:[^']|'')*)',\s*'\w+',\s*'\w+',\s*'((?:[^']|'')*)'/g;

  for (const file of readdirSync(dir).filter((f) => f.endsWith(".sql"))) {
    it(file, () => {
      const sql = readFileSync(join(dir, file), "utf8");
      const bad: string[] = [];
      for (const m of sql.matchAll(insert)) {
        const text = m[1].replace(/''/g, "'");
        const explanation = m[2].replace(/''/g, "'");
        if (questionMissingGivens(text, explanation)) bad.push(text.slice(0, 90));
      }
      expect(bad).toEqual([]);
    });
  }
});
