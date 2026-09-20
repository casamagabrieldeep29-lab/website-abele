"use client";

import { useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { startMistakeRetryAttempt } from "../practice/actions";

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
};

type SortMode = "recent" | "most_repeated";

function RetryButton({ questionIds, label }: { questionIds: string[]; label: string }) {
  const [isPending, setIsPending] = useState(false);
  return (
    <Button
      size="sm"
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

export function MistakeBankView({ rows }: { rows: MistakeRow[] }) {
  const [areaId, setAreaId] = useState<string | null>(null);
  const [subjectId, setSubjectId] = useState<string | null>(null);
  const [topicId, setTopicId] = useState<string | null>(null);
  const [sortMode, setSortMode] = useState<SortMode>("recent");
  const [minMisses, setMinMisses] = useState(1);

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
          <div className="mt-4 flex flex-wrap items-center gap-3 text-xs">
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

          <div className="mt-3 space-y-2">
            {questionsInTopic.map((r) => (
              <Card key={r.question_id} className="border-l-4 border-l-destructive bg-destructive/5">
                <CardContent className="flex items-center justify-between gap-3 py-3">
                  <div>
                    <p className="text-sm">{r.question_text}</p>
                    <p className="mt-1 text-xs text-muted-foreground">
                      {new Date(r.last_answered_at).toLocaleDateString()}
                    </p>
                  </div>
                  <Badge className="shrink-0 bg-destructive text-white">missed {r.times_missed}×</Badge>
                </CardContent>
              </Card>
            ))}
            {questionsInTopic.length === 0 && (
              <p className="text-sm text-muted-foreground">No mistakes match this filter.</p>
            )}
          </div>
        </>
      )}
    </div>
  );
}
