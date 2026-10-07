// @vitest-environment node
import { describe, expect, it, vi } from "vitest";

// the reviewers browser transitively imports server-only modules; stub the guard for SSR rendering
vi.mock("server-only", () => ({}));
vi.mock("@/lib/supabase/server", () => ({ createClient: async () => ({}) }));
import { renderToString } from "react-dom/server";
import type { MidtermRow } from "./midterm-data";
import { MidtermReviewer } from "./midterm-reviewer";
import { MidtermExam } from "./exam/midterm-exam";

const g = (t: number, item: number) =>
  `MIDTERM|${String(t).padStart(4, "0")}|${String(item).padStart(3, "0")}|Section ${t}|Topic ${t}`;
const rows: MidtermRow[] = [1, 2].flatMap((t) => [
  {
    id: `a${t}`,
    kind: "table" as const,
    title: `Admin Reviewer: Topic ${t} - Terms and Definitions`,
    notes: g(t, 0),
    formula: null,
    variables: null,
    description: null,
    table_content:
      "Term A | Meaning A\nTerm B | Meaning B\nTerm C | Meaning C\nTerm D | Meaning D",
  },
  {
    id: `b${t}`,
    kind: "formula" as const,
    title: `Admin Reviewer: Formula ${t}`,
    notes: g(t, 1),
    formula: "V_T = I x R^2",
    variables: "V_T = voltage, I = current",
    description: "note",
    table_content: "Sample problem: Find V.\nGiven: I = 2\nAnswer: 8 V",
  },
  {
    id: `c${t}`,
    kind: "table" as const,
    title: `Admin Reviewer: Topic ${t} - Key Concepts and Explanations`,
    notes: g(t, 2),
    formula: null,
    variables: null,
    description: null,
    table_content: "A key concept.\nAnother concept.",
  },
]);

describe("midterm reviewer pages render", () => {
  it("reviewer lists collapsible major topics", () => {
    const html = renderToString(<MidtermReviewer rows={rows} />);
    expect(html).toContain("Section 1");
    expect(html).toContain("Expand all");
    expect(html).toContain("Collapse all");
  });

  it("exam setup shows topic, type, count and time controls", () => {
    const html = renderToString(<MidtermExam rows={rows} />);
    expect(html).toContain("Custom Midterm Exam");
    expect(html).toContain("Start exam");
    expect(html).toContain("Time limit");
  });
});
