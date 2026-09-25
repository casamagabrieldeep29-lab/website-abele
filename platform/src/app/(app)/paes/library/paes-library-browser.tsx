"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { ArrowRight, ChevronRight } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import type { ReviewerEntry } from "../../reviewers/reviewers-browser";
import { FormulaCard, ConstantCard, TableEntryCard } from "../../reviewers/reviewers-browser";
import type { PaesCategory } from "@/lib/paes-categories";
import { PAES_STANDARD_TITLES, PAES_SERIES_ORDER, derivePaesSeries, stripPaesStandardPrefix } from "@/lib/paes-standard-titles";

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

function withSubtitle(entry: PaesLibraryEntry): PaesLibraryEntry {
  return { ...entry, title: stripPaesStandardPrefix(entry.title) };
}

/** One PAES standard's "page": a collapsible section headed by the standard's real official title, its Quick Reference entries (as subtitled cards), and a link into a quiz scoped to just this standard. */
function PaesStandardGroup({
  paesReference,
  entries,
  defaultOpen,
}: {
  paesReference: string;
  entries: PaesLibraryEntry[];
  defaultOpen: boolean;
}) {
  const [open, setOpen] = useState(defaultOpen);

  const tables = entries.filter((e) => e.kind === "table").map(withSubtitle);
  const constants = entries.filter((e) => e.kind === "constant").map(withSubtitle);
  const formulas = entries.filter((e) => e.kind === "formula").map(withSubtitle);
  const officialTitle = PAES_STANDARD_TITLES[paesReference];

  return (
    <div className="rounded-lg border border-border bg-card/40">
      <Collapsible open={open} onOpenChange={setOpen}>
        <div className="flex flex-wrap items-center justify-between gap-3 p-4 pb-0">
          <CollapsibleTrigger className="group flex min-w-0 flex-1 items-start gap-2 text-left">
            <ChevronRight className="mt-1 size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
            <div className="min-w-0">
              <h2 className="text-lg font-bold tracking-tight text-foreground">
                {paesReference}
                {officialTitle && <span className="font-semibold"> — {officialTitle}</span>}
              </h2>
              <p className="text-xs text-muted-foreground">
                {entries.length} {entries.length === 1 ? "entry" : "entries"}
              </p>
            </div>
          </CollapsibleTrigger>
          <Link
            href={`/paes/quiz?paes=${encodeURIComponent(paesReference)}`}
            className="inline-flex shrink-0 items-center gap-1.5 rounded-lg bg-primary px-2.5 py-1.5 text-xs font-semibold text-primary-foreground transition-colors hover:bg-primary/80"
          >
            Practice this PAES
            <ArrowRight className="size-3.5" />
          </Link>
        </div>

        <CollapsibleContent open={open}>
          <div className="p-4 pt-3">
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
        </CollapsibleContent>
      </Collapsible>
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
  const [series, setSeries] = useState<(typeof PAES_SERIES_ORDER)[number] | "all">("all");

  // Filter by the PAES standard's own numbering series (100s, 200s, ...),
  // not the subject-area category we derive for Mastery — this is the
  // structure a student actually recognizes from the standards themselves.
  // Only offer chips for series that actually have PAES content right now —
  // never advertise a series with zero entries.
  const availableSeries = useMemo(() => {
    const present = new Set(entries.map((e) => derivePaesSeries(e.paes_reference)));
    return PAES_SERIES_ORDER.filter((s) => present.has(s));
  }, [entries]);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    return entries.filter((e) => {
      if (series !== "all" && derivePaesSeries(e.paes_reference) !== series) return false;
      if (!q) return true;
      return [e.paes_reference, e.title, e.description, e.topic_name, e.exam_area_name, e.subject_name, e.subtopic_name]
        .filter(Boolean)
        .some((f) => f!.toLowerCase().includes(q));
    });
  }, [entries, search, series]);

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

  // Collapsed by default (37 standards would otherwise be an overwhelming
  // wall of content). Only a text search auto-expands its matches — the
  // series filter narrows which standards are listed at all, but doesn't by
  // itself mean the student wants every one of them expanded (e.g. picking
  // "PAES 400 Series" still leaves 15 standards; they shouldn't all pop open
  // just from applying that filter).
  const isFiltering = search.trim().length > 0;

  return (
    <div className="mt-6">
      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by PAES number, title, topic…"
        className="max-w-md"
      />

      {availableSeries.length > 0 && (
        <div className="mt-3 flex flex-wrap gap-1.5">
          <button type="button" onClick={() => setSeries("all")}>
            <Badge variant={series === "all" ? "default" : "outline"} className="cursor-pointer px-2.5 py-1">
              All
            </Badge>
          </button>
          {availableSeries.map((s) => (
            <button key={s} type="button" onClick={() => setSeries(s)}>
              <Badge variant={series === s ? "default" : "outline"} className="cursor-pointer px-2.5 py-1">
                {s}
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
          groups.map((g) => (
            // Keying on isFiltering forces a remount (fresh initial `open`
            // state) whenever search/filter starts or clears, instead of
            // syncing local state from a prop via an effect.
            <PaesStandardGroup
              key={`${g.paesReference}:${isFiltering}`}
              paesReference={g.paesReference}
              entries={g.entries}
              defaultOpen={isFiltering}
            />
          ))
        )}
      </div>
    </div>
  );
}
