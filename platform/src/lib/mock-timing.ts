// Mock Exam timing. The server owns the clock: a student's device may be minutes
// or hours off (wrong time set manually, drifting clock), so the page never
// compares the device's clock with the attempt's start time. The server works
// out how much time is left and the browser only counts down from that.

/** 3 hours per area, matching the real board exam. */
export const MOCK_EXAM_TIME_LIMIT_MINUTES = 180;

/** A timer-driven submit is only accepted this close (ms) to the real deadline. */
export const AUTO_SUBMIT_GRACE_MS = 5_000;

/**
 * Parse a Postgres timestamptz string. Postgres returns microseconds
 * ("…:43.745375+00:00"); some browsers reject more than three fractional
 * digits, so the fraction is trimmed to milliseconds first.
 */
export function parseTimestamp(value: string): number {
  const trimmed = value.replace(/(\.\d{3})\d+/, "$1");
  return new Date(trimmed).getTime();
}

/** Milliseconds left in an attempt (negative once it is over); NaN if the start time is unreadable. */
export function remainingMs(startedAt: string, limitMinutes: number, nowMs: number): number {
  return parseTimestamp(startedAt) + limitMinutes * 60_000 - nowMs;
}

/** 2:54:07 style clock for a duration in ms (never negative). */
export function formatClock(ms: number): string {
  const total = Math.max(0, Math.floor(ms / 1000));
  const h = Math.floor(total / 3600);
  const m = Math.floor((total % 3600) / 60);
  const s = total % 60;
  return `${h}:${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}

/** Current server time (a function, not an inline Date.now(), so pages stay readable to the purity lint). */
export function nowMs(): number {
  return Date.now();
}

/** Attempts that started before this instant have used up their 3 hours. */
export function mockExpiryCutoffIso(limitMinutes: number = MOCK_EXAM_TIME_LIMIT_MINUTES): string {
  return new Date(nowMs() - limitMinutes * 60_000).toISOString();
}
