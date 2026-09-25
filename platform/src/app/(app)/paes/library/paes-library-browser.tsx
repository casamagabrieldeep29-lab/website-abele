"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { ArrowRight } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import type { ReviewerEntry } from "../../reviewers/reviewers-browser";
import { FormulaCard, ConstantCard, TableEntryCard } from "../../reviewers/reviewers-browser";
import type { PaesCategory } from "@/lib/paes-categories";
import { PAES_CATEGORY_ORDER } from "@/lib/paes-categories";

export type PaesLibraryEntry = ReviewerEntry & {
  paes_reference: string;
  category: PaesCategory;
};

/** Natural sort for "PAES 401" / "PAES 106" style strings — plain string sort would put "PAES 106" after "PAES 15" if that ever showed up. */
function comparePaesReference(a: string, b: string): number {
  const na = Number(a.match(/(\d+)/)?.[1] ?? NaN);
  const nb = Number(b.match(/(\d+)/)?.[1] ?? NaN);
  if (!Number.isNaN(na) && !Number.isNaN(nb) && na !== nb) return na - nb;
  return a.localeCompare(b);
}

/** One PAES standard's "page": a heading for the standard number, its Quick Reference entries, and a link into a quiz scoped to just this standard. */
function PaesStandardGroup({ paesReference, entries }: { paesReference: string; entries: PaesLibraryEntry[] }) {
  const tables = entries.filter((e) => e.kind === "table");
  const constants = entries.filter((e) => e.kind === "constant");
  const formulas = entries.filter((e) => e.kind === "formula");

  return (
    <div className="rounded-lg border border-border bg-card/40 p-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="text-lg font-bold tracking-tight text-foreground">{paesReference}</h2>
          <p className="text-xs text-muted-foreground">
            {entries.length} {entries.length === 1 ? "entry" : "entries"}
          </p>
        </div>
        <Link
          href={`/paes/quiz?paes=${encodeURIComponent(paesReference)}`}
          className="inline-flex items-center gap-1.5 rounded-lg bg-primary px-2.5 py-1.5 text-xs font-semibold text-primary-foreground transition-colors hover:bg-primary/80"
        >
          Practice this PAES
          <ArrowRight className="size-3.5" />
        </Link>
      </div>

      <div className="mt-3">
        <p className="text-xs font-semibold tracking-wide text-muted-foreground uppercase">Quick Reference</p>

        {constants.length > 0 && (
          <div className="mt-2 grid grid-cols-1 gap-2.5 sm:grid-cols-2 xl:grid-cols-3">
            {constants.map((entry) => (
              <ConstantCard key={entry.id} entry={entry} />
            ))}
          </div>
        )}

        {formulas.length > 0 && (
          <div className="mt-2 grid grid-cols-1 items-start gap-2.5 sm:grid-cols-2">
            {formulas.map((entry) => (
              <FormulaCard key={entry.id} entry={entry} />
            ))}
          </div>
        )}

        {tables.length > 0 && (
          <div className="mt-2 space-y-3">
            {tables.map((entry) => (
              <TableEntryCard key={entry.id} entry={entry} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

export function PaesLibraryBrowser({
  entries,
  initialSearch = "",
}: {
  entries: PaesLibraryEntry[];
  initialSearch?: string;
}) {
  const [search, setSearch] = useState(initialSearch);
  const [category, setCategory] = useState<PaesCategory | "all">("all");

  // Only offer category chips for categories that actually have PAES content
  // right now — never advertise a category with zero entries.
  const availableCategories = useMemo(() => {
    const present = new Set(entries.map((e) => e.category));
    return PAES_CATEGORY_ORDER.filter((c) => present.has(c));
  }, [entries]);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    return entries.filter((e) => {
      if (category !== "all" && e.category !== category) return false;
      if (!q) return true;
      return [e.paes_reference, e.title, e.description, e.topic_name, e.exam_area_name, e.subject_name, e.subtopic_name]
        .filter(Boolean)
        .some((f) => f!.toLowerCase().includes(q));
    });
  }, [entries, search, category]);

  const groups = useMemo(() => {
    const byRef = new Map<string, PaesLibraryEntry[]>();
    for (const e of filtered) {
      const list = byRef.get(e.paes_reference) ?? [];
      list.push(e);
      byRef.set(e.paes_reference, list);
    }
    return [...byRef.entries()]
      .sort((a, b) => comparePaesReference(a[0], b[0]))
      .map(([paesReference, groupEntries]) => ({ paesReference, entries: groupEntries }));
  }, [filtered]);

  return (
    <div className="mt-6">
      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by PAES number, title, topic…"
        className="max-w-md"
      />

      {availableCategories.length > 0 && (
        <div className="mt-3 flex flex-wrap gap-1.5">
          <button type="button" onClick={() => setCategory("all")}>
            <Badge variant={category === "all" ? "default" : "outline"} className="cursor-pointer px-2.5 py-1">
              All
            </Badge>
          </button>
          {availableCategories.map((c) => (
            <button key={c} type="button" onClick={() => setCategory(c)}>
              <Badge variant={category === c ? "default" : "outline"} className="cursor-pointer px-2.5 py-1">
                {c}
              </Badge>
            </button>
          ))}
        </div>
      )}

      <div className="mt-5 space-y-4">
        {groups.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            {entries.length === 0
              ? "No PAES Library content published yet."
              : "No matches for your search or filter."}
          </p>
        ) : (
          groups.map((g) => <PaesStandardGroup key={g.paesReference} paesReference={g.paesReference} entries={g.entries} />)
        )}
      </div>
    </div>
  );
}
