"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { ChevronRight } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { PaesCategory } from "@/lib/paes-categories";

export type PaesMasteryStatus = "insufficient_data" | "strong" | "developing" | "needs_review";

const MIN_ATTEMPTS_FOR_MASTERY = 5;

export type PaesMasteryReference = {
  paesReference: string;
  sampleTitle: string | null;
  totalAttempts: number;
  overallAccuracy: number | null;
  recentAccuracy: number | null;
  mastery: number | null;
  status: PaesMasteryStatus;
};

export type PaesMasteryCategory = {
  category: PaesCategory;
  mastery: number | null;
  references: PaesMasteryReference[];
};

function statusStyle(status: PaesMasteryStatus | null) {
  switch (status) {
    case "strong":
      return { bar: "bg-success", text: "text-success" };
    case "developing":
      return { bar: "bg-gold", text: "text-gold" };
    case "needs_review":
      return { bar: "bg-destructive", text: "text-destructive" };
    default:
      return { bar: "bg-muted-foreground/40", text: "text-muted-foreground" };
  }
}

function statusFromMastery(mastery: number | null): PaesMasteryStatus | null {
  if (mastery === null) return null;
  if (mastery >= 80) return "strong";
  if (mastery >= 60) return "developing";
  return "needs_review";
}

export function PaesMasteryView({
  categories,
  weakest,
}: {
  categories: PaesMasteryCategory[];
  weakest: PaesMasteryReference[];
}) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  const allIds = useMemo(() => {
    const ids: string[] = [];
    for (const c of categories) {
      ids.push(`cat:${c.category}`);
      for (const r of c.references) ids.push(`ref:${c.category}:${r.paesReference}`);
    }
    return ids;
  }, [categories]);

  function isOpen(id: string) {
    return openIds.has(id);
  }

  function toggle(id: string) {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  function expandAll() {
    setOpenIds(new Set(allIds));
  }

  function collapseAll() {
    setOpenIds(new Set());
  }

  return (
    <div className="space-y-6">
      {weakest.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Weakest PAES areas</CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-1.5 text-sm">
              {weakest.map((r) => (
                <li key={r.paesReference} className="flex items-center justify-between">
                  <span>{r.paesReference}</span>
                  <span className="text-muted-foreground">{r.mastery}%</span>
                </li>
              ))}
            </ul>
            <Button
              render={
                <Link href={`/paes/quiz?paes=${encodeURIComponent(weakest[0].paesReference)}`}>
                  Practice weak areas →
                </Link>
              }
              nativeButton={false}
              size="sm"
              className="mt-3"
            />
          </CardContent>
        </Card>
      )}

      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <h2 className="text-sm font-semibold text-muted-foreground">Mastery by Category</h2>
          <div className="flex gap-2">
            <Button type="button" size="sm" variant="outline" onClick={expandAll}>
              Expand All
            </Button>
            <Button type="button" size="sm" variant="outline" onClick={collapseAll}>
              Collapse All
            </Button>
          </div>
        </div>

        <div className="space-y-2">
          {categories.map((c) => {
            const catId = `cat:${c.category}`;
            const catOpen = isOpen(catId);
            const style = statusStyle(statusFromMastery(c.mastery));

            return (
              <div key={c.category} className="rounded-lg border border-border/60 bg-card">
                <Collapsible open={catOpen} onOpenChange={() => toggle(catId)}>
                  <CollapsibleTrigger className="flex w-full items-center gap-3 px-3 py-3 text-left">
                    <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                    <div className="min-w-0 flex-1">
                      <p className="text-sm font-semibold break-words">{c.category}</p>
                      <div className="mt-1.5 h-1 w-full max-w-40 overflow-hidden rounded-full bg-muted">
                        <div
                          className={`h-full rounded-full ${style.bar}`}
                          style={{ width: `${c.mastery !== null ? Math.min(100, c.mastery) : 0}%` }}
                        />
                      </div>
                    </div>
                    <div className="flex shrink-0 items-center gap-2">
                      <span className={`text-sm font-medium ${style.text}`}>
                        {c.mastery !== null ? `${c.mastery}%` : "—"}
                      </span>
                      <Badge variant="secondary">
                        {c.references.length} {c.references.length === 1 ? "standard" : "standards"}
                      </Badge>
                    </div>
                  </CollapsibleTrigger>

                  <CollapsibleContent open={catOpen}>
                    <div className="space-y-1.5 px-3 pb-3 pl-8">
                      {c.references.map((r) => {
                        const refId = `ref:${c.category}:${r.paesReference}`;
                        const refOpen = isOpen(refId);
                        const refStyle = statusStyle(r.status === "insufficient_data" ? null : r.status);
                        return (
                          <div key={r.paesReference} className="rounded border border-border/50">
                            <Collapsible open={refOpen} onOpenChange={() => toggle(refId)}>
                              <CollapsibleTrigger className="flex w-full items-center gap-2 px-2.5 py-1.5 text-left">
                                <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                <span className="min-w-0 flex-1 truncate text-sm text-muted-foreground">
                                  {r.paesReference}
                                </span>
                                <span className={`shrink-0 text-sm font-medium ${refStyle.text}`}>
                                  {r.mastery !== null ? `${r.mastery}%` : "—"}
                                </span>
                              </CollapsibleTrigger>

                              <CollapsibleContent open={refOpen}>
                                <div className="space-y-2 px-2.5 pb-2.5 pl-6">
                                  {r.status === "insufficient_data" ? (
                                    <p className="text-xs text-muted-foreground">
                                      Gathering data ({r.totalAttempts}/{MIN_ATTEMPTS_FOR_MASTERY} answered)
                                    </p>
                                  ) : (
                                    <dl className="grid grid-cols-2 gap-x-4 gap-y-1 text-xs sm:grid-cols-4">
                                      <div>
                                        <dt className="text-muted-foreground">Attempted</dt>
                                        <dd className="font-medium">{r.totalAttempts}</dd>
                                      </div>
                                      <div>
                                        <dt className="text-muted-foreground">Accuracy</dt>
                                        <dd className="font-medium">
                                          {r.overallAccuracy !== null ? `${r.overallAccuracy}%` : "—"}
                                        </dd>
                                      </div>
                                      <div>
                                        <dt className="text-muted-foreground">Recent accuracy</dt>
                                        <dd className="font-medium">
                                          {r.recentAccuracy !== null ? `${r.recentAccuracy}%` : "—"}
                                        </dd>
                                      </div>
                                      <div>
                                        <dt className="text-muted-foreground">Mastery</dt>
                                        <dd className={`font-medium ${refStyle.text}`}>
                                          {r.mastery !== null ? `${r.mastery}%` : "—"}
                                        </dd>
                                      </div>
                                    </dl>
                                  )}
                                  <Button
                                    render={
                                      <Link href={`/paes/quiz?paes=${encodeURIComponent(r.paesReference)}`}>
                                        Practice {r.paesReference} →
                                      </Link>
                                    }
                                    nativeButton={false}
                                    size="sm"
                                    variant="outline"
                                  />
                                </div>
                              </CollapsibleContent>
                            </Collapsible>
                          </div>
                        );
                      })}
                    </div>
                  </CollapsibleContent>
                </Collapsible>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
