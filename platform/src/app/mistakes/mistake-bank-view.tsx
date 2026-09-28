"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { ChevronRight, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { TeachMeThis } from "@/components/teach-me-this";
import { startMistakeRetryAttempt, startAdaptivePracticeAttempt } from "../practice/actions";
import { getMistakeDetail, type MistakeDetail } from "./actions";

export type MistakeRow = {
  question_id: string;
  question_text: string;
  topic_id: string;
  topic_name: string;
  exam_area_id: string;
  exam_area_name: string;
  subject_id: string;
  subject_name: string;
  times_missed: number;
  last_answered_at: string;
  attempt_id: string;
};

const RETEST_SIZE = 15;

type SortMode = "recent" | "most_repeated";

function RetryButton({ questionIds, label }: { questionIds: string[]; label: string }) {
  const [isPending, setIsPending] = useState(false);
  return (
    <Button
      size="sm"
      variant="outline"
      disabled={isPending || questionIds.length === 0}
      onClick={() => {
        setIsPending(true);
        void startMistakeRetryAttempt(questionIds);
      }}
    >
      {isPending ? "Starting…" : label}
    </Button>
  );
}

/** Fresh, weighted question selection for the topic — deliberately NOT the
 * exact missed questions (that's RetryButton above). "Retest this topic"
 * per the spec: reuses startAdaptivePracticeAttempt's existing weighting
 * (missed 3x, unattempted 1.5x, correct 1x) rather than building a second
 * selection algorithm. */
function RetestButton({ topicId }: { topicId: string }) {
  const [isPending, setIsPending] = useState(false);
  return (
    <Button
      size="sm"
      disabled={isPending}
      onClick={() => {
        setIsPending(true);
        void startAdaptivePracticeAttempt(topicId, RETEST_SIZE);
      }}
    >
      {isPending ? "Starting…" : "Retest this topic →"}
    </Button>
  );
}

/** The "WHY YOU MISSED THIS" reveal — explanation + correct answer (free,
 * instant, via getMistakeDetail), then <TeachMeThis> as the optional
 * deeper AI layer on the same attempt/question pair. */
function MistakeDetailPanel({ row }: { row: MistakeRow }) {
  const [detail, setDetail] = useState<MistakeDetail | null | undefined>(undefined);

  useEffect(() => {
    let cancelled = false;
    getMistakeDetail(row.attempt_id, row.question_id).then((result) => {
      if (!cancelled) setDetail(result);
    });
    return () => {
      cancelled = true;
    };
  }, [row.attempt_id, row.question_id]);

  if (detail === undefined) {
    return <p className="px-3 py-3 text-xs text-muted-foreground">Loading…</p>;
  }

  if (detail === null) {
    return <p className="px-3 py-3 text-xs text-muted-foreground">Couldn&apos;t load this question&apos;s detail.</p>;
  }

  return (
    <div className="space-y-3 border-t border-destructive/20 px-3 py-3">
      {detail.choices.length > 0 && (
        <ul className="space-y-1">
          {detail.choices.map((c, i) => (
            <li
              key={i}
              className={`rounded-md px-2.5 py-1.5 text-sm ${
                c.is_correct ? "bg-success/10 font-medium text-success" : "text-muted-foreground"
              }`}
            >
              {c.is_correct && "✓ "}
              {c.text}
            </li>
          ))}
        </ul>
      )}
      {detail.explanation && (
        <div>
          <p className="text-xs font-semibold tracking-wide text-muted-foreground uppercase">Explanation</p>
          <p className="mt-1 text-sm text-foreground">{detail.explanation}</p>
        </div>
      )}
      <div className="flex flex-wrap items-center gap-3 pt-1">
        <Link
          href={`/reviewers?q=${encodeURIComponent(detail.topicName)}`}
          className="text-xs font-medium text-primary hover:underline"
        >
          Related material →
        </Link>
      </div>
      <TeachMeThis attemptId={row.attempt_id} questionId={row.question_id} />
    </div>
  );
}

export function MistakeBankView({
  rows,
  masteryByTopic,
}: {
  rows: MistakeRow[];
  masteryByTopic: Record<string, number | null>;
}) {
  const [areaId, setAreaId] = useState<string | null>(null);
  const [subjectId, setSubjectId] = useState<string | null>(null);
  const [topicId, setTopicId] = useState<string | null>(null);
  const [sortMode, setSortMode] = useState<SortMode>("recent");
  const [minMisses, setMinMisses] = useState(1);
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const areas = useMemo(() => {
    const map = new Map<string, { id: string; name: string; count: number }>();
    for (const r of rows) {
      const existing = map.get(r.exam_area_id);
      if (existing) existing.count += 1;
      else map.set(r.exam_area_id, { id: r.exam_area_id, name: r.exam_area_name, count: 1 });
    }
    return [...map.values()].sort((a, b) => b.count - a.count);
  }, [rows]);

  const subjectsInArea = useMemo(() => {
    if (!areaId) return [];
    const map = new Map<string, { id: string; name: string; count: number }>();
    for (const r of rows) {
      if (r.exam_area_id !== areaId) continue;
      const existing = map.get(r.subject_id);
      if (existing) existing.count += 1;
      else map.set(r.subject_id, { id: r.subject_id, name: r.subject_name, count: 1 });
    }
    return [...map.values()].sort((a, b) => b.count - a.count);
  }, [rows, areaId]);

  const topicsInSubject = useMemo(() => {
    if (!subjectId) return [];
    const map = new Map<string, { id: string; name: string; count: number }>();
    for (const r of rows) {
      if (r.subject_id !== subjectId) continue;
      const existing = map.get(r.topic_id);
      if (existing) existing.count += 1;
      else map.set(r.topic_id, { id: r.topic_id, name: r.topic_name, count: 1 });
    }
    return [...map.values()].sort((a, b) => b.count - a.count);
  }, [rows, subjectId]);

  const questionsInTopic = useMemo(() => {
    if (!topicId) return [];
    const filtered = rows.filter((r) => r.topic_id === topicId && r.times_missed >= minMisses);
    return filtered.sort((a, b) =>
      sortMode === "recent"
        ? new Date(b.last_answered_at).getTime() - new Date(a.last_answered_at).getTime()
        : b.times_missed - a.times_missed,
    );
  }, [rows, topicId, sortMode, minMisses]);

  if (rows.length === 0) {
    return (
      <p className="mt-8 text-sm text-muted-foreground">
        No mistakes on record right now — nice.
      </p>
    );
  }

  const selectedArea = areas.find((a) => a.id === areaId);
  const selectedSubject = subjectsInArea.find((s) => s.id === subjectId);
  const selectedTopic = topicsInSubject.find((t) => t.id === topicId);
  const selectedTopicMastery = topicId ? masteryByTopic[topicId] : null;

  return (
    <div className="mt-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <nav className="flex flex-wrap items-center gap-1.5 text-sm">
          <button
            type="button"
            onClick={() => {
              setAreaId(null);
              setSubjectId(null);
              setTopicId(null);
            }}
            className={areaId ? "text-muted-foreground hover:underline" : "font-medium"}
          >
            All Mistakes ({rows.length})
          </button>
          {selectedArea && (
            <>
              <span className="text-muted-foreground">/</span>
              <button
                type="button"
                onClick={() => {
                  setSubjectId(null);
                  setTopicId(null);
                }}
                className={subjectId ? "text-muted-foreground hover:underline" : "font-medium"}
              >
                {selectedArea.name}
              </button>
            </>
          )}
          {selectedSubject && (
            <>
              <span className="text-muted-foreground">/</span>
              <button
                type="button"
                onClick={() => setTopicId(null)}
                className={topicId ? "text-muted-foreground hover:underline" : "font-medium"}
              >
                {selectedSubject.name}
              </button>
            </>
          )}
          {selectedTopic && (
            <>
              <span className="text-muted-foreground">/</span>
              <span className="font-medium">{selectedTopic.name}</span>
            </>
          )}
        </nav>

        <RetryButton
          questionIds={
            topicId
              ? questionsInTopic.map((r) => r.question_id)
              : subjectId
                ? rows.filter((r) => r.subject_id === subjectId).map((r) => r.question_id)
                : areaId
                  ? rows.filter((r) => r.exam_area_id === areaId).map((r) => r.question_id)
                  : rows.map((r) => r.question_id)
          }
          label={`Practice My Mistakes${topicId || subjectId || areaId ? " (this view)" : ""} →`}
        />
      </div>

      {!areaId && (
        <div className="mt-4 space-y-2">
          {areas.map((a) => (
            <Card key={a.id}>
              <CardContent className="flex items-center justify-between gap-3 py-3">
                <button type="button" onClick={() => setAreaId(a.id)} className="text-left text-sm font-medium hover:underline">
                  {a.name}
                </button>
                <Badge variant="secondary">{a.count} mistake{a.count === 1 ? "" : "s"}</Badge>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {areaId && !subjectId && (
        <div className="mt-4 space-y-2">
          {subjectsInArea.map((s) => (
            <Card key={s.id}>
              <CardContent className="flex items-center justify-between gap-3 py-3">
                <button type="button" onClick={() => setSubjectId(s.id)} className="text-left text-sm font-medium hover:underline">
                  {s.name}
                </button>
                <Badge variant="secondary">{s.count} mistake{s.count === 1 ? "" : "s"}</Badge>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {subjectId && !topicId && (
        <div className="mt-4 space-y-2">
          {topicsInSubject.map((t) => (
            <Card key={t.id}>
              <CardContent className="flex items-center justify-between gap-3 py-3">
                <button type="button" onClick={() => setTopicId(t.id)} className="text-left text-sm font-medium hover:underline">
                  {t.name}
                </button>
                <Badge variant="secondary">{t.count} mistake{t.count === 1 ? "" : "s"}</Badge>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {topicId && (
        <>
          <div className="mt-4 flex flex-wrap items-center justify-between gap-3">
            <div className="flex flex-wrap items-center gap-3 text-xs">
              <span className="text-muted-foreground">Sort:</span>
              <button
                type="button"
                onClick={() => setSortMode("recent")}
                className={`rounded-full px-2.5 py-1 font-medium ${sortMode === "recent" ? "bg-primary text-primary-foreground" : "bg-muted text-muted-foreground"}`}
              >
                Most recent
              </button>
              <button
                type="button"
                onClick={() => setSortMode("most_repeated")}
                className={`rounded-full px-2.5 py-1 font-medium ${sortMode === "most_repeated" ? "bg-primary text-primary-foreground" : "bg-muted text-muted-foreground"}`}
              >
                Most repeated
              </button>
              <button
                type="button"
                onClick={() => setMinMisses(minMisses > 1 ? 1 : 2)}
                className={`rounded-full px-2.5 py-1 font-medium ${minMisses > 1 ? "bg-primary text-primary-foreground" : "bg-muted text-muted-foreground"}`}
              >
                Incorrect multiple times only
              </button>
            </div>
            <div className="flex items-center gap-2">
              {selectedTopicMastery !== null && selectedTopicMastery !== undefined && (
                <span className="text-xs text-muted-foreground">
                  Current mastery: <strong className="text-foreground">{selectedTopicMastery}%</strong>
                </span>
              )}
              <RetestButton topicId={topicId} />
            </div>
          </div>

          <div className="mt-3 space-y-2">
            {questionsInTopic.map((r) => {
              const isExpanded = expandedId === r.question_id;
              return (
                <Card key={r.question_id} className="border-l-4 border-l-destructive bg-destructive/5">
                  <button
                    type="button"
                    onClick={() => setExpandedId(isExpanded ? null : r.question_id)}
                    className="flex w-full items-center justify-between gap-3 px-4 py-3 text-left"
                  >
                    <div className="flex min-w-0 items-start gap-2">
                      <ChevronRight
                        className={`mt-0.5 size-3.5 shrink-0 text-muted-foreground transition-transform duration-200 ${isExpanded ? "rotate-90" : ""}`}
                      />
                      <div className="min-w-0">
                        <p className="text-sm">{r.question_text}</p>
                        <p className="mt-1 text-xs text-muted-foreground">
                          {new Date(r.last_answered_at).toLocaleDateString()}
                        </p>
                      </div>
                    </div>
                    <Badge className="shrink-0 bg-destructive text-white">missed {r.times_missed}×</Badge>
                  </button>
                  {isExpanded && (
                    <div className="px-1">
                      <div className="flex items-center gap-1.5 px-3 pb-2 text-xs font-medium text-primary">
                        <Sparkles className="size-3.5" />
                        Why you missed this
                      </div>
                      <MistakeDetailPanel row={r} />
                    </div>
                  )}
                </Card>
              );
            })}
            {questionsInTopic.length === 0 && (
              <p className="text-sm text-muted-foreground">No mistakes match this filter.</p>
            )}
          </div>
        </>
      )}
    </div>
  );
}
