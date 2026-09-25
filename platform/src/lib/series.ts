import "server-only";
import type { SupabaseClient } from "@supabase/supabase-js";
import { fetchAllRows } from "@/lib/supabase/paginate";

export type SeriesCandidate = {
  id: string;
  series_key: string | null;
  series_position: number | null;
};

/**
 * Groups candidate questions into "units": a standalone question (no
 * series_key) is its own unit; every question sharing the same non-null
 * series_key becomes ONE unit, internally ordered by series_position. A
 * shuffle or weighted sample that operates on these units instead of raw
 * question ids can never split a connected series apart or scramble its
 * internal order, because the whole unit moves or gets picked together.
 */
export function groupIntoUnits<T extends SeriesCandidate>(candidates: T[]): T[][] {
  const bySeries = new Map<string, T[]>();
  const units: T[][] = [];

  for (const c of candidates) {
    if (c.series_key) {
      const list = bySeries.get(c.series_key) ?? [];
      list.push(c);
      bySeries.set(c.series_key, list);
    } else {
      units.push([c]);
    }
  }
  for (const members of bySeries.values()) {
    units.push([...members].sort((a, b) => (a.series_position ?? 0) - (b.series_position ?? 0)));
  }

  return units;
}

function shuffleUnits<T>(units: T[][]): T[][] {
  const copy = [...units];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

/**
 * For a hard-capped session (Mock Exam's fixed 100 items): shuffles units
 * and greedily fills up to `target`, skipping a unit that would overshoot
 * the cap rather than ever splitting it. May land slightly under `target`
 * in rare cases (a run of large series units near the end that don't fit
 * the remaining slots) — preferred over breaking a connected series apart.
 */
export function fillUnitsToTarget<T>(units: T[][], target: number): T[] {
  const result: T[] = [];
  for (const unit of shuffleUnits(units)) {
    if (result.length >= target) break;
    if (result.length === 0 || result.length + unit.length <= target) {
      result.push(...unit);
    }
  }
  return result;
}

type WeightedUnit<T> = { members: T[]; weight: number };

/**
 * Weighted random sample without replacement, operating on series-aware
 * units instead of individual questions. `count` is a soft target: the
 * last unit picked may push the total slightly over `count` rather than
 * ever being split to land exactly on it — a connected series always stays
 * whole.
 */
function weightedSampleUnits<T>(units: WeightedUnit<T>[], count: number): T[] {
  const pool = [...units];
  const selected: T[] = [];
  while (selected.length < count && pool.length > 0) {
    const totalWeight = pool.reduce((sum, u) => sum + u.weight, 0);
    let r = Math.random() * totalWeight;
    let pickIndex = pool.length - 1;
    for (let i = 0; i < pool.length; i++) {
      r -= pool[i].weight;
      if (r <= 0) {
        pickIndex = i;
        break;
      }
    }
    selected.push(...pool[pickIndex].members);
    pool.splice(pickIndex, 1);
  }
  return selected;
}

/**
 * Weighs each candidate question for THIS user (previously-missed=3x,
 * never-attempted=1.5x, previously-correct=1x — see 25_DECISION_LOG.md),
 * then groups into series-aware units (a unit's weight is the MAX of its
 * members', so a series containing even one previously-missed question is
 * prioritized). Shared by every adaptive/weighted session type — topic
 * practice, Quick Practice, the Custom Quiz Builder, PAES and Recalled
 * Questions quizzes.
 *
 * Needs-practice units (weight > 1: never attempted, or most recently
 * missed) are drawn from FIRST and exclusively; already-correct ("mastered")
 * units are only reached into once every needs-practice unit has already
 * been used, and only to fill whatever's still short of `count`. A plain
 * single-pool weighted sample still let an already-mastered question win
 * occasionally, which is what caused sessions to keep re-serving questions
 * a student had already gotten right — Gabriel's report after a week of
 * use (2026-09-24): "do not keep repeating the questions... prioritize
 * unanswered questions[,] or their weak areas." Splitting into two tiers
 * instead of just weighting harder guarantees this rather than merely
 * making it likely, while still never leaving a session short if the
 * needs-practice pool alone can't fill it.
 */
export async function weighAndSampleCandidates(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  supabase: SupabaseClient<any>,
  candidates: SeriesCandidate[],
  count: number,
): Promise<string[]> {
  if (candidates.length === 0) return [];

  // attempt_answers can easily exceed 1000 rows for a large candidate pool
  // (e.g. Quick Practice's whole published-question set, ~7000 answers
  // across all students) — a plain `.select()` would silently cap at 1000
  // via PostgREST's default max-rows, understating older answer history and
  // misclassifying some questions as "never attempted". Paginated.
  const candidateIds = candidates.map((c) => c.id);
  const pastAnswers = await fetchAllRows<{ question_id: string; is_correct: boolean; answered_at: string }>(
    (from, to) =>
      supabase
        .from("attempt_answers")
        .select("question_id, is_correct, answered_at")
        .in("question_id", candidateIds)
        .order("answered_at", { ascending: false })
        .range(from, to),
  );

  const latestOutcome = new Map<string, boolean>();
  for (const a of pastAnswers) {
    if (!latestOutcome.has(a.question_id)) latestOutcome.set(a.question_id, a.is_correct);
  }

  function weightOf(id: string): number {
    const outcome = latestOutcome.get(id);
    return outcome === undefined ? 1.5 : outcome === false ? 3 : 1;
  }

  const units = groupIntoUnits(candidates).map((members) => ({
    members: members.map((m) => m.id),
    weight: Math.max(...members.map((m) => weightOf(m.id))),
  }));

  const needsPractice = units.filter((u) => u.weight > 1);
  const mastered = units.filter((u) => u.weight === 1);

  const selected = weightedSampleUnits(needsPractice, count);
  if (selected.length < count && mastered.length > 0) {
    selected.push(...weightedSampleUnits(mastered, count - selected.length));
  }
  return selected;
}
