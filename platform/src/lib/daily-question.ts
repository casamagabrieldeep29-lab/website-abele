/**
 * Deterministically picks the same question for every user on a given day
 * (hash of the day-number over the published pool, stably ordered by id).
 * Shared between the dashboard preview and the startDailyQuestion action so
 * they can never disagree on "which question is today's."
 */
export function pickDailyQuestionId(orderedCandidateIds: string[]): string | null {
  if (orderedCandidateIds.length === 0) return null;
  const dayNumber = Math.floor(Date.now() / (1000 * 60 * 60 * 24));
  return orderedCandidateIds[dayNumber % orderedCandidateIds.length];
}

export function todayStartIso(): string {
  const d = new Date();
  d.setHours(0, 0, 0, 0);
  return d.toISOString();
}
