"use client";

import { useMemo, useState } from "react";
import { Hash } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import type { ReviewerEntry } from "../../reviewers/reviewers-browser";
import { ConstantCard, TableEntryCard } from "../../reviewers/reviewers-browser";
import type { PaesCategory } from "@/lib/paes-categories";
import { PAES_CATEGORY_ORDER } from "@/lib/paes-categories";

export type PaesNumberBankEntry = ReviewerEntry & {
  paes_reference: string;
  category: PaesCategory;
};

/** Floats the PAES reference as a small badge over an otherwise-unmodified shared card, so FormulaCard/ConstantCard/TableEntryCard stay untouched and reusable by both /reviewers and here. */
function ReferenceBadge({ paesReference }: { paesReference: string }) {
  return (
    <Badge variant="outline" className="absolute -top-2 left-3 z-10 gap-1 bg-card px-1.5 py-0 text-[10px] font-semibold">
      <Hash className="size-2.5" />
      {paesReference.replace(/^PAES\s*/i, "")}
    </Badge>
  );
}

export function PaesNumberBankBrowser({ entries }: { entries: PaesNumberBankEntry[] }) {
  const [search, setSearch] = useState("");
  const [category, setCategory] = useState<PaesCategory | "all">("all");
  const [reference, setReference] = useState<string | "all">("all");

  const availableCategories = useMemo(() => {
    const present = new Set(entries.map((e) => e.category));
    return PAES_CATEGORY_ORDER.filter((c) => present.has(c));
  }, [entries]);

  const availableReferences = useMemo(() => {
    const set = new Set(entries.map((e) => e.paes_reference));
    return [...set].sort((a, b) => {
      const na = Number(a.match(/(\d+)/)?.[1] ?? NaN);
      const nb = Number(b.match(/(\d+)/)?.[1] ?? NaN);
      if (!Number.isNaN(na) && !Number.isNaN(nb) && na !== nb) return na - nb;
      return a.localeCompare(b);
    });
  }, [entries]);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    return entries.filter((e) => {
      if (category !== "all" && e.category !== category) return false;
      if (reference !== "all" && e.paes_reference !== reference) return false;
      if (!q) return true;
      return [e.paes_reference, e.title, e.description, e.symbol, e.value, e.unit, e.topic_name]
        .filter(Boolean)
        .some((f) => f!.toLowerCase().includes(q));
    });
  }, [entries, search, category, reference]);

  const constants = filtered.filter((e) => e.kind === "constant");
  const tables = filtered.filter((e) => e.kind === "table");

  return (
    <div className="mt-6">
      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by value, symbol, title, PAES number…"
        className="max-w-md"
      />

      <div className="mt-3 flex flex-wrap gap-1.5">
        <button type="button" onClick={() => setCategory("all")}>
          <Badge variant={category === "all" ? "default" : "outline"} className="cursor-pointer px-2.5 py-1">
            All categories
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

      {availableReferences.length > 0 && (
        <div className="mt-2 flex flex-wrap gap-1.5">
          <button type="button" onClick={() => setReference("all")}>
            <Badge variant={reference === "all" ? "secondary" : "outline"} className="cursor-pointer px-2.5 py-1">
              All standards
            </Badge>
          </button>
          {availableReferences.map((r) => (
            <button key={r} type="button" onClick={() => setReference(r)}>
              <Badge variant={reference === r ? "secondary" : "outline"} className="cursor-pointer px-2.5 py-1">
                {r}
              </Badge>
            </button>
          ))}
        </div>
      )}

      {filtered.length === 0 ? (
        <p className="mt-5 text-sm text-muted-foreground">
          {entries.length === 0 ? "No PAES numeric content published yet." : "No matches for your search or filter."}
        </p>
      ) : (
        <div className="mt-5 space-y-6">
          {constants.length > 0 && (
            <div>
              <p className="text-xs font-semibold tracking-wide text-muted-foreground uppercase">Quick Values</p>
              <div className="mt-4 grid grid-cols-1 gap-3 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-4">
                {constants.map((entry) => (
                  <div key={entry.id} className="relative pt-2">
                    <ReferenceBadge paesReference={entry.paes_reference} />
                    <ConstantCard entry={entry} />
                  </div>
                ))}
              </div>
            </div>
          )}

          {tables.length > 0 && (
            <div>
              <p className="text-xs font-semibold tracking-wide text-muted-foreground uppercase">Reference Tables</p>
              <div className="mt-4 space-y-4">
                {tables.map((entry) => (
                  <div key={entry.id} className="relative pt-2">
                    <ReferenceBadge paesReference={entry.paes_reference} />
                    <TableEntryCard entry={entry} />
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
