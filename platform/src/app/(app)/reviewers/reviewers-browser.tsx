"use client";

import { useMemo, useState, type ReactNode } from "react";
import { ChevronRight } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Input } from "@/components/ui/input";

export type ReviewerEntry = {
  id: string;
  kind: "formula" | "table" | "constant";
  title: string;
  formula: string | null;
  variables: string | null;
  symbol: string | null;
  value: string | null;
  unit: string | null;
  table_content: string | null;
  description: string | null;
  notes: string | null;
  source: string | null;
  topic_id: string;
  subtopic_id: string | null;
  topic_name: string;
  exam_area_id: string;
  exam_area_name: string;
  subject_name: string;
  subtopic_name: string | null;
};

const KIND_LABELS: Record<ReviewerEntry["kind"], string> = {
  formula: "Formulas",
  table: "Tables",
  constant: "Constants",
};

// Real formula strings here are plain text, not LaTeX — and many genuinely mix
// in English annotations ("confined aquifer", "water delivered from source"),
// which would render broken if the whole string were forced through KaTeX
// math-mode (every word gets italicized and spaced like separate variables).
// This targets only the actual subscript/superscript markers (`_x`, `^x`,
// `_{multi}`, `^{multi}`) with real <sub>/<sup> tags — always renders
// correctly regardless of what surrounds it, no data changes needed.
const SUBSUP_RE = /([_^])(\{[^{}]+\}|\([^()]+\)|-?[A-Za-z0-9]+)/g;

function renderFormula(text: string): ReactNode[] {
  const nodes: ReactNode[] = [];
  let lastIndex = 0;
  let key = 0;

  for (const match of text.matchAll(SUBSUP_RE)) {
    const index = match.index ?? 0;
    if (index > lastIndex) nodes.push(text.slice(lastIndex, index));
    const marker = match[1];
    const raw = match[2];
    const content = raw.startsWith("{") || raw.startsWith("(") ? raw.slice(1, -1) : raw;
    nodes.push(marker === "_" ? <sub key={key++}>{content}</sub> : <sup key={key++}>{content}</sup>);
    lastIndex = index + match[0].length;
  }
  if (lastIndex < text.length) nodes.push(text.slice(lastIndex));
  return nodes;
}

function EntryCard({ entry }: { entry: ReviewerEntry }) {
  return (
    <div className="rounded-lg border border-border bg-card p-3.5">
      <div className="flex items-start justify-between gap-2">
        <p className="text-sm font-semibold leading-snug">{entry.title}</p>
        <span className="shrink-0 text-right text-[11px] leading-snug text-muted-foreground">
          {entry.topic_name}
          {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
        </span>
      </div>

      {entry.kind === "formula" && entry.formula && (
        <p className="mt-1.5 overflow-x-auto font-mono text-base leading-snug font-medium whitespace-pre-wrap text-primary">
          {renderFormula(entry.formula)}
        </p>
      )}

      {entry.kind === "constant" && (
        <div className="mt-1.5 flex flex-wrap items-baseline gap-x-2 gap-y-1">
          {entry.symbol && <span className="font-mono text-base font-medium text-primary">{renderFormula(entry.symbol)}</span>}
          {entry.value && (
            <span className="text-sm font-medium">
              = {entry.value}
              {entry.unit ? ` ${entry.unit}` : ""}
            </span>
          )}
        </div>
      )}

      {entry.kind === "table" && entry.table_content && (
        <pre className="mt-1.5 overflow-x-auto rounded-md bg-muted p-2 text-xs whitespace-pre-wrap">{entry.table_content}</pre>
      )}

      {entry.variables && (
        <p className="mt-1 text-xs leading-relaxed text-muted-foreground">where {renderFormula(entry.variables)}</p>
      )}
      {entry.description && <p className="mt-1 text-[13px] leading-relaxed text-muted-foreground">{entry.description}</p>}
      {entry.notes && <p className="mt-1 text-xs text-gold">⚠ {entry.notes}</p>}
    </div>
  );
}

/** Groups one kind's filtered entries under their TOS, collapsed by default — a search match auto-expands only the TOS group(s) it's actually in. */
function TosGroupedEntries({ entries, isSearching }: { entries: ReviewerEntry[]; isSearching: boolean }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  const groups = useMemo(() => {
    const byArea = new Map<string, { name: string; entries: ReviewerEntry[] }>();
    for (const e of entries) {
      const g = byArea.get(e.exam_area_id) ?? { name: e.exam_area_name, entries: [] };
      g.entries.push(e);
      byArea.set(e.exam_area_id, g);
    }
    return [...byArea.entries()].map(([id, g]) => ({ id, ...g }));
  }, [entries]);

  function isOpen(id: string) {
    return isSearching || openIds.has(id);
  }

  function toggle(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  return (
    <div className="space-y-2">
      {groups.map((group) => {
        const open = isOpen(group.id);
        return (
          <div key={group.id} className="rounded-lg border border-border/60">
            <Collapsible open={open} onOpenChange={() => toggle(group.id)}>
              <CollapsibleTrigger className="flex w-full items-center gap-2 px-3 py-2 text-left">
                <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                <span className="min-w-0 flex-1 text-sm font-medium break-words">{group.name}</span>
                <span className="shrink-0 text-xs text-muted-foreground">
                  {group.entries.length} {group.entries.length === 1 ? "entry" : "entries"}
                </span>
              </CollapsibleTrigger>
              <CollapsibleContent open={open}>
                <div className="grid grid-cols-1 gap-2.5 px-3 pb-3 sm:grid-cols-2">
                  {group.entries.map((entry) => (
                    <EntryCard key={entry.id} entry={entry} />
                  ))}
                </div>
              </CollapsibleContent>
            </Collapsible>
          </div>
        );
      })}
    </div>
  );
}

export function ReviewersBrowser({ entries, initialSearch = "" }: { entries: ReviewerEntry[]; initialSearch?: string }) {
  const [search, setSearch] = useState(initialSearch);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return entries;
    return entries.filter((e) =>
      [e.title, e.description, e.topic_name, e.exam_area_name, e.subject_name, e.subtopic_name, e.symbol, e.formula]
        .filter(Boolean)
        .some((f) => f!.toLowerCase().includes(q)),
    );
  }, [entries, search]);

  const isSearching = search.trim().length > 0;
  const byKind = (kind: ReviewerEntry["kind"]) => filtered.filter((e) => e.kind === kind);

  return (
    <div className="mt-6">
      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by title, area, subject, topic…"
        className="mb-4 max-w-md"
      />

      <Tabs defaultValue="formula">
        <TabsList>
          {(["formula", "table", "constant"] as const).map((kind) => (
            <TabsTrigger key={kind} value={kind}>
              {KIND_LABELS[kind]} ({byKind(kind).length})
            </TabsTrigger>
          ))}
        </TabsList>

        {(["formula", "table", "constant"] as const).map((kind) => (
          <TabsContent key={kind} value={kind}>
            <div className="mt-3">
              {byKind(kind).length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  {entries.length === 0
                    ? `No ${KIND_LABELS[kind].toLowerCase()} published yet.`
                    : "No matches for your search."}
                </p>
              ) : (
                <TosGroupedEntries entries={byKind(kind)} isSearching={isSearching} />
              )}
            </div>
          </TabsContent>
        ))}
      </Tabs>
    </div>
  );
}
