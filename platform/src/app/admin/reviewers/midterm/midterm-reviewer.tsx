"use client";

import { useMemo, useState } from "react";
import { Input } from "@/components/ui/input";
import { renderFormula } from "@/app/(app)/reviewers/reviewers-browser";

export type MidtermRow = {
  id: string;
  kind: "formula" | "table" | "constant";
  title: string;
  formula: string | null;
  variables: string | null;
  table_content: string | null;
  description: string | null;
  notes: string | null;
};

// Rows carry their place in the reviewer in `notes`:
// MIDTERM|<topic order>|<item order>|<section>|<topic title>
type Parsed = { row: MidtermRow; item: number; section: string; topic: string; topicOrder: number };
type TopicGroup = { key: string; topic: string; order: number; rows: Parsed[] };
type SectionGroup = { section: string; topics: TopicGroup[] };

function parse(row: MidtermRow): Parsed | null {
  const parts = row.notes?.split("|");
  if (!parts || parts[0] !== "MIDTERM" || parts.length < 5) return null;
  return { row, topicOrder: Number(parts[1]), item: Number(parts[2]), section: parts[3], topic: parts.slice(4).join("|") };
}

function group(rows: MidtermRow[]): SectionGroup[] {
  const topics = new Map<number, TopicGroup & { section: string }>();
  for (const r of rows) {
    const p = parse(r);
    if (!p) continue;
    let g = topics.get(p.topicOrder);
    if (!g) {
      g = { key: String(p.topicOrder), topic: p.topic, order: p.topicOrder, rows: [], section: p.section };
      topics.set(p.topicOrder, g);
    }
    g.rows.push(p);
  }
  const sections: SectionGroup[] = [];
  for (const g of [...topics.values()].sort((a, b) => a.order - b.order)) {
    g.rows.sort((a, b) => a.item - b.item);
    const last = sections[sections.length - 1];
    if (last && last.section === g.section) last.topics.push(g);
    else sections.push({ section: g.section, topics: [g] });
  }
  return sections;
}

function lines(text: string | null): string[] {
  return (text ?? "").split("\n").map((l) => l.trim()).filter(Boolean);
}

const LABEL = "text-[11px] font-semibold uppercase tracking-wide";

function TermsTable({ text }: { text: string | null }) {
  const rows = lines(text).map((l) => {
    const i = l.indexOf(" | ");
    return i < 0 ? [l, ""] : [l.slice(0, i), l.slice(i + 3)];
  });
  return (
    <div>
      <p className={`${LABEL} text-primary/70`}>Terms and definitions</p>
      <dl className="mt-1.5 divide-y divide-border/60 rounded-md border border-border">
        {rows.map(([term, def], i) => (
          <div key={i} className="grid gap-x-3 px-3 py-1.5 text-sm sm:grid-cols-[minmax(8rem,14rem)_1fr]">
            <dt className="font-medium text-foreground">{renderFormula(term)}</dt>
            <dd className="text-muted-foreground">{renderFormula(def)}</dd>
          </div>
        ))}
      </dl>
    </div>
  );
}

function Concepts({ text }: { text: string | null }) {
  return (
    <div>
      <p className={`${LABEL} text-primary/70`}>Key concepts and explanations</p>
      <ul className="mt-1.5 list-disc space-y-1 pl-5 text-sm leading-relaxed text-muted-foreground">
        {lines(text).map((l, i) => (
          <li key={i}>{l}</li>
        ))}
      </ul>
    </div>
  );
}

function VariablesList({ text }: { text: string }) {
  return <p className="mt-1 text-xs leading-relaxed text-muted-foreground">{renderFormula(text)}</p>;
}

function FormulaBlock({ row }: { row: MidtermRow }) {
  const title = row.title.replace(/^Admin Reviewer:\s*/, "");
  const eq = lines(row.formula).flatMap((l) => l.split(/\s{2,}/));
  const sample = lines(row.table_content);
  return (
    <div className="rounded-lg border border-border bg-card p-3.5">
      <p className="text-sm font-semibold text-foreground">{title}</p>
      <div className="mt-2 space-y-1 rounded-md bg-primary/5 px-3 py-2">
        {eq.map((l, i) => (
          <p key={i} className="font-mono text-[15px] leading-relaxed font-medium text-foreground">
            {renderFormula(l)}
          </p>
        ))}
      </div>
      {row.variables && (
        <div className="mt-2">
          <p className={`${LABEL} text-muted-foreground`}>Where</p>
          <VariablesList text={row.variables} />
        </div>
      )}
      {row.description && <p className="mt-2 text-xs italic leading-relaxed text-muted-foreground">{row.description}</p>}
      {sample.length > 0 && (
        <div className="mt-2.5 rounded-md border border-border bg-muted/40 px-3 py-2 text-xs leading-relaxed">
          {sample.map((l, i) => (
            <p key={i} className={i === 0 ? "font-semibold text-foreground" : l.startsWith("Answer:") ? "mt-0.5 font-semibold text-success" : "text-muted-foreground"}>
              {l}
            </p>
          ))}
        </div>
      )}
    </div>
  );
}

export function MidtermReviewer({ rows }: { rows: MidtermRow[] }) {
  const [search, setSearch] = useState("");
  const sections = useMemo(() => group(rows), [rows]);
  const q = search.trim().toLowerCase();

  const visible = useMemo(() => {
    if (!q) return sections;
    return sections
      .map((s) => ({
        ...s,
        topics: s.topics.filter(
          (t) =>
            t.topic.toLowerCase().includes(q) ||
            t.rows.some((p) => [p.row.title, p.row.formula, p.row.variables, p.row.description, p.row.table_content].some((f) => f?.toLowerCase().includes(q))),
        ),
      }))
      .filter((s) => s.topics.length > 0);
  }, [sections, q]);

  const topicCount = sections.reduce((n, s) => n + s.topics.length, 0);

  if (rows.length === 0) return <p className="mt-6 text-sm text-muted-foreground">No midterm reviewer entries yet.</p>;

  return (
    <div className="mt-6 space-y-6">
      <div className="flex flex-wrap items-center gap-3">
        <Input value={search} onChange={(e) => setSearch(e.target.value)} placeholder="Search terms, formulas, topics…" className="max-w-md" />
        <p className="text-xs text-muted-foreground">
          {sections.length} sections · {topicCount} topics · {rows.length} entries · visible to admins only
        </p>
      </div>

      {visible.map((s) => (
        <section key={s.section}>
          <h2 className="border-b-2 border-primary/30 pb-1 text-lg font-bold text-primary">{s.section}</h2>
          <div className="mt-3 space-y-2">
            {s.topics.map((t) => {
              const terms = t.rows.find((p) => p.row.kind === "table" && p.row.title.endsWith("Terms and Definitions"));
              const concepts = t.rows.find((p) => p.row.kind === "table" && p.row.title.endsWith("Key Concepts and Explanations"));
              const formulas = t.rows.filter((p) => p.row.kind === "formula");
              return (
                <details key={t.key} open={Boolean(q)} className="group rounded-lg border border-border bg-background">
                  <summary className="cursor-pointer select-none rounded-lg bg-muted/40 px-3 py-2 text-sm font-semibold text-foreground">
                    {t.topic}
                    <span className="ml-2 text-xs font-normal text-muted-foreground">
                      {terms ? `${lines(terms.row.table_content).length} terms` : ""}
                      {formulas.length ? ` · ${formulas.length} formula${formulas.length === 1 ? "" : "s"}` : ""}
                    </span>
                  </summary>
                  <div className="space-y-4 p-3">
                    {terms && <TermsTable text={terms.row.table_content} />}
                    {formulas.length > 0 && (
                      <div>
                        <p className={`${LABEL} text-primary/70`}>Formulas</p>
                        <div className="mt-1.5 space-y-2.5">
                          {formulas.map((p) => (
                            <FormulaBlock key={p.row.id} row={p.row} />
                          ))}
                        </div>
                      </div>
                    )}
                    {concepts && <Concepts text={concepts.row.table_content} />}
                  </div>
                </details>
              );
            })}
          </div>
        </section>
      ))}
    </div>
  );
}
