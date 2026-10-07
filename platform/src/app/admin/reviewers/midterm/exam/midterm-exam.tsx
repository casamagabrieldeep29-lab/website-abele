"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { renderFormula } from "@/app/(app)/reviewers/reviewers-browser";
import { group, type MidtermRow } from "../midterm-data";
import {
  KIND_LABELS,
  availableCounts,
  buildExam,
  type ExamQuestion,
  type QuestionKind,
} from "./exam-generator";

const ALL_KINDS = Object.keys(KIND_LABELS) as QuestionKind[];
const LETTERS = ["A", "B", "C", "D"];
const PRESETS = [10, 20, 30, 50, 100];
const LABEL =
  "text-[11px] font-semibold uppercase tracking-wide text-muted-foreground";

type Phase = "setup" | "exam" | "result";

function formatTime(total: number): string {
  const m = Math.floor(total / 60);
  const s = total % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

export function MidtermExam({ rows }: { rows: MidtermRow[] }) {
  const sections = useMemo(() => group(rows), [rows]);
  const allKeys = useMemo(
    () => sections.flatMap((s) => s.topics.map((t) => t.key)),
    [sections],
  );

  const [phase, setPhase] = useState<Phase>("setup");
  const [selected, setSelected] = useState<Set<string>>(() => new Set());
  const [topicSearch, setTopicSearch] = useState("");
  const [kinds, setKinds] = useState<Set<QuestionKind>>(
    () => new Set(ALL_KINDS),
  );
  const [count, setCount] = useState(30);
  const [minutes, setMinutes] = useState(0);
  // reveal the correct answer and its explanation right after each question
  const [showAnswers, setShowAnswers] = useState(true);

  const [questions, setQuestions] = useState<ExamQuestion[]>([]);
  const [answers, setAnswers] = useState<Record<string, number>>({});
  const [index, setIndex] = useState(0);
  const [secondsLeft, setSecondsLeft] = useState<number | null>(null);
  const [wrongOnly, setWrongOnly] = useState(false);
  const deadline = useRef<number | null>(null);

  const tq = topicSearch.trim().toLowerCase();
  const shownSections = useMemo(
    () =>
      sections
        .map((s) => ({
          ...s,
          topics: s.topics.filter(
            (t) =>
              !tq ||
              t.topic.toLowerCase().includes(tq) ||
              s.section.toLowerCase().includes(tq),
          ),
        }))
        .filter((s) => s.topics.length > 0),
    [sections, tq],
  );
  const counts = useMemo(
    () => availableCounts(rows, selected),
    [rows, selected],
  );
  const usableKinds = ALL_KINDS.filter((k) => kinds.has(k) && counts[k] > 0);
  const poolSize = usableKinds.reduce((n, k) => n + counts[k], 0);

  function toggleTopic(key: string) {
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(key)) next.delete(key);
      else next.add(key);
      return next;
    });
  }
  function toggleSection(keys: string[], on: boolean) {
    setSelected((prev) => {
      const next = new Set(prev);
      keys.forEach((k) => (on ? next.add(k) : next.delete(k)));
      return next;
    });
  }
  function toggleKind(k: QuestionKind) {
    setKinds((prev) => {
      const next = new Set(prev);
      if (next.has(k)) next.delete(k);
      else next.add(k);
      return next;
    });
  }

  function start(list: ExamQuestion[]) {
    setQuestions(list);
    setAnswers({});
    setIndex(0);
    setWrongOnly(false);
    if (minutes > 0) {
      deadline.current = Date.now() + minutes * 60_000;
      setSecondsLeft(minutes * 60);
    } else {
      deadline.current = null;
      setSecondsLeft(null);
    }
    setPhase("exam");
    window.scrollTo({ top: 0 });
  }

  function generate() {
    const list = buildExam(rows, {
      topicKeys: selected,
      kinds: usableKinds,
      count: Math.max(1, Math.min(count, poolSize)),
    });
    if (list.length > 0) start(list);
  }

  function submit() {
    deadline.current = null;
    setPhase("result");
    window.scrollTo({ top: 0 });
  }

  // countdown
  useEffect(() => {
    if (phase !== "exam" || deadline.current === null) return;
    const id = setInterval(() => {
      const left = Math.max(
        0,
        Math.round(((deadline.current ?? 0) - Date.now()) / 1000),
      );
      setSecondsLeft(left);
      if (left === 0) {
        deadline.current = null;
        setPhase("result");
      }
    }, 500);
    return () => clearInterval(id);
  }, [phase]);

  // ---------------------------------------------------------------- setup
  if (phase === "setup") {
    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-xl font-bold text-foreground">
            Custom Midterm Exam
          </h1>
          <p className="mt-1 text-sm text-muted-foreground">
            Built only from the Midterm Reviewer. Pick the topics, the kinds of
            questions, how many items, and an optional time limit. Admin only;
            nothing is saved.
          </p>
        </div>

        <section>
          <div className="flex flex-wrap items-center justify-between gap-2">
            <p className={LABEL}>
              1. Topics ({selected.size} of {allKeys.length} selected)
            </p>
            <div className="flex gap-2 text-xs">
              <button
                type="button"
                className="text-primary hover:underline"
                onClick={() => setSelected(new Set(allKeys))}
              >
                Select all
              </button>
              <button
                type="button"
                className="text-primary hover:underline"
                onClick={() => setSelected(new Set())}
              >
                Clear
              </button>
            </div>
          </div>
          <input
            value={topicSearch}
            onChange={(e) => setTopicSearch(e.target.value)}
            placeholder="Find a topic…"
            className="mt-2 w-full max-w-sm rounded-md border border-border bg-background px-2 py-1.5 text-sm"
          />
          {selected.size > 0 && selected.size <= 6 && (
            <p className="mt-2 text-xs text-muted-foreground">
              Selected:{" "}
              {sections
                .flatMap((x) => x.topics)
                .filter((t) => selected.has(t.key))
                .map((t) => t.topic)
                .join(" · ")}
            </p>
          )}
          <div className="mt-2 space-y-2">
            {shownSections.map((s) => {
              const keys = s.topics.map((t) => t.key);
              const on = keys.filter((k) => selected.has(k)).length;
              return (
                <details
                  key={s.section}
                  open={topicSearch.trim() ? true : undefined}
                  className="rounded-lg border border-border"
                >
                  <summary className="flex cursor-pointer select-none items-center gap-2 rounded-lg bg-muted/40 px-3 py-2 text-sm font-semibold">
                    <input
                      type="checkbox"
                      checked={on === keys.length}
                      ref={(el) => {
                        if (el) el.indeterminate = on > 0 && on < keys.length;
                      }}
                      onClick={(e) => e.stopPropagation()}
                      onChange={(e) => toggleSection(keys, e.target.checked)}
                      aria-label={`Select all topics in ${s.section}`}
                    />
                    <span>{s.section}</span>
                    <span className="text-xs font-normal text-muted-foreground">
                      {on}/{keys.length} topics
                    </span>
                  </summary>
                  <div className="grid gap-1 p-3 sm:grid-cols-2">
                    {s.topics.map((t) => (
                      <label
                        key={t.key}
                        className="flex items-start gap-2 text-sm"
                      >
                        <input
                          type="checkbox"
                          className="mt-1"
                          checked={selected.has(t.key)}
                          onChange={() => toggleTopic(t.key)}
                        />
                        <span>{t.topic}</span>
                      </label>
                    ))}
                  </div>
                </details>
              );
            })}
          </div>
        </section>

        <section>
          <p className={LABEL}>2. Question types</p>
          <div className="mt-2 grid gap-2 sm:grid-cols-2">
            {ALL_KINDS.map((k) => (
              <label
                key={k}
                className={`flex items-center gap-2 rounded-md border border-border px-3 py-2 text-sm ${counts[k] === 0 ? "opacity-50" : ""}`}
              >
                <input
                  type="checkbox"
                  checked={kinds.has(k) && counts[k] > 0}
                  disabled={counts[k] === 0}
                  onChange={() => toggleKind(k)}
                />
                <span className="font-medium">{KIND_LABELS[k]}</span>
                <span className="ml-auto text-xs text-muted-foreground">
                  {counts[k]} available
                </span>
              </label>
            ))}
          </div>
        </section>

        <section className="grid gap-4 sm:grid-cols-2">
          <div>
            <p className={LABEL}>3. Number of questions</p>
            <div className="mt-2 flex flex-wrap items-center gap-2">
              {PRESETS.map((n) => (
                <button
                  key={n}
                  type="button"
                  onClick={() => setCount(n)}
                  className={`rounded-md border px-3 py-1 text-sm ${count === n ? "border-primary bg-primary/10 font-semibold text-primary" : "border-border"}`}
                >
                  {n}
                </button>
              ))}
              <input
                type="number"
                min={1}
                max={Math.max(1, poolSize)}
                value={count}
                onChange={(e) =>
                  setCount(Math.max(1, Number(e.target.value) || 1))
                }
                className="w-20 rounded-md border border-border bg-background px-2 py-1 text-sm"
                aria-label="Number of questions"
              />
            </div>
            <p className="mt-1 text-xs text-muted-foreground">
              Up to {poolSize} possible with the current selection.
            </p>
          </div>
          <div>
            <p className={LABEL}>4. Time limit (minutes, 0 = none)</p>
            <div className="mt-2 flex flex-wrap items-center gap-2">
              {[0, 15, 30, 60, 90].map((m) => (
                <button
                  key={m}
                  type="button"
                  onClick={() => setMinutes(m)}
                  className={`rounded-md border px-3 py-1 text-sm ${minutes === m ? "border-primary bg-primary/10 font-semibold text-primary" : "border-border"}`}
                >
                  {m === 0 ? "None" : m}
                </button>
              ))}
              <input
                type="number"
                min={0}
                value={minutes}
                onChange={(e) =>
                  setMinutes(Math.max(0, Number(e.target.value) || 0))
                }
                className="w-20 rounded-md border border-border bg-background px-2 py-1 text-sm"
                aria-label="Time limit in minutes"
              />
            </div>
          </div>
        </section>

        <label className="flex items-start gap-2 rounded-md border border-border px-3 py-2 text-sm">
          <input
            type="checkbox"
            className="mt-1"
            checked={showAnswers}
            onChange={(e) => setShowAnswers(e.target.checked)}
          />
          <span>
            <span className="font-medium">
              Show the answer after each question
            </span>
            <span className="block text-xs text-muted-foreground">
              The correct choice and its explanation appear as soon as you
              answer, and that answer is locked.
            </span>
          </span>
        </label>

        <div className="flex items-center gap-3">
          <Button
            onClick={generate}
            disabled={poolSize === 0 || usableKinds.length === 0}
          >
            Start exam ({Math.min(count, poolSize)} questions)
          </Button>
          {poolSize === 0 && (
            <p className="text-sm text-destructive">
              Select at least one topic with enough content.
            </p>
          )}
        </div>
      </div>
    );
  }

  // ---------------------------------------------------------------- exam
  if (phase === "exam") {
    const q = questions[index];
    const answered = Object.keys(answers).length;
    const mine = answers[q.id];
    const revealed = showAnswers && mine !== undefined;
    const isLast = index === questions.length - 1;
    return (
      <div className="space-y-4">
        <div className="sticky top-0 z-10 flex flex-wrap items-center justify-between gap-2 border-b bg-background/95 py-2 backdrop-blur">
          <p className="text-sm font-semibold">
            Question {index + 1} of {questions.length} · {answered} answered
          </p>
          {secondsLeft !== null && (
            <p
              className={`font-mono text-sm font-semibold ${secondsLeft <= 60 ? "text-destructive" : "text-foreground"}`}
            >
              ⏱ {formatTime(secondsLeft)}
            </p>
          )}
        </div>

        <div className="flex flex-wrap gap-1">
          {questions.map((x, i) => (
            <button
              key={x.id}
              type="button"
              onClick={() => setIndex(i)}
              className={`h-7 w-7 rounded text-xs ${i === index ? "bg-primary text-primary-foreground" : answers[x.id] === undefined ? "border border-border text-muted-foreground" : showAnswers ? (answers[x.id] === x.correct ? "bg-success/30 text-foreground" : "bg-destructive/30 text-foreground") : "bg-primary/20 text-foreground"}`}
              aria-label={`Go to question ${i + 1}`}
            >
              {i + 1}
            </button>
          ))}
        </div>

        <div className="rounded-lg border border-border bg-card p-4">
          <p className="text-xs text-muted-foreground">
            {KIND_LABELS[q.kind]} · {q.topic}
          </p>
          <p className="mt-1.5 text-base leading-relaxed font-medium text-foreground">
            {renderFormula(q.prompt)}
          </p>
          <div className="mt-3 space-y-2">
            {q.choices.map((c, i) => (
              <button
                key={i}
                type="button"
                disabled={revealed}
                onClick={() => setAnswers((a) => ({ ...a, [q.id]: i }))}
                className={`flex w-full items-start gap-2 rounded-md border px-3 py-2 text-left text-sm ${
                  revealed
                    ? i === q.correct
                      ? "border-success bg-success/15 font-semibold"
                      : i === mine
                        ? "border-destructive bg-destructive/15"
                        : "border-border opacity-60"
                    : mine === i
                      ? "border-primary bg-primary/10"
                      : "border-border hover:bg-muted/50"
                }`}
              >
                <span className="font-semibold">{LETTERS[i]}.</span>
                <span className={q.kind === "formula" ? "font-mono" : ""}>
                  {renderFormula(c)}
                </span>
                {revealed && i === q.correct && (
                  <span className="ml-auto">✓</span>
                )}
                {revealed && i === mine && i !== q.correct && (
                  <span className="ml-auto">✗</span>
                )}
              </button>
            ))}
          </div>
          {revealed && (
            <div
              className={`mt-3 rounded-md border px-3 py-2 text-sm ${mine === q.correct ? "border-success/40 bg-success/10" : "border-destructive/40 bg-destructive/10"}`}
            >
              <p className="font-semibold">
                {mine === q.correct
                  ? "Correct!"
                  : `Not quite. The answer is ${LETTERS[q.correct]}.`}
              </p>
              <div className="mt-1 space-y-0.5 text-xs leading-relaxed text-muted-foreground">
                {q.explain.map((l, li) => (
                  <p key={li}>{renderFormula(l)}</p>
                ))}
              </div>
            </div>
          )}
        </div>

        <div className="flex flex-wrap items-center justify-between gap-2">
          <Button
            variant="secondary"
            disabled={index === 0}
            onClick={() => setIndex((i) => i - 1)}
          >
            ← Previous
          </Button>
          <div className="flex gap-2">
            {!isLast ? (
              <Button onClick={() => setIndex((i) => i + 1)}>Next →</Button>
            ) : null}
            <Button
              variant={isLast ? "default" : "secondary"}
              onClick={() => {
                const left = questions.length - answered;
                if (
                  left === 0 ||
                  window.confirm(
                    `${left} question${left === 1 ? " is" : "s are"} unanswered. Submit anyway?`,
                  )
                )
                  submit();
              }}
            >
              Submit exam
            </Button>
          </div>
        </div>
      </div>
    );
  }

  // ---------------------------------------------------------------- result
  const correctCount = questions.filter(
    (q) => answers[q.id] === q.correct,
  ).length;
  const pct = questions.length
    ? Math.round((correctCount / questions.length) * 100)
    : 0;
  const breakdown = (key: (q: ExamQuestion) => string) => {
    const m = new Map<string, { right: number; total: number }>();
    for (const q of questions) {
      const k = key(q);
      const e = m.get(k) ?? { right: 0, total: 0 };
      e.total++;
      if (answers[q.id] === q.correct) e.right++;
      m.set(k, e);
    }
    return [...m.entries()].sort(
      (a, b) => a[1].right / a[1].total - b[1].right / b[1].total,
    );
  };
  const shown = questions
    .map((q, i) => ({ q, i }))
    .filter(({ q }) => !wrongOnly || answers[q.id] !== q.correct);

  return (
    <div className="space-y-6">
      <div className="rounded-lg border border-border bg-card p-5 text-center">
        <p className={LABEL}>Your score</p>
        <p
          className={`mt-1 text-4xl font-bold ${pct >= 75 ? "text-success" : pct >= 50 ? "text-foreground" : "text-destructive"}`}
        >
          {correctCount} / {questions.length}{" "}
          <span className="text-2xl">({pct}%)</span>
        </p>
        <div className="mt-4 flex flex-wrap justify-center gap-2">
          <Button onClick={() => start(questions)}>Retake same exam</Button>
          <Button
            variant="secondary"
            disabled={correctCount === questions.length}
            onClick={() =>
              start(questions.filter((q) => answers[q.id] !== q.correct))
            }
          >
            Retry missed only
          </Button>
          <Button variant="secondary" onClick={() => setPhase("setup")}>
            New exam
          </Button>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        <div>
          <p className={LABEL}>Weakest sections first</p>
          <ul className="mt-1.5 space-y-1 text-sm">
            {breakdown((q) => q.section).map(([name, v]) => (
              <li key={name} className="flex justify-between gap-3">
                <span>{name}</span>
                <span className="font-mono text-muted-foreground">
                  {v.right}/{v.total}
                </span>
              </li>
            ))}
          </ul>
        </div>
        <div>
          <p className={LABEL}>By question type</p>
          <ul className="mt-1.5 space-y-1 text-sm">
            {breakdown((q) => KIND_LABELS[q.kind]).map(([name, v]) => (
              <li key={name} className="flex justify-between gap-3">
                <span>{name}</span>
                <span className="font-mono text-muted-foreground">
                  {v.right}/{v.total}
                </span>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <div>
        <div className="flex items-center justify-between">
          <p className={LABEL}>Review</p>
          <label className="flex items-center gap-2 text-sm">
            <input
              type="checkbox"
              checked={wrongOnly}
              onChange={(e) => setWrongOnly(e.target.checked)}
            />
            Show missed only
          </label>
        </div>
        <div className="mt-2 space-y-3">
          {shown.map(({ q, i }) => {
            const mine = answers[q.id];
            const ok = mine === q.correct;
            return (
              <div
                key={q.id}
                className={`rounded-lg border p-3 ${ok ? "border-success/40" : "border-destructive/40"}`}
              >
                <p className="text-xs text-muted-foreground">
                  {i + 1}. {KIND_LABELS[q.kind]} · {q.topic} ·{" "}
                  {ok
                    ? "Correct"
                    : mine === undefined
                      ? "Not answered"
                      : "Wrong"}
                </p>
                <p className="mt-1 text-sm font-medium">
                  {renderFormula(q.prompt)}
                </p>
                <ul className="mt-2 space-y-1 text-sm">
                  {q.choices.map((c, ci) => (
                    <li
                      key={ci}
                      className={`rounded px-2 py-1 ${ci === q.correct ? "bg-success/15 font-semibold" : ci === mine ? "bg-destructive/15" : ""}`}
                    >
                      {LETTERS[ci]}.{" "}
                      <span className={q.kind === "formula" ? "font-mono" : ""}>
                        {renderFormula(c)}
                      </span>
                      {ci === q.correct
                        ? "  ✓"
                        : ci === mine
                          ? "  (your answer)"
                          : ""}
                    </li>
                  ))}
                </ul>
                <div className="mt-2 rounded-md bg-muted/40 px-3 py-2 text-xs leading-relaxed text-muted-foreground">
                  {q.explain.map((l, li) => (
                    <p key={li}>{renderFormula(l)}</p>
                  ))}
                </div>
              </div>
            );
          })}
          {shown.length === 0 && (
            <p className="text-sm text-muted-foreground">Nothing missed. 🎉</p>
          )}
        </div>
      </div>
    </div>
  );
}
