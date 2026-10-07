import { describe, expect, it } from "vitest";
import type { MidtermRow } from "../midterm-data";
import {
  availableCounts,
  buildExam,
  numericDistractors,
  parseNumericAnswer,
} from "./exam-generator";

function row(
  id: string,
  kind: MidtermRow["kind"],
  title: string,
  notes: string,
  extra: Partial<MidtermRow> = {},
): MidtermRow {
  return {
    id,
    kind,
    title,
    notes,
    formula: null,
    variables: null,
    table_content: null,
    description: null,
    ...extra,
  };
}

const rows: MidtermRow[] = [];
for (let t = 1; t <= 3; t++) {
  const g = (item: number) =>
    `MIDTERM|${String(t).padStart(4, "0")}|${String(item).padStart(3, "0")}|Section ${t <= 2 ? "A" : "B"}|Topic ${t}`;
  rows.push(
    row(
      `terms${t}`,
      "table",
      `Admin Reviewer: Topic ${t} - Terms and Definitions`,
      g(0),
      {
        table_content: [1, 2, 3, 4]
          .map(
            (i) => `Term ${t}.${i} | Definition number ${t}.${i} of the term`,
          )
          .join("\n"),
      },
    ),
  );
  for (let f = 1; f <= 2; f++) {
    rows.push(
      row(`f${t}${f}`, "formula", `Admin Reviewer: Formula ${t}.${f}`, g(f), {
        formula: `Y${t}${f} = a x b`,
        table_content: `Sample problem: Find Y when a = ${f + 1} and b = 10.\nGiven: a = ${f + 1}; b = 10\nFormula used: Y = a x b = ${(f + 1) * 10}\nAnswer: ${(f + 1) * 10} units`,
      }),
    );
  }
}

describe("numeric distractors", () => {
  it("parses answers with units, decimals and thousands separators", () => {
    expect(parseNumericAnswer("1,327.7 m³")).toMatchObject({
      value: 1327.7,
      decimals: 1,
      commas: true,
      unit: "m³",
    });
    expect(parseNumericAnswer("88.5%")).toMatchObject({
      value: 88.5,
      unit: "%",
    });
    expect(parseNumericAnswer("Satisfactory")).toBeNull();
    expect(parseNumericAnswer("660 W; 6 A")).toBeNull();
    expect(parseNumericAnswer("20,000 m (20 km)")).toBeNull();
  });

  it("returns three distinct wrong answers in the same format", () => {
    const d = numericDistractors("88.5%")!;
    expect(d).toHaveLength(3);
    expect(new Set([...d, "88.5%"]).size).toBe(4);
    d.forEach((x) => expect(x).toMatch(/^\d+\.\d%$/));
  });
});

describe("buildExam", () => {
  const all = new Set(["1", "2", "3"]);

  it("reports what can be generated", () => {
    const c = availableCounts(rows, all);
    expect(c.term).toBe(12);
    expect(c.formula).toBe(6);
    expect(c.solving).toBe(6);
  });

  it("builds the requested number of valid four-choice questions of every selected kind", () => {
    const exam = buildExam(rows, {
      topicKeys: all,
      kinds: ["term", "definition", "formula", "solving"],
      count: 12,
    });
    expect(exam).toHaveLength(12);
    for (const q of exam) {
      expect(q.choices).toHaveLength(4);
      expect(new Set(q.choices).size).toBe(4);
      expect(q.correct).toBeGreaterThanOrEqual(0);
      expect(q.correct).toBeLessThan(4);
    }
    expect(new Set(exam.map((q) => q.kind)).size).toBeGreaterThan(1);
  });

  it("solving questions keep the sample problem text and the right answer among the choices", () => {
    const exam = buildExam(rows, {
      topicKeys: all,
      kinds: ["solving"],
      count: 6,
    });
    expect(exam.length).toBe(6);
    for (const q of exam) {
      expect(q.prompt).toMatch(/^Find Y when a = \d and b = 10\./);
      expect(q.choices[q.correct]).toMatch(/^(20|30) units$/);
    }
  });

  it("only uses the selected topics", () => {
    const exam = buildExam(rows, {
      topicKeys: new Set(["1", "2"]),
      kinds: ["formula"],
      count: 10,
    });
    expect(exam.length).toBeGreaterThan(0);
    expect(
      exam.every((q) => q.topic === "Topic 1" || q.topic === "Topic 2"),
    ).toBe(true);
  });

  it("draws wrong choices from the same topic when it has enough items", () => {
    const exam = buildExam(rows, {
      topicKeys: all,
      kinds: ["term"],
      count: 12,
    });
    expect(exam.length).toBe(12);
    for (const q of exam) {
      const t = q.topic.replace("Topic ", "");
      // every choice is a definition of the same topic ("... number <t>.<i> ...")
      expect(q.choices.every((c) => c.includes(`number ${t}.`))).toBe(true);
    }
  });
});
