"use client";

import { useMemo, useState } from "react";
import { ChevronRight } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { startAdaptivePracticeAttempt, startSubjectPracticeAttempt } from "@/app/practice/actions";

const SESSION_SIZE = 20;
const MAX_WEIGHT_PERCENT = 18;
const MIN_ATTEMPTS_FOR_MASTERY = 5;

export type MasteryStatus = "insufficient_data" | "strong" | "developing" | "needs_review";

export type MasteryTopic = {
  id: string;
  name: string;
  mastery: number | null;
  status: MasteryStatus;
  totalAttempts: number;
  overallAccuracy: number | null;
  recentAccuracy: number | null;
};

export type MasterySubject = {
  id: string;
  name: string;
  mastery: number | null;
  topics: MasteryTopic[];
};

export type MasteryTOS = {
  id: string;
  name: string;
  weightPercent: number | null;
  mastery: number | null;
  subjects: MasterySubject[];
};

function statusStyle(status: MasteryStatus | null) {
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

function statusFromMastery(mastery: number | null): MasteryStatus | null {
  if (mastery === null) return null;
  if (mastery >= 80) return "strong";
  if (mastery >= 60) return "developing";
  return "needs_review";
}

export function MasteryTree({ tos }: { tos: MasteryTOS[] }) {
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  const allIds = useMemo(() => {
    const ids: string[] = [];
    for (const t of tos) {
      ids.push(`tos:${t.id}`);
      for (const s of t.subjects) {
        ids.push(`subj:${s.id}`);
        for (const topic of s.topics) ids.push(`topic:${topic.id}`);
      }
    }
    return ids;
  }, [tos]);

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
    <div className="space-y-3">
      <div className="flex items-center justify-between">
        <h2 className="text-sm font-semibold text-muted-foreground">Mastery by TOS</h2>
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
        {tos.map((t) => {
          const tosOpen = isOpen(`tos:${t.id}`);
          const style = statusStyle(statusFromMastery(t.mastery));
          const pct = t.weightPercent ?? 0;

          return (
            <div key={t.id} className="rounded-lg border border-border/60 bg-card">
              <Collapsible open={tosOpen} onOpenChange={() => toggle(`tos:${t.id}`)}>
                <CollapsibleTrigger className="flex w-full items-center gap-3 px-3 py-3 text-left">
                  <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                  <div className="min-w-0 flex-1">
                    <p className="text-sm font-semibold break-words">{t.name}</p>
                    <div className="mt-1.5 h-1 w-full max-w-40 overflow-hidden rounded-full bg-muted">
                      <div
                        className={`h-full rounded-full ${style.bar}`}
                        style={{ width: `${Math.min(100, (pct / MAX_WEIGHT_PERCENT) * 100)}%` }}
                      />
                    </div>
                  </div>
                  <div className="flex shrink-0 items-center gap-2">
                    <span className={`text-sm font-medium ${style.text}`}>
                      {t.mastery !== null ? `${t.mastery}%` : "—"}
                    </span>
                    {t.weightPercent !== null && (
                      <Badge variant="secondary">{t.weightPercent}%</Badge>
                    )}
                  </div>
                </CollapsibleTrigger>

                <CollapsibleContent open={tosOpen}>
                  <div className="space-y-2 px-3 pb-3">
                    {t.subjects.length === 0 && (
                      <p className="pl-7 text-xs text-muted-foreground">No subjects yet.</p>
                    )}
                    {t.subjects.map((subject) => {
                      const subjectOpen = isOpen(`subj:${subject.id}`);
                      const subjectStyle = statusStyle(statusFromMastery(subject.mastery));

                      return (
                        <div key={subject.id} className="rounded-md border border-border/60 bg-background/40">
                          <div className="flex flex-wrap items-center justify-between gap-2 px-3 py-2">
                            <Collapsible
                              open={subjectOpen}
                              onOpenChange={() => toggle(`subj:${subject.id}`)}
                              className="min-w-0 flex-1"
                            >
                              <CollapsibleTrigger className="flex w-full min-w-0 items-center gap-2 text-left">
                                <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                <span className="min-w-0 flex-1 text-sm font-medium break-words">{subject.name}</span>
                              </CollapsibleTrigger>
                            </Collapsible>
                            <div className="flex shrink-0 items-center gap-2">
                              <span className={`text-sm font-medium ${subjectStyle.text}`}>
                                {subject.mastery !== null ? `${subject.mastery}%` : "—"}
                              </span>
                              <form action={startSubjectPracticeAttempt.bind(null, subject.id, SESSION_SIZE)}>
                                <Button type="submit" size="sm" variant="outline" disabled={subject.topics.length === 0}>
                                  Practice →
                                </Button>
                              </form>
                            </div>
                          </div>

                          <Collapsible open={subjectOpen}>
                            <CollapsibleContent open={subjectOpen}>
                              <div className="space-y-1.5 px-3 pb-2.5 pl-8">
                                {subject.topics.length === 0 && (
                                  <p className="text-xs text-muted-foreground">No topics yet.</p>
                                )}
                                {subject.topics.map((topic) => {
                                  const topicOpen = isOpen(`topic:${topic.id}`);
                                  const topicStyle = statusStyle(topic.status);
                                  return (
                                    <div key={topic.id} className="rounded border border-border/50">
                                      <Collapsible open={topicOpen} onOpenChange={() => toggle(`topic:${topic.id}`)}>
                                        <CollapsibleTrigger className="flex w-full items-center gap-2 px-2.5 py-1.5 text-left">
                                          <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                          <span className="min-w-0 flex-1 truncate text-sm text-muted-foreground">
                                            {topic.name}
                                          </span>
                                          <span className={`shrink-0 text-sm font-medium ${topicStyle.text}`}>
                                            {topic.mastery !== null ? `${topic.mastery}%` : "—"}
                                          </span>
                                        </CollapsibleTrigger>

                                        <CollapsibleContent open={topicOpen}>
                                          <div className="space-y-2 px-2.5 pb-2.5 pl-6">
                                            {topic.status === "insufficient_data" ? (
                                              <p className="text-xs text-muted-foreground">
                                                Gathering data ({topic.totalAttempts}/{MIN_ATTEMPTS_FOR_MASTERY} answered)
                                              </p>
                                            ) : (
                                              <dl className="grid grid-cols-2 gap-x-4 gap-y-1 text-xs sm:grid-cols-4">
                                                <div>
                                                  <dt className="text-muted-foreground">Attempted</dt>
                                                  <dd className="font-medium">{topic.totalAttempts}</dd>
                                                </div>
                                                <div>
                                                  <dt className="text-muted-foreground">Accuracy</dt>
                                                  <dd className="font-medium">
                                                    {topic.overallAccuracy !== null ? `${topic.overallAccuracy}%` : "—"}
                                                  </dd>
                                                </div>
                                                <div>
                                                  <dt className="text-muted-foreground">Recent accuracy</dt>
                                                  <dd className="font-medium">
                                                    {topic.recentAccuracy !== null ? `${topic.recentAccuracy}%` : "—"}
                                                  </dd>
                                                </div>
                                                <div>
                                                  <dt className="text-muted-foreground">Mastery</dt>
                                                  <dd className={`font-medium ${topicStyle.text}`}>
                                                    {topic.mastery !== null ? `${topic.mastery}%` : "—"}
                                                  </dd>
                                                </div>
                                              </dl>
                                            )}
                                            <form action={startAdaptivePracticeAttempt.bind(null, topic.id, SESSION_SIZE)}>
                                              <Button type="submit" size="sm" variant="outline">
                                                Practice This Topic →
                                              </Button>
                                            </form>
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
                </CollapsibleContent>
              </Collapsible>
            </div>
          );
        })}
      </div>
    </div>
  );
}
