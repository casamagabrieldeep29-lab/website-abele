const REVIEW_FLAG_PATTERN = /\s*\[(?:FLAGGED FOR REVIEW|CORRECTED after review)[^\]]*\]/gi;

/**
 * Explanations are stored with an optional admin-only QA note appended by
 * content import or admin edits (e.g. "[FLAGGED FOR REVIEW: ...]",
 * "[CORRECTED after review: ... by <name> on <date> ...]"). Students should
 * never see that note — it's for /admin/content and /admin/quality.
 */
export function studentFacingExplanation(explanation: string | null): string | null {
  if (!explanation) return explanation;
  const cleaned = explanation.replace(REVIEW_FLAG_PATTERN, "").trim();
  return cleaned || null;
}
