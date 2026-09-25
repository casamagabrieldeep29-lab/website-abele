/**
 * Derives a browsable category for a PAES-tagged reviewer_entries row from
 * its paes_reference (e.g. "PAES 401", "PAES 401:2001") — there's no
 * explicit category column, so this mirrors the numbering convention the
 * actual PAES standards use (see Phase 1 spec): the hundreds digit maps to
 * a broad category, with the 400s split further by title keywords since
 * that range covers both general farm structures and animal-housing
 * standards under one prefix.
 *
 * Only categories that actually occur in the current PAES content should be
 * surfaced as filter options — callers derive that from the entries they
 * actually have, not from this list.
 */
export type PaesCategory =
  | "Agricultural Equipment"
  | "Postharvest / Processing"
  | "Engineering Materials"
  | "Animal Production"
  | "Farm Structures"
  | "Irrigation and Water Resources"
  | "Other";

const ANIMAL_KEYWORDS = [
  "swine",
  "hog",
  "pig",
  "piglet",
  "broiler",
  "layer",
  "poultry",
  "chicken",
  "goat",
  "cattle",
  "dairy",
  "carabao",
  "livestock",
  "slaughterhouse",
  "slaughter",
];

/** Pulls the leading digit run out of a PAES reference string, e.g. "PAES 401:2001" -> 401. */
function paesNumber(paesReference: string): number | null {
  const match = paesReference.match(/(\d{3,4})/);
  return match ? Number(match[1]) : null;
}

export function derivePaesCategory(paesReference: string, title: string): PaesCategory {
  const num = paesNumber(paesReference);
  if (num === null) return "Other";
  const hundreds = Math.floor(num / 100);

  if (hundreds === 1) return "Agricultural Equipment";
  if (hundreds === 2) return "Postharvest / Processing";
  if (hundreds === 3) return "Engineering Materials";
  if (hundreds === 5) return "Animal Production"; // slaughterhouse standards folded in with animal production
  if (hundreds === 6) return "Irrigation and Water Resources";
  if (hundreds === 4) {
    const lower = title.toLowerCase();
    return ANIMAL_KEYWORDS.some((k) => lower.includes(k)) ? "Animal Production" : "Farm Structures";
  }
  return "Other";
}

/** Stable display order for category filter chips — not alphabetical, follows the PAES numbering. */
export const PAES_CATEGORY_ORDER: PaesCategory[] = [
  "Agricultural Equipment",
  "Postharvest / Processing",
  "Engineering Materials",
  "Farm Structures",
  "Animal Production",
  "Irrigation and Water Resources",
  "Other",
];
