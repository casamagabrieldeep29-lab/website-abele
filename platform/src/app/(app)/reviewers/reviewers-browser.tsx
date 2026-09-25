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

export function renderFormula(text: string): ReactNode[] {
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

function CopyButton({ value }: { value: string }) {
  const [copied, setCopied] = useState(false);

  async function handleCopy() {
    try {
      await navigator.clipboard.writeText(value);
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

/** Formula-focused card: large mathematical notation is the visual focus. */
export function FormulaCard({ entry }: { entry: ReviewerEntry }) {
  const formulaLines = entry.formula ? splitFormulaLines(entry.formula) : [];
  const varPairs = entry.variables ? parseVariables(entry.variables) : null;

  return (
    <div data-slot="card" className="rounded-lg border border-border bg-card p-4">
      <p className="text-base leading-snug font-semibold text-foreground">{entry.title}</p>
      <p className="mt-0.5 text-[11px] leading-snug text-muted-foreground/80">
        {entry.topic_name}
        {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
      </p>

      {formulaLines.length > 0 && (
        <div className="mt-2.5 rounded-md bg-primary/5 px-3 py-2.5">
          <div className="flex items-center justify-between gap-2">
            <p className={`${SECTION_LABEL} text-primary/70`}>Formula</p>
            {entry.formula && <CopyButton value={entry.formula} />}
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

/**
 * Compact "quick reference" card: the value is the visual focus, everything
 * else (name, symbol, context) is deliberately smaller so the number a
 * student is scanning for jumps out first.
 */
export function ConstantCard({ entry }: { entry: ReviewerEntry }) {
  const copyValue = entry.value ? `${entry.value}${entry.unit ? ` ${entry.unit}` : ""}` : null;

  return (
    <div data-slot="card" className="flex flex-col rounded-lg border border-border bg-card p-3">
      <div className="flex items-start justify-between gap-2">
        <p className="text-[10px] leading-snug font-semibold text-muted-foreground uppercase tracking-wide">{entry.title}</p>
        {copyValue && <CopyButton value={copyValue} />}
      </div>

      {entry.symbol && <p className="mt-1 font-mono text-sm text-primary/80">{renderFormula(entry.symbol)}</p>}

      {entry.value && (
        <div className="mt-1.5 flex flex-wrap items-baseline gap-x-1.5">
          <span className="font-mono text-2xl leading-none font-bold text-foreground tabular-nums">
            {renderFormula(entry.value)}
          </span>
          {entry.unit && <span className="text-xs text-muted-foreground">{entry.unit}</span>}
        </div>
      )}

      {entry.description && <p className="mt-1.5 text-[11px] leading-snug text-muted-foreground">{entry.description}</p>}
      {entry.notes && <p className="mt-1.5 text-[11px] leading-snug text-gold">⚠ {entry.notes}</p>}

      <p className="mt-auto pt-1.5 text-[10px] leading-snug text-muted-foreground/70">
        {entry.topic_name}
        {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
      </p>
    </div>
  );
}

type ParsedTable = { headers: string[]; rows: string[][] };

// table_content is meant to be authored as a markdown pipe table:
//   | Property | Symbol | Value | Unit |
//   |---|---|---|---|
//   | Density | ρ | 998.2 | kg/m³ |
// Any text that doesn't confidently match that shape (every non-blank line
// containing "|", a valid "---" separator row, and every row the same
// column count as the header) is left as null so the caller can fall back
// to the next, looser parser below.
function parseMarkdownTable(text: string): ParsedTable | null {
  const lines = text
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean);
  if (lines.length < 3 || !lines.every((l) => l.includes("|"))) return null;

  function splitRow(line: string): string[] {
    let s = line.trim();
    if (s.startsWith("|")) s = s.slice(1);
    if (s.endsWith("|")) s = s.slice(0, -1);
    return s.split("|").map((c) => c.trim());
  }

  const headers = splitRow(lines[0]);
  const separator = splitRow(lines[1]);
  if (separator.length !== headers.length || !separator.every((c) => /^:?-{2,}:?$/.test(c))) return null;

  const rows = lines.slice(2).map(splitRow);
  if (rows.some((r) => r.length !== headers.length)) return null;

  return { headers, rows };
}

const GENERIC_HEADERS = ["Item", "Description", "Value", "Unit", "Notes"];

// Most table_content in this dataset was authored as plain "A | B" lines with
// NO header or "---" separator row at all (a glossary/classification list,
// e.g. "Corncob | 30-36 deg"), which parseMarkdownTable correctly rejects.
// This recovers those as real tables too: every non-blank line must contain
// "|" and split into the SAME column count (>=2). Whether row 0 is itself a
// genuine header (as opposed to just the first data row) is decided per
// column: a real header cell reads as descriptive text ("Width of slat
// (mm)"), while the data rows below it are numeric/measurement-shaped
// ("18 - 25"). If row 0's numeric-ness differs from the rest of that column
// for at least one column, it's treated as a header; otherwise there simply
// is no header in the source and a safe, generic one is used instead
// (accurate for a 2-column glossary shape, never a fabricated domain term).
function looksNumericCell(cell: string): boolean {
  return /\d/.test(cell);
}

function parseLooseTable(text: string): ParsedTable | null {
  const lines = text
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean);
  if (lines.length < 1 || !lines.every((l) => l.includes("|"))) return null;

  const allRows = lines.map((l) => l.split("|").map((c) => c.trim()));
  const colCount = allRows[0].length;
  if (colCount < 2 || allRows.some((r) => r.length !== colCount)) return null;

  let firstRowIsHeader = false;
  if (allRows.length > 1) {
    const dataRows = allRows.slice(1);
    for (let c = 0; c < colCount; c++) {
      const firstIsNumeric = looksNumericCell(allRows[0][c]);
      const dataMostlyNumeric =
        dataRows.filter((r) => looksNumericCell(r[c])).length >= Math.ceil(dataRows.length / 2);
      if (!firstIsNumeric && dataMostlyNumeric) {
        firstRowIsHeader = true;
        break;
      }
    }
  }

  const headers = firstRowIsHeader ? allRows[0] : GENERIC_HEADERS.slice(0, colCount);
  const rows = firstRowIsHeader ? allRows.slice(1) : allRows;
  if (rows.length === 0) return null;

  return { headers, rows };
}

// A handful of table-kind entries actually hold formula reference sheets
// (equations chained by "\n" and ";", no "|" anywhere) rather than tabular
// data — e.g. "P(occur) = 1/T". Rendering these through <pre> buried them as
// plain code text; this renders them with the same formula styling used
// elsewhere instead, so a formula stays visually a formula.
function looksLikeFormulaList(text: string): boolean {
  return !text.includes("|") && /=/.test(text);
}

type FormulaGroup = { label: string | null; lines: string[] };

function parseFormulaGroups(text: string): FormulaGroup[] {
  return text
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean)
    .map((line) => {
      const colonIdx = line.indexOf(":");
      // Only treat a leading colon as a label when what precedes it is plain
      // words (not itself part of a formula, e.g. "P(occur) = 1/T" has no
      // colon at all, but something like "R = A/P = (1/4)[...]" might contain
      // one incidentally — guard by requiring the label to hold no "=").
      const label = colonIdx > 0 && !line.slice(0, colonIdx).includes("=") ? line.slice(0, colonIdx).trim() : null;
      const rest = label ? line.slice(colonIdx + 1).trim() : line;
      const lines = rest
        .split(";")
        .map((s) => s.trim())
        .filter(Boolean);
      return { label, lines };
    });
}

/** Dense, full-width reference table optimized for scanning, not a card grid. */
export function TableEntryCard({ entry }: { entry: ReviewerEntry }) {
  const parsed = entry.table_content
    ? (parseMarkdownTable(entry.table_content) ?? parseLooseTable(entry.table_content))
    : null;
  const formulaGroups =
    !parsed && entry.table_content && looksLikeFormulaList(entry.table_content)
      ? parseFormulaGroups(entry.table_content)
      : null;

  // A cell is "value-like" if it's short and mostly digits — a bare number
  // or number+unit ("998.2 kg/m³"), not a label that merely contains a
  // digit ("Mild Steel A36" has a 4+ letter word, so it stays prose). A
  // column counts as numeric (and right-aligns, header included) when most
  // of its data rows qualify — decided per column, not per cell, so a
  // header never ends up misaligned against the values beneath it.
  const isValueLikeCell = (cell: string) => cell.length <= 28 && /\d/.test(cell) && !/[A-Za-z]{4,}/.test(cell);
  const numericCols = parsed
    ? parsed.headers.map((_, ci) => {
        const dataRows = parsed.rows;
        if (dataRows.length === 0) return false;
        const valueLike = dataRows.filter((r) => isValueLikeCell(r[ci] ?? "")).length;
        return valueLike >= Math.ceil(dataRows.length / 2);
      })
    : [];

  return (
    <div data-slot="card" className="rounded-lg border border-border bg-card p-4">
      <p className="text-base leading-snug font-semibold text-foreground">{entry.title}</p>
      <p className="mt-0.5 text-[11px] leading-snug text-muted-foreground/80">
        {entry.topic_name}
        {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
      </p>
      {entry.description && <p className="mt-1 text-[13px] leading-relaxed text-muted-foreground">{entry.description}</p>}

      {parsed ? (
        <div className="mt-2.5 max-h-96 overflow-auto rounded-md border border-border/60">
          <table className="w-full min-w-max border-collapse text-sm">
            <thead className="sticky top-0 bg-muted">
              <tr>
                {parsed.headers.map((h, i) => (
                  <th
                    key={i}
                    className={`border-b border-border px-3 py-2 text-xs font-semibold whitespace-nowrap text-muted-foreground uppercase tracking-wide ${numericCols[i] ? "text-right" : "text-left"}`}
                  >
                    {h}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              {parsed.rows.map((row, ri) => (
                <tr key={ri} className={ri % 2 === 1 ? "bg-muted/25" : ""}>
                  {row.map((cell, ci) => {
                    // Short value-like cells stay on one line; longer prose
                    // (a glossary's "description" column) wraps instead of
                    // forcing the whole table absurdly wide.
                    const long = cell.length > 28;
                    return (
                      <td
                        key={ci}
                        className={`px-3 py-2 text-foreground ${long ? "min-w-[16rem] whitespace-normal" : "whitespace-nowrap"} ${numericCols[ci] ? "text-right tabular-nums" : ""}`}
                      >
                        {renderFormula(cell)}
                      </td>
                    );
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : formulaGroups ? (
        <div className="mt-2.5 space-y-2 rounded-md bg-primary/5 px-3 py-2.5">
          {formulaGroups.map((group, gi) => (
            <div key={gi}>
              {group.label && <p className={`${SECTION_LABEL} text-primary/70`}>{group.label}</p>}
              <div className={group.label ? "mt-1 space-y-0.5" : "space-y-0.5"}>
                {group.lines.map((line, li) => (
                  <p key={li} className="font-mono text-[13px] leading-relaxed font-medium text-foreground">
                    {renderFormula(line)}
                  </p>
                ))}
              </div>
            </div>
          ))}
        </div>
      ) : (
        entry.table_content && (
          <pre className="mt-2.5 overflow-x-auto rounded-md bg-muted p-2.5 text-xs whitespace-pre-wrap">{entry.table_content}</pre>
        )
      )}

      {entry.notes && <p className="mt-2 text-xs text-gold">⚠ {entry.notes}</p>}
    </div>
  );
}

/** Groups one kind's filtered entries under their TOS, collapsed by default — a search match auto-expands only the TOS group(s) it's actually in. */
function TosGroupedEntries({
  entries,
  isSearching,
  kind,
}: {
  entries: ReviewerEntry[];
  isSearching: boolean;
  kind: ReviewerEntry["kind"];
}) {
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
                {kind === "table" ? (
                  <div className="space-y-3 px-3 pb-3">
                    {group.entries.map((entry) => (
                      <TableEntryCard key={entry.id} entry={entry} />
                    ))}
                  </div>
                ) : kind === "constant" ? (
                  <div className="grid grid-cols-1 gap-2.5 px-3 pb-3 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-4">
                    {group.entries.map((entry) => (
                      <ConstantCard key={entry.id} entry={entry} />
                    ))}
                  </div>
                ) : (
                  <div className="grid grid-cols-1 items-start gap-2.5 px-3 pb-3 sm:grid-cols-2">
                    {group.entries.map((entry) => (
                      <FormulaCard key={entry.id} entry={entry} />
                    ))}
                  </div>
                )}
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
      [e.title, e.description, e.topic_name, e.exam_area_name, e.subject_name, e.subtopic_name, e.symbol, e.formula, e.value, e.unit]
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
        placeholder="Search by title, symbol, value, area, subject, topic…"
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
                <TosGroupedEntries entries={byKind(kind)} isSearching={isSearching} kind={kind} />
              )}
            </div>
          </TabsContent>
        ))}
      </Tabs>
    </div>
  );
}
