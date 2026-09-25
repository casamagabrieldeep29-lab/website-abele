"use client";

import { useEffect, useState } from "react";

/**
 * Countdown hook adapted from the Mock Exam session's inline timer
 * (mock-exam-session.tsx lines ~56-97: a deadline established once, ticked
 * down every second via setInterval+cleanup, firing a callback at zero).
 * Not wired into mock-exam-session.tsx itself — that timer already works
 * for a single whole-exam deadline, and changing it wasn't needed here.
 *
 * `durationSeconds: null` disables the timer (used for untimed PAES
 * modes) and this always returns `null` in that case.
 *
 * The deadline is computed once via a lazy useState initializer — same
 * spot mock-exam-session calls `Date.now()` from (`useState(() => deadline
 * - Date.now())`) — rather than in useMemo/render, which React's
 * hook-purity lint rule disallows calling impure functions from. Every
 * later tick's `Date.now()` call happens inside the interval callback,
 * also matching the existing pattern.
 *
 * Because the deadline is fixed for the component instance's lifetime,
 * restarting the clock for a new question means mounting a fresh instance
 * — the caller renders whatever holds this hook with `key={questionIndex}`
 * (see PaesQuizSession's <QuestionTimer key={index}>) so React's own
 * remount/reinitialize behavior does the resetting, instead of this hook
 * reaching for `Date.now()` again mid-render.
 */
export function useCountdown(durationSeconds: number | null, onExpire: () => void): number | null {
  const [deadline] = useState<number | null>(() =>
    durationSeconds === null ? null : Date.now() + durationSeconds * 1000,
  );
  const [remainingMs, setRemainingMs] = useState<number | null>(() =>
    deadline === null ? null : deadline - Date.now(),
  );

  useEffect(() => {
    if (deadline === null) return;
    const interval = setInterval(() => {
      const remaining = deadline - Date.now();
      setRemainingMs(remaining);
      if (remaining <= 0) {
        clearInterval(interval);
        onExpire();
      }
    }, 1000);
    return () => clearInterval(interval);
  }, [deadline, onExpire]);

  return remainingMs;
}
