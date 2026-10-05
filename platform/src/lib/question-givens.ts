/**
 * Content rule: a computation problem must state every given value in the
 * QUESTION itself. The solution/explanation may restate them ("Given: ..."),
 * but it must never be the only place the numbers appear — a student cannot
 * solve "the cost and benefit streams shown" if nothing is shown.
 *
 * Heuristic used by the admin editor warning and the seed-file test: an
 * explanation that opens with "Given" while the question text carries fewer
 * than two digits is missing its data. (Self-contained concept questions have
 * no "Given:" clause, so they are never flagged.)
 */
export function questionMissingGivens(questionText: string | null | undefined, explanation: string | null | undefined): boolean {
  if (!explanation || !/^\s*given\b/i.test(explanation)) return false;
  const digits = ((questionText ?? "").match(/\d/g) ?? []).length;
  return digits < 2;
}
