import { describe, expect, it } from "vitest";
import { readdirSync, readFileSync, statSync } from "node:fs";
import { join, relative } from "node:path";

/**
 * Supabase Free allows 5 GB of egress per month. In Oct 2026 the project hit
 * that cap and went down for every student because several pages re-downloaded
 * whole tables (the question list, ~1.3 MB of reviewer text, each student's
 * entire answer history) on every page view. These checks fail CI if that
 * pattern comes back. If one trips, read the message — the fix is almost always
 * to use a shared cache in src/lib (published-counts.ts / shared-content.ts) or
 * a small SQL aggregate, NOT to loosen the test.
 */

const SRC = join(__dirname, "..");

function walk(dir: string, out: string[] = []): string[] {
  for (const name of readdirSync(dir)) {
    const full = join(dir, name);
    if (statSync(full).isDirectory()) walk(full, out);
    else if (/\.(ts|tsx)$/.test(name) && !/\.test\./.test(name)) out.push(full);
  }
  return out;
}

const appFiles = walk(join(SRC, "app")).filter((f) => !relative(SRC, f).replace(/\\/g, "/").startsWith("app/admin/"));

describe("egress guard", () => {
  it("student-facing code never pages through whole tables", () => {
    const offenders = appFiles
      .filter((f) => /\bfetchAllRows\b|\bfetchAllAnsweredRows\b/.test(readFileSync(f, "utf8")))
      .map((f) => relative(SRC, f));
    expect(
      offenders,
      "Student pages/actions must not call fetchAllRows/fetchAllAnsweredRows (full-table downloads on every request). Use getPublishedSnapshot/getCandidatePool/getPublishedReviewerEntries/getTaxonomy or a SQL aggregate.",
    ).toEqual([]);
  });

  it("student_questions and reviewer_entries are never read unfiltered", () => {
    const offenders: string[] = [];
    for (const f of appFiles) {
      const text = readFileSync(f, "utf8");
      for (const table of ["student_questions", "reviewer_entries", "questions"]) {
        const re = new RegExp(`\\.from\\("${table}"\\)`, "g");
        let m: RegExpExecArray | null;
        while ((m = re.exec(text))) {
          const window = text.slice(m.index, m.index + 600);
          const statement = window.split(/;\s*\n/)[0];
          const bounded = /\.(eq|in|limit|single|maybeSingle|contains|match)\(|head:\s*true|\.insert\(|\.update\(|\.delete\(/.test(
            statement,
          );
          if (!bounded) offenders.push(`${relative(SRC, f)} -> from("${table}")`);
        }
      }
    }
    expect(
      offenders,
      "Reading a whole content table per request downloads megabytes. Filter it (.eq/.in/.limit/head count) or use the shared caches in src/lib.",
    ).toEqual([]);
  });

  it("the dashboard never downloads the mistake list just to count it", () => {
    const dashboard = readFileSync(join(SRC, "app/(app)/dashboard/page.tsx"), "utf8");
    expect(dashboard).not.toMatch(/rpc\("get_mistake_bank"\)/);
  });
});
