export type MockCandidate = {
  id: string;
  question_text?: string | null;
  is_paes?: boolean | null;
  paes_reference?: string | null;
  is_recalled?: boolean | null;
};

/** A question that tests a PAES/PNS standard's spec or test method rather than a board-style problem. */
export function isStandardsItem(c: MockCandidate): boolean {
  return Boolean(c.is_paes || c.paes_reference || /\b(PAES|PNS)\b/.test(c.question_text ?? ""));
}

// A real past board question is the most board-like item in the bank, so it
// gets drawn ahead of an ordinary question of the same kind.
const RECALLED_WEIGHT = 3;

function weightedOrder<T extends MockCandidate>(units: T[][], rng: () => number): T[][] {
  return units
    .map((u) => {
      const w = u.some((m) => m.is_recalled) ? RECALLED_WEIGHT : 1;
      return { u, key: Math.pow(rng(), 1 / w) };
    })
    .sort((a, b) => b.key - a.key)
    .map((x) => x.u);
}

function fill<T>(ordered: T[][], limit: number, into: T[]): T[][] {
  const left: T[][] = [];
  for (const unit of ordered) {
    if (into.length + unit.length <= limit || (into.length === 0 && limit > 0)) into.push(...unit);
    else left.push(unit);
  }
  return left;
}

/**
 * Picks one TOS subject's mock-exam items from its series-aware units.
 *
 * Standards-based items (PAES/PNS spec and test-method questions) are limited
 * to `maxStandardsShare` of the subject's target so the exam reads like a
 * board exam, not a standards quiz; the rest are board-style questions, with
 * recalled (actual past board) questions drawn ahead of ordinary ones. If the
 * board-style pool alone can't reach `target`, the shortfall is filled from
 * the standards items so the subject still hits its official item count. A
 * connected series is never split.
 */
export function pickSubjectItems<T extends MockCandidate>(
  units: T[][],
  target: number,
  maxStandardsShare: number,
  rng: () => number = Math.random,
): T[] {
  const boardUnits = units.filter((u) => !u.some(isStandardsItem));
  const standardsUnits = units.filter((u) => u.some(isStandardsItem));

  const standardsCap = Math.floor(target * maxStandardsShare);
  const standardsAvailable = standardsUnits.reduce((n, u) => n + u.length, 0);
  const standardsSlots = Math.min(standardsCap, standardsAvailable);

  const result: T[] = [];
  const boardLeft = fill(weightedOrder(boardUnits, rng), target - standardsSlots, result);
  const standardsLeft = fill(weightedOrder(standardsUnits, rng), Math.min(target, result.length + standardsSlots), result);

  // Board shortfall (rare): top up from whatever board units remain, then the
  // standards units, so the subject still reaches its official item count.
  if (result.length < target) fill(boardLeft, target, result);
  if (result.length < target) fill(standardsLeft, target, result);
  return result;
}
