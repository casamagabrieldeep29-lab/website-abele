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

// Multi-part formula fields (several related equations transcribed into one
// string) were authored with a run of 2+ spaces between each part — e.g.
// "Total area = W × L        T1 (time to turn) = ...". A single equation
// never contains a double space in this dataset, so splitting on that run
// safely recovers the intended line breaks without touching any content.
function splitFormulaLines(formula: string): string[] {
  return formula
    .split(/\s{2,}/)
    .map((s) => s.trim())
    .filter(Boolean);
}

type VarPair = { symbol: string; meaning: string };

// A real symbol token in this dataset (ρ, g, Q, N1, T1, H/TDH, F_G, ΔV, Eff,
// BHP, Area, Swath…) never contains a space, and is either short (≤3 chars),
// contains a digit, underscore or slash, is a Greek letter, is written in
// caps, or is a single capitalized word (a descriptive symbol name some
// entries use instead of a letter, e.g. "Area", "Swath") — unlike an
// ordinary lowercase English word from the surrounding prose (e.g.
// "pulleys", "gravity", "rate", "head"), which this deliberately excludes.
function isSymbolToken(tok: string): boolean {
  return (
    /^[A-Za-zΑ-Ωα-ω]/.test(tok) &&
    (/\d/.test(tok) ||
      tok.includes("_") ||
      tok.includes("/") ||
      /[Α-Ωα-ω]/.test(tok) ||
      tok.length <= 3 ||
      tok === tok.toUpperCase() ||
      (/^[A-Z][a-z]+$/.test(tok) && tok.length <= 8))
  );
}

/**
 * Existing "variables" text chains every symbol's definition into one
 * paragraph: "ρ = fluid density, g = gravity, Q = flow rate (gpm in the
 * second form), H/TDH = total dynamic head (ft)". This recovers the
 * symbol → meaning structure already implicit in the "X = ..." punctuation,
 * without rewriting the stored text. For each "=" after the first, it walks
 * backward through comma-separated symbol-shaped tokens to find where that
 * definition's symbol(s) start; anything that doesn't look like a symbol
 * stops the walk, so a definition's own words are never mistaken for the
 * next symbol. If that walk stops on a bare space (no comma) right after
 * another symbol-shaped word — e.g. "Stroke Length =", where either word
 * could plausibly be the intended multi-word symbol name — there's no safe
 * way to tell where it actually starts, so the whole field is left
 * unparsed. Returns null (render the original text unchanged) whenever the
 * string doesn't confidently decompose this way, e.g. plain prose with no
 * "=" signs at all.
 */
function parseVariables(text: string): VarPair[] | null {
  const eqPositions: number[] = [];
  for (let i = 0; i < text.length; i++) if (text[i] === "=") eqPositions.push(i);
  if (eqPositions.length === 0) return null;

  const symbolStarts: number[] = [];
  for (let i = 0; i < eqPositions.length; i++) {
    const eqIdx = eqPositions[i];
    if (i === 0) {
      symbolStarts.push(0);
      continue;
    }
    let pos = eqIdx;
    while (pos > 0 && /\s/.test(text[pos - 1])) pos--;
    let listStart = pos;
    let cursor = pos;
    let ambiguous = false;
    while (true) {
      let tStart = cursor;
      while (tStart > 0 && !/[\s,]/.test(text[tStart - 1])) tStart--;
      const token = text.slice(tStart, cursor);
      if (!token || !isSymbolToken(token)) break;
      listStart = tStart;
      cursor = tStart;
      let p = cursor;
      while (p > 0 && /\s/.test(text[p - 1])) p--;
      if (p > 0 && text[p - 1] === ",") {
        cursor = p - 1;
        continue;
      }
      if (p > 0) {
        let wStart = p;
        while (wStart > 0 && !/[\s,]/.test(text[wStart - 1])) wStart--;
        const prevWord = text.slice(wStart, p);
        if (prevWord && isSymbolToken(prevWord)) ambiguous = true;
      }
      break;
    }
    if (ambiguous) return null;
    symbolStarts.push(listStart);
  }

  const pairs: VarPair[] = [];
  for (let i = 0; i < eqPositions.length; i++) {
    const symbol = text.slice(symbolStarts[i], eqPositions[i]).trim();
    const meaningEnd = i + 1 < eqPositions.length ? symbolStarts[i + 1] : text.length;
    const meaning = text
      .slice(eqPositions[i] + 1, meaningEnd)
      .trim()
      .replace(/,\s*$/, "");
    if (!symbol || !meaning) return null;
    pairs.push({ symbol, meaning });
  }
  return pairs;
}

const SECTION_LABEL = "text-xs font-semibold uppercase tracking-wide";

function CopyFormulaButton({ formula }: { formula: string }) {
  const [copied, setCopied] = useState(false);

  async function handleCopy() {
    try {
      await navigator.clipboard.writeText(formula);
      setCopied(true);
      window.setTimeout(() => setCopied(false), 1500);
    } catch {
      // Clipboard unavailable (e.g. insecure context) — not critical, just skip the confirmation.
    }
  }

  return (
    <button
      type="button"
      onClick={handleCopy}
      className="shrink-0 text-[11px] text-muted-foreground transition-colors hover:text-primary"
    >
      {copied ? "✓ Copied" : "Copy"}
    </button>
  );
}

function EntryCard({ entry }: { entry: ReviewerEntry }) {
  const formulaLines = entry.formula ? splitFormulaLines(entry.formula) : [];
  const varPairs = entry.variables ? parseVariables(entry.variables) : null;

  return (
    <div className="rounded-lg border border-border bg-card p-4">
      <p className="text-base leading-snug font-semibold text-foreground">{entry.title}</p>
      <p className="mt-0.5 text-[11px] leading-snug text-muted-foreground/80">
        {entry.topic_name}
        {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
      </p>

      {entry.kind === "formula" && formulaLines.length > 0 && (
        <div className="mt-2.5 rounded-md bg-primary/5 px-3 py-2.5">
          <div className="flex items-center justify-between gap-2">
            <p className={`${SECTION_LABEL} text-primary/70`}>Formula</p>
            {entry.formula && <CopyFormulaButton formula={entry.formula} />}
          </div>
          <div className="mt-1 space-y-1">
            {formulaLines.map((line, i) => (
              <p key={i} className="font-mono text-[15px] leading-relaxed font-medium text-foreground">
                {renderFormula(line)}
              </p>
            ))}
          </div>
        </div>
      )}

      {entry.kind === "constant" && (entry.symbol || entry.value) && (
        <div className="mt-2.5 rounded-md bg-primary/5 px-3 py-2.5">
          <p className={`${SECTION_LABEL} text-primary/70`}>Value</p>
          <div className="mt-1 flex flex-wrap items-baseline gap-x-2 gap-y-1">
            {entry.symbol && <span className="font-mono text-[15px] font-medium text-foreground">{renderFormula(entry.symbol)}</span>}
            {entry.value && (
              <span className="font-mono text-[15px] font-medium text-foreground">
                = {entry.value}
                {entry.unit ? ` ${entry.unit}` : ""}
              </span>
            )}
          </div>
        </div>
      )}

      {entry.kind === "table" && entry.table_content && (
        <div className="mt-2.5">
          <p className={`${SECTION_LABEL} text-primary/70`}>Table</p>
          <pre className="mt-1 overflow-x-auto rounded-md bg-muted p-2 text-xs whitespace-pre-wrap">{entry.table_content}</pre>
        </div>
      )}

      {entry.variables && (
        <div className="mt-2.5">
          <p className={`${SECTION_LABEL} text-muted-foreground`}>Where</p>
          {varPairs ? (
            <div className="mt-1 grid grid-cols-[auto_1fr] gap-x-2.5 gap-y-0.5">
              {varPairs.flatMap((p, i) => [
                <span key={`${i}-sym`} className="font-mono text-xs font-medium text-primary">
                  {renderFormula(p.symbol)}
                </span>,
                <span key={`${i}-def`} className="text-xs leading-relaxed text-muted-foreground">
                  {p.meaning}
                </span>,
              ])}
            </div>
          ) : (
            <p className="mt-1 text-xs leading-relaxed text-muted-foreground">{renderFormula(entry.variables)}</p>
          )}
        </div>
      )}

      {entry.description && (
        <div className="mt-2.5 border-t border-border/60 pt-2.5">
          <p className={`${SECTION_LABEL} text-muted-foreground`}>What it means</p>
          <p className="mt-1 text-[13px] leading-relaxed text-muted-foreground">{entry.description}</p>
        </div>
      )}

      {entry.notes && <p className="mt-2 text-xs text-gold">⚠ {entry.notes}</p>}
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
                <div className="grid grid-cols-1 items-start gap-2.5 px-3 pb-3 sm:grid-cols-2">
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
