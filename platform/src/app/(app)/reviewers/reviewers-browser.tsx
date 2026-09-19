"use client";

import { useMemo, useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent } from "@/components/ui/card";
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
  exam_area_name: string;
  subtopic_name: string | null;
};

const KIND_LABELS: Record<ReviewerEntry["kind"], string> = {
  formula: "Formulas",
  table: "Tables",
  constant: "Constants",
};

function EntryCard({ entry }: { entry: ReviewerEntry }) {
  return (
    <Card>
      <CardContent className="py-3">
        <div className="flex items-start justify-between gap-3">
          <p className="text-sm font-semibold">{entry.title}</p>
          <span className="shrink-0 text-xs text-muted-foreground">
            {entry.exam_area_name} · {entry.topic_name}
            {entry.subtopic_name ? ` · ${entry.subtopic_name}` : ""}
          </span>
        </div>

        {entry.kind === "formula" && (
          <div className="mt-2 space-y-1">
            {entry.formula && <p className="font-mono text-sm text-primary">{entry.formula}</p>}
            {entry.variables && <p className="text-xs text-muted-foreground">where {entry.variables}</p>}
          </div>
        )}

        {entry.kind === "constant" && (
          <div className="mt-2 flex flex-wrap items-baseline gap-x-3 gap-y-1">
            {entry.symbol && <span className="font-mono text-sm text-primary">{entry.symbol}</span>}
            {entry.value && (
              <span className="text-sm font-medium">
                = {entry.value}
                {entry.unit ? ` ${entry.unit}` : ""}
              </span>
            )}
          </div>
        )}

        {entry.kind === "table" && entry.table_content && (
          <pre className="mt-2 overflow-x-auto whitespace-pre-wrap rounded-md bg-muted p-2 text-xs">{entry.table_content}</pre>
        )}

        {entry.description && <p className="mt-2 text-sm text-muted-foreground">{entry.description}</p>}
        {entry.notes && <p className="mt-1 text-xs text-gold">⚠ {entry.notes}</p>}
        {entry.source && <p className="mt-1 text-xs text-muted-foreground">Source: {entry.source}</p>}
      </CardContent>
    </Card>
  );
}

export function ReviewersBrowser({ entries, initialSearch = "" }: { entries: ReviewerEntry[]; initialSearch?: string }) {
  const [search, setSearch] = useState(initialSearch);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return entries;
    return entries.filter((e) =>
      [e.title, e.description, e.topic_name, e.exam_area_name, e.subtopic_name, e.symbol, e.formula]
        .filter(Boolean)
        .some((f) => f!.toLowerCase().includes(q)),
    );
  }, [entries, search]);

  const byKind = (kind: ReviewerEntry["kind"]) => filtered.filter((e) => e.kind === kind);

  return (
    <div className="mt-6">
      <Input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by title, area, topic…"
        className="mb-4"
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
            <div className="mt-3 space-y-2">
              {byKind(kind).map((entry) => (
                <EntryCard key={entry.id} entry={entry} />
              ))}
              {byKind(kind).length === 0 && (
                <p className="text-sm text-muted-foreground">
                  {entries.length === 0
                    ? `No ${KIND_LABELS[kind].toLowerCase()} published yet.`
                    : "No matches for your search."}
                </p>
              )}
            </div>
          </TabsContent>
        ))}
      </Tabs>
    </div>
  );
}
