// The next PRC ABE Licensure Examination date — update this each cycle once
// PRC publishes the following year's schedule.
export const BOARD_EXAM_START = "2026-11-19";
export const BOARD_EXAM_END = "2026-11-20";
export const BOARD_EXAM_DATE_LABEL = "Nov 19–20, 2026";

/** "Today" as a YYYY-MM-DD calendar date in Philippine time (UTC+8), not the
 * server's own timezone — this runs server-side on Vercel, which is UTC, so
 * without this the countdown could read a day off depending on the time of
 * day it's requested at. */
function todayInManila(): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Manila" }).format(new Date());
}

/** Whole calendar days remaining, comparing date-only (midnight to midnight,
 * Philippine time) so the count only ever drops once per day rather than
 * drifting with the time of day it's viewed at. Negative once the exam has
 * passed. */
export function daysUntilBoardExam(): number {
  const today = new Date(`${todayInManila()}T00:00:00Z`);
  const examDay = new Date(`${BOARD_EXAM_START}T00:00:00Z`);
  return Math.round((examDay.getTime() - today.getTime()) / (24 * 60 * 60 * 1000));
}
