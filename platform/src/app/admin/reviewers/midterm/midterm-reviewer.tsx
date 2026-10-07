"use client";

import { useMemo, useRef, useState, type ReactNode } from "react";
import { Input } from "@/components/ui/input";
import { renderFormula } from "@/app/(app)/reviewers/reviewers-browser";

import { group, lines, type MidtermRow } from "./midterm-data";

export type { MidtermRow };

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
          <div
            key={i}
            className="grid gap-x-3 px-3 py-1.5 text-sm sm:grid-cols-[minmax(8rem,14rem)_1fr]"
          >
            <dt className="font-medium text-foreground">
              {renderFormula(term)}
            </dt>
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
      <p className={`${LABEL} text-primary/70`}>
        Key concepts and explanations
      </p>
      <ul className="mt-1.5 list-disc space-y-1 pl-5 text-sm leading-relaxed text-muted-foreground">
        {lines(text).map((l, i) => (
          <li key={i}>{l}</li>
        ))}
      </ul>
    </div>
  );
}

function VariablesList({ text }: { text: string }) {
  return (
    <p className="mt-1 text-xs leading-relaxed text-muted-foreground">
      {renderFormula(text)}
    </p>
  );
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
          <p
            key={i}
            className="font-mono text-[15px] leading-relaxed font-medium text-foreground"
          >
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
      {row.description && (
        <p className="mt-2 text-xs italic leading-relaxed text-muted-foreground">
          {row.description}
        </p>
      )}
      {sample.length > 0 && (
        <div className="mt-2.5 rounded-md border border-border bg-muted/40 px-3 py-2 text-xs leading-relaxed">
          {sample.map((l, i) => (
            <p
              key={i}
              className={
                i === 0
                  ? "font-semibold text-foreground"
                  : l.startsWith("Answer:")
                    ? "mt-0.5 font-semibold text-success"
                    : "text-muted-foreground"
              }
            >
              {l}
            </p>
          ))}
        </div>
      )}
    </div>
  );
}

function TopicBlock({
  title,
  meta,
  searching,
  children,
}: {
  title: string;
  meta: string;
  searching: boolean;
  children: ReactNode;
}) {
  // null = follow the default (open while searching, closed otherwise); the
  // reader's own open/close always wins once they have touched the topic.
  const [override, setOverride] = useState<boolean | null>(null);
  const open = override ?? searching;
  const ref = useRef<HTMLDetailsElement>(null);

  return (
    <details
      ref={ref}
      open={open}
      onToggle={(e) => setOverride(e.currentTarget.open)}
      className="group rounded-lg border border-border bg-background"
    >
      <summary className="cursor-pointer select-none rounded-lg bg-muted/40 px-3 py-2 text-sm font-semibold text-foreground">
        {title}
        <span className="ml-2 text-xs font-normal text-muted-foreground">
          {meta}
        </span>
      </summary>
      <div className="space-y-4 p-3">
        {children}
        <div className="flex justify-end border-t border-border/60 pt-3">
          <button
            type="button"
            onClick={() => {
              setOverride(false);
              ref.current?.scrollIntoView({ block: "nearest" });
            }}
            className="rounded-md border border-border bg-muted/40 px-3 py-1.5 text-xs font-medium text-foreground hover:bg-muted"
          >
            Close topic ✕
          </button>
        </div>
      </div>
    </details>
  );
}

export function MidtermReviewer({ rows }: { rows: MidtermRow[] }) {
  const [search, setSearch] = useState("");
  // major topics (sections) start collapsed; searching opens every match
  const [openSections, setOpenSections] = useState<Set<string>>(new Set());
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
            t.rows.some((p) =>
              [
                p.row.title,
                p.row.formula,
                p.row.variables,
                p.row.description,
                p.row.table_content,
              ].some((f) => f?.toLowerCase().includes(q)),
            ),
        ),
      }))
      .filter((s) => s.topics.length > 0);
  }, [sections, q]);

  const topicCount = sections.reduce((n, s) => n + s.topics.length, 0);

  if (rows.length === 0)
    return (
      <p className="mt-6 text-sm text-muted-foreground">
        No midterm reviewer entries yet.
      </p>
    );

  return (
    <div className="mt-6 space-y-6">
      <div className="flex flex-wrap items-center gap-3">
        <Input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search terms, formulas, topics…"
          className="max-w-md"
        />
        <p className="text-xs text-muted-foreground">
          {sections.length} sections · {topicCount} topics · {rows.length}{" "}
          entries · visible to admins only
        </p>
        <div className="flex gap-3 text-xs">
          <button
            type="button"
            className="text-primary hover:underline"
            onClick={() =>
              setOpenSections(new Set(sections.map((s) => s.section)))
            }
          >
            Expand all
          </button>
          <button
            type="button"
            className="text-primary hover:underline"
            onClick={() => setOpenSections(new Set())}
          >
            Collapse all
          </button>
        </div>
      </div>

      {visible.map((s) => {
        const isOpen = Boolean(q) || openSections.has(s.section);
        const toggle = () =>
          setOpenSections((prev) => {
            const next = new Set(prev);
            if (next.has(s.section)) next.delete(s.section);
            else next.add(s.section);
            return next;
          });
        return (
          <section key={s.section}>
            <h2 className="border-b-2 border-primary/30 pb-1 text-lg font-bold text-primary">
              <button
                type="button"
                onClick={toggle}
                aria-expanded={isOpen}
                className="flex w-full items-center gap-2 text-left"
              >
                <span className="inline-block w-4 text-base">
                  {isOpen ? "▾" : "▸"}
                </span>
                <span>{s.section}</span>
                <span className="ml-auto text-xs font-normal text-muted-foreground">
                  {s.topics.length} topics
                </span>
              </button>
            </h2>
            {isOpen && (
              <div className="mt-3 space-y-2">
                {s.topics.map((t) => {
                  const terms = t.rows.find(
                    (p) =>
                      p.row.kind === "table" &&
                      p.row.title.endsWith("Terms and Definitions"),
                  );
                  const concepts = t.rows.find(
                    (p) =>
                      p.row.kind === "table" &&
                      p.row.title.endsWith("Key Concepts and Explanations"),
                  );
                  const formulas = t.rows.filter(
                    (p) => p.row.kind === "formula",
                  );
                  return (
                    <TopicBlock
                      key={t.key}
                      title={t.topic}
                      searching={Boolean(q)}
                      meta={`${terms ? `${lines(terms.row.table_content).length} terms` : ""}${formulas.length ? ` · ${formulas.length} formula${formulas.length === 1 ? "" : "s"}` : ""}`}
                    >
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
                      {concepts && (
                        <Concepts text={concepts.row.table_content} />
                      )}
                    </TopicBlock>
                  );
                })}
                <div className="flex justify-end pt-1">
                  <button
                    type="button"
                    onClick={toggle}
                    className="rounded-md border border-border bg-muted/40 px-3 py-1.5 text-xs font-medium text-foreground hover:bg-muted"
                  >
                    Close {s.section} ✕
                  </button>
                </div>
              </div>
            )}
          </section>
        );
      })}
    </div>
  );
}
