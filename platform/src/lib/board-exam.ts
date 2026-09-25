// The next PRC ABE Licensure Examination date — update this each cycle once
// PRC publishes the following year's schedule.
export const BOARD_EXAM_START = "2026-11-19";
export const BOARD_EXAM_END = "2026-11-20";
export const BOARD_EXAM_DATE_LABEL = "Nov 19–20, 2026";

/** Whole calendar days remaining, comparing date-only (midnight to midnight)
 * so the count only ever drops once per day rather than drifting with the
 * time of day it's viewed at. Negative once the exam has passed. */
export function daysUntilBoardExam(): number {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const examDay = new Date(`${BOARD_EXAM_START}T00:00:00`);
  return Math.round((examDay.getTime() - today.getTime()) / (24 * 60 * 60 * 1000));
}
