"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { ChevronRight, Search } from "lucide-react";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { startAdaptivePracticeAttempt, startSubtopicPracticeAttempt } from "@/app/practice/actions";
import { startFlashcardsByTopic } from "@/app/flashcards/actions";
import { getHarmonizedAccent } from "@/lib/harmonized-accents";
import { getSubtopicQuestions, type QuestionBankQuestion } from "./actions";

const SESSION_SIZE = 20;
const MAX_WEIGHT_PERCENT = 18;

export type QuestionBankTopic = {
  id: string;
  name: string;
  questionCount: number;
};

export type QuestionBankSubject = {
  id: string;
  name: string;
  questionCount: number;
  topics: QuestionBankTopic[];
};

// The official PRC TOS subject (supabase/patches/013_official_subjects.sql)
// — sits between the TOS area and the existing topics-table "Subject"
// level below, which is otherwise unchanged from the original Question
// Bank redesign (same ids, same Practice/Flashcards/Reviewers actions).
export type QuestionBankOfficialSubject = {
  id: string;
  name: string;
  subjects: QuestionBankSubject[];
};

export type QuestionBankArea = {
  id: string;
  name: string;
  weightPercent: number | null;
  officialSubjects: QuestionBankOfficialSubject[];
};

function matchesQuery(name: string, query: string) {
  return name.toLowerCase().includes(query);
}

/** A deep-link target from the global search: which single row to scroll to
 * and briefly flash, once its ancestors are already open (see
 * `initialOpenIds`, computed server-side in page.tsx from the same ids). */
export type QuestionBankHighlight = {
  kind: "area" | "os" | "topic" | "subtopic" | "question";
  targetId: string;
} | null;

const FLASH_DURATION_MS = 2500;

export function QuestionBankBrowser({
  areas,
  initialOpenIds,
  highlight = null,
}: {
  areas: QuestionBankArea[];
  initialOpenIds?: string[];
  highlight?: QuestionBankHighlight;
}) {
  const [openIds, setOpenIds] = useState<Set<string>>(() => new Set(initialOpenIds));
  const [flashKey, setFlashKey] = useState<string | null>(
    highlight && highlight.kind !== "question" ? `${highlight.kind}-${highlight.targetId}` : null,
  );
  const [rawQuery, setRawQuery] = useState("");
  const query = rawQuery.trim().toLowerCase();
  const isSearching = query.length > 0;

  const allIds = useMemo(() => {
    const ids: string[] = [];
    for (const area of areas) {
      ids.push(`a:${area.id}`);
      for (const officialSubject of area.officialSubjects) {
        ids.push(`os:${officialSubject.id}`);
        for (const subject of officialSubject.subjects) {
          ids.push(`s:${subject.id}`);
          for (const topic of subject.topics) ids.push(`t:${topic.id}`);
        }
      }
    }
    return ids;
  }, [areas]);

  const { filteredAreas, forceOpenIds } = useMemo(() => {
    if (!isSearching) return { filteredAreas: areas, forceOpenIds: new Set<string>() };

    const openSet = new Set<string>();
    const result: QuestionBankArea[] = [];

    for (const area of areas) {
      const areaMatches = matchesQuery(area.name, query);
      let officialSubjects: QuestionBankOfficialSubject[];

      if (areaMatches) {
        officialSubjects = area.officialSubjects;
      } else {
        officialSubjects = area.officialSubjects
          .map((officialSubject) => {
            const officialSubjectMatches = matchesQuery(officialSubject.name, query);
            let subjects: QuestionBankSubject[];

            if (officialSubjectMatches) {
              subjects = officialSubject.subjects;
            } else {
              subjects = officialSubject.subjects
                .map((subject) => {
                  const subjectMatches = matchesQuery(subject.name, query);
                  const topics = subjectMatches
                    ? subject.topics
                    : subject.topics.filter((t) => matchesQuery(t.name, query));
                  if (!subjectMatches && topics.length === 0) return null;
                  return { ...subject, topics };
                })
                .filter((s): s is QuestionBankSubject => s !== null);
            }

            if (!officialSubjectMatches && subjects.length === 0) return null;
            return { ...officialSubject, subjects };
          })
          .filter((os): os is QuestionBankOfficialSubject => os !== null);
      }

      if (!areaMatches && officialSubjects.length === 0) continue;

      openSet.add(`a:${area.id}`);
      for (const officialSubject of officialSubjects) {
        openSet.add(`os:${officialSubject.id}`);
        for (const subject of officialSubject.subjects) {
          openSet.add(`s:${subject.id}`);
          for (const topic of subject.topics) openSet.add(`t:${topic.id}`);
        }
      }
      result.push({ ...area, officialSubjects });
    }

    return { filteredAreas: result, forceOpenIds: openSet };
  }, [areas, query, isSearching]);

  // Non-question highlights (area/subject/topic) are always mounted, so
  // scroll to them as soon as their ancestors are open. A "question"
  // highlight instead waits on TopicQuestions below — it only exists in the
  // DOM once that row's question list has actually loaded.
  useEffect(() => {
    if (!highlight || highlight.kind === "question") return;
    const el = document.getElementById(`qb-${highlight.kind}-${highlight.targetId}`);
    el?.scrollIntoView({ behavior: "smooth", block: "center" });
    const t = setTimeout(() => setFlashKey(null), FLASH_DURATION_MS);
    return () => clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  function isOpen(id: string) {
    return isSearching ? forceOpenIds.has(id) : openIds.has(id);
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
    setRawQuery("");
    setOpenIds(new Set(allIds));
  }

  function collapseAll() {
    setRawQuery("");
    setOpenIds(new Set());
  }

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center gap-2">
        <div className="relative min-w-0 flex-1">
          <Search className="pointer-events-none absolute top-1/2 left-2.5 size-3.5 -translate-y-1/2 text-muted-foreground" />
          <Input
            value={rawQuery}
            onChange={(e) => setRawQuery(e.target.value)}
            placeholder="Search TOS areas, subjects, or topics…"
            className="pl-8"
          />
        </div>
        <div className="flex shrink-0 gap-2">
          <Button type="button" size="sm" variant="outline" onClick={expandAll}>
            Expand All
          </Button>
          <Button type="button" size="sm" variant="outline" onClick={collapseAll}>
            Collapse All
          </Button>
        </div>
      </div>

      {isSearching && filteredAreas.length === 0 && (
        <p className="rounded-md border border-dashed border-border py-6 text-center text-sm text-muted-foreground">
          No TOS areas, subjects, or topics match &ldquo;{rawQuery.trim()}&rdquo;.
        </p>
      )}

      <div className="space-y-3">
        {filteredAreas.map((area) => {
          const accent = getHarmonizedAccent(area.name);
          const areaOpen = isOpen(`a:${area.id}`);
          const pct = area.weightPercent ?? 0;

          const areaFlashing = flashKey === `area-${area.id}`;
          return (
            <div
              key={area.id}
              id={`qb-area-${area.id}`}
              className={`rounded-lg border-l-4 border border-border/60 ${accent.border} ${accent.bg} ${areaFlashing ? "ring-2 ring-primary/60 transition-shadow duration-500" : ""}`}
            >
              <Collapsible open={areaOpen} onOpenChange={() => toggle(`a:${area.id}`)}>
                <CollapsibleTrigger className="flex w-full items-center gap-3 px-3.5 py-3.5 text-left transition-colors hover:bg-background/40">
                  <ChevronRight className="size-4 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                  <div className="min-w-0 flex-1">
                    <p className="text-base font-semibold break-words">{area.name}</p>
                    <div className="mt-1.5 h-1 w-full max-w-40 overflow-hidden rounded-full bg-background/60">
                      <div
                        className="h-full rounded-full bg-primary"
                        style={{ width: `${Math.min(100, (pct / MAX_WEIGHT_PERCENT) * 100)}%` }}
                      />
                    </div>
                  </div>
                  {area.weightPercent !== null && (
                    <Badge variant="secondary" className="shrink-0">
                      {area.weightPercent}%
                    </Badge>
                  )}
                </CollapsibleTrigger>

                <CollapsibleContent open={areaOpen}>
                  <div className="space-y-2 px-3 pb-3">
                    {area.officialSubjects.length === 0 && (
                      <p className="pl-7 text-xs text-muted-foreground">No subjects yet.</p>
                    )}
                    {area.officialSubjects.map((officialSubject) => {
                      const officialSubjectOpen = isOpen(`os:${officialSubject.id}`);
                      const osFlashing = flashKey === `os-${officialSubject.id}`;
                      return (
                        <div
                          key={officialSubject.id}
                          id={`qb-os-${officialSubject.id}`}
                          className={`border-b border-border/40 last:border-b-0 ${osFlashing ? "rounded-md ring-2 ring-primary/60 transition-shadow duration-500" : ""}`}
                        >
                          <Collapsible
                            open={officialSubjectOpen}
                            onOpenChange={() => toggle(`os:${officialSubject.id}`)}
                          >
                            <CollapsibleTrigger className="flex w-full items-center gap-2 rounded-md px-3 py-2 text-left transition-colors hover:bg-background/40">
                              <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                              <span className="min-w-0 flex-1 text-sm font-semibold break-words">{officialSubject.name}</span>
                            </CollapsibleTrigger>

                            <CollapsibleContent open={officialSubjectOpen}>
                              <div className="space-y-2 px-3 pb-2.5 pl-6">
                                {officialSubject.subjects.length === 0 && (
                                  <p className="text-xs text-muted-foreground">No topics yet.</p>
                                )}
                                {officialSubject.subjects.map((subject) => {
                                  const subjectOpen = isOpen(`s:${subject.id}`);
                                  const topicFlashing = flashKey === `topic-${subject.id}`;
                                  return (
                                    <div
                                      key={subject.id}
                                      id={`qb-topic-${subject.id}`}
                                      className={`border-b border-border/30 last:border-b-0 ${topicFlashing ? "rounded-md ring-2 ring-primary/60 transition-shadow duration-500" : ""}`}
                                    >
                                      <div className="flex flex-wrap items-center justify-between gap-2 rounded-md px-3 py-2 transition-colors hover:bg-background/40">
                                        <Collapsible
                                          open={subjectOpen}
                                          onOpenChange={() => toggle(`s:${subject.id}`)}
                                          className="min-w-0 flex-1"
                                        >
                                          <CollapsibleTrigger className="flex w-full min-w-0 items-center gap-2 text-left">
                                            <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                            <span className="min-w-0 flex-1 text-sm font-medium break-words">{subject.name}</span>
                                          </CollapsibleTrigger>
                                        </Collapsible>
                                        <div className="flex shrink-0 flex-wrap items-center gap-1.5">
                                          <form action={startAdaptivePracticeAttempt.bind(null, subject.id, SESSION_SIZE)}>
                                            <Button type="submit" size="sm" variant="outline" disabled={subject.questionCount === 0}>
                                              Practice →
                                            </Button>
                                          </form>
                                          <form action={startFlashcardsByTopic.bind(null, subject.id)}>
                                            <Button type="submit" size="sm" variant="ghost">
                                              Flashcards →
                                            </Button>
                                          </form>
                                          <Button
                                            render={<Link href={`/reviewers?q=${encodeURIComponent(subject.name)}`}>Reviewers →</Link>}
                                            nativeButton={false}
                                            size="sm"
                                            variant="ghost"
                                          />
                                        </div>
                                      </div>

                                      <Collapsible open={subjectOpen}>
                                        <CollapsibleContent open={subjectOpen}>
                                          <div className="space-y-1.5 px-3 pb-2.5 pl-8">
                                            {subject.topics.length === 0 && (
                                              <p className="text-xs text-muted-foreground">No topics yet.</p>
                                            )}
                                            {subject.topics.map((topic) => {
                                              const topicOpen = isOpen(`t:${topic.id}`);
                                              const subtopicFlashing = flashKey === `subtopic-${topic.id}`;
                                              return (
                                                <div
                                                  key={topic.id}
                                                  id={`qb-subtopic-${topic.id}`}
                                                  className={`border-b border-border/20 last:border-b-0 ${subtopicFlashing ? "rounded-md ring-2 ring-primary/60 transition-shadow duration-500" : ""}`}
                                                >
                                                  <div className="flex flex-wrap items-center justify-between gap-2 rounded px-2.5 py-1.5 transition-colors hover:bg-background/30">
                                                    <Collapsible
                                                      open={topicOpen}
                                                      onOpenChange={() => toggle(`t:${topic.id}`)}
                                                      className="min-w-0 flex-1"
                                                    >
                                                      <CollapsibleTrigger className="flex w-full min-w-0 items-center gap-2 text-left">
                                                        <ChevronRight className="size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 group-data-open:rotate-90" />
                                                        <span className="min-w-0 flex-1 truncate text-sm text-muted-foreground">
                                                          {topic.name}
                                                        </span>
                                                      </CollapsibleTrigger>
                                                    </Collapsible>
                                                    <div className="flex shrink-0 items-center gap-1.5">
                                                      <form action={startSubtopicPracticeAttempt.bind(null, topic.id, SESSION_SIZE)}>
                                                        <Button type="submit" size="sm" variant="ghost" disabled={topic.questionCount === 0}>
                                                          Practice →
                                                        </Button>
                                                      </form>
                                                    </div>
                                                  </div>

                                                  <Collapsible open={topicOpen}>
                                                    <CollapsibleContent open={topicOpen} keepMounted>
                                                      <div className="px-2.5 pb-2 pl-6">
                                                        <TopicQuestions
                                                          subtopicId={topic.id}
                                                          isOpen={topicOpen}
                                                          highlightQuestionId={
                                                            highlight?.kind === "question" ? highlight.targetId : null
                                                          }
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

function TopicQuestions({
  subtopicId,
  isOpen,
  highlightQuestionId,
}: {
  subtopicId: string;
  isOpen: boolean;
  highlightQuestionId?: string | null;
}) {
  const [questions, setQuestions] = useState<QuestionBankQuestion[] | null>(null);
  const [flashing, setFlashing] = useState(Boolean(highlightQuestionId));

  useEffect(() => {
    if (!isOpen || questions !== null) return;
    let cancelled = false;
    getSubtopicQuestions(subtopicId).then((result) => {
      if (!cancelled) setQuestions(result);
    });
    return () => {
      cancelled = true;
    };
  }, [isOpen, questions, subtopicId]);

  // The target <li> only exists once this subtopic's questions have
  // actually loaded — scroll/flash here instead of in the parent's
  // mount-time effect, which runs before this fetch resolves.
  useEffect(() => {
    if (!highlightQuestionId || !questions) return;
    if (!questions.some((q) => q.id === highlightQuestionId)) return;
    const el = document.getElementById(`qb-question-${highlightQuestionId}`);
    el?.scrollIntoView({ behavior: "smooth", block: "center" });
    const t = setTimeout(() => setFlashing(false), FLASH_DURATION_MS);
    return () => clearTimeout(t);
  }, [highlightQuestionId, questions]);

  if (!isOpen && questions === null) return null;
  if (questions === null) {
    return <p className="py-1.5 text-xs text-muted-foreground">Loading questions…</p>;
  }
  if (questions.length === 0) {
    return <p className="py-1.5 text-xs text-muted-foreground">No questions yet.</p>;
  }

  return (
    <ol className="space-y-1 py-1.5">
      {questions.map((q, i) => (
        <li
          key={q.id}
          id={`qb-question-${q.id}`}
          className={`flex gap-2 rounded px-1 py-0.5 text-sm text-muted-foreground ${
            flashing && q.id === highlightQuestionId ? "ring-2 ring-primary/60 transition-shadow duration-500" : ""
          }`}
        >
          <span className="shrink-0 tabular-nums">{i + 1}.</span>
          <span className="line-clamp-2">{q.question_text}</span>
        </li>
      ))}
    </ol>
  );
}
