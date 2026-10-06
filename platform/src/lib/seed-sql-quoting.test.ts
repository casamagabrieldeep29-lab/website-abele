import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

/**
 * A stray apostrophe inside a question breaks the whole SQL paste ("trailing
 * junk after numeric literal"). Two stray apostrophes in one line cancel out in
 * a simple odd/even count, so this test checks the exact statement shape:
 * inside every quoted string the only allowed quote is a doubled one ('').
 */
const S = String.raw`(?:[^']|'')*`;
const questionLine = new RegExp(
  String.raw`^\s*VALUES \(v_topic_id, (?:NULL|[A-Za-z_]+), '${S}', '\w+', '\w+', '${S}', (?:NULL|'${S}'), (?:NULL|'${S}'), '\w+'(?:, (?:true|false|NULL|'${S}'))*\)\s*$`,
);
const choiceLine = new RegExp(String.raw`^\s*\(v_question_id, '${S}', (?:true|false), \d\)[,;]\s*$`);
const lookupLine = new RegExp(String.raw`question_text = '${S}';\s*$`);

describe("seed SQL quoting", () => {
  const dir = join(__dirname, "../../supabase/seed/content");
  const files = readdirSync(dir).filter((f) => f.endsWith("batch3-import.sql") || f === "math-basic-engg-sciences-import.sql");

  for (const file of files) {
    it(`${file}: every string is escaped`, () => {
      const bad: string[] = [];
      readFileSync(join(dir, file), "utf8")
        .split(/\r?\n/)
        .forEach((line, i) => {
          let re: RegExp | null = null;
          if (/^\s*VALUES \(v_topic_id,/.test(line)) re = questionLine;
          else if (/^\s*\(v_question_id,/.test(line)) re = choiceLine;
          else if (/SELECT id INTO v_question_id FROM public\.questions/.test(line)) re = lookupLine;
          if (re && !re.test(line)) bad.push(`line ${i + 1}: ${line.trim().slice(0, 80)}`);
        });
      expect(bad).toEqual([]);
    });
  }
});
