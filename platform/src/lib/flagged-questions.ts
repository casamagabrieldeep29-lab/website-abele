// A question's explanation carrying "FLAGGED FOR REVIEW" means the source
// material itself expressed uncertainty about the correct answer (see the
// Flagged Questions admin page, /admin/content/flagged) — such a question
// must never be auto-published or used in a scored, timed exam without a
// human review first.
//
// Passed to Supabase's .or(...) rather than .not("explanation", "ilike",
// ...) alone: NOT (NULL ILIKE pattern) evaluates to NULL in SQL, which a
// WHERE clause treats as non-matching, so a plain .not(...) would silently
// exclude every question that has no explanation at all — most of them.
// explanation.is.null explicitly keeps those rows in.
export const NOT_FLAGGED_FILTER = "explanation.is.null,explanation.not.ilike.%FLAGGED FOR REVIEW%";

// Same pattern, same NULL-handling reasoning, applied to reviewer_entries —
// its "FLAGGED FOR REVIEW" marker lives in `notes` instead of `explanation`
// (used when the PAES source standard itself has a genuine anomaly, e.g. a
// formula contradicting its own method text).
export const NOT_FLAGGED_REVIEWER_FILTER = "notes.is.null,notes.not.ilike.%FLAGGED FOR REVIEW%";

// Reviewer entries whose title starts with this prefix are admin-only study
// material (e.g. the midterm reviewer). They stay as drafts so students can
// never read them (RLS only exposes status = 'published'), and the bulk
// "Publish All Drafts" action skips them so one click can't release them.
// They can still be published one by one on purpose.
export const ADMIN_ONLY_REVIEWER_PREFIX = "Admin Reviewer:";

export function isAdminOnlyReviewerTitle(title: string): boolean {
  return title.startsWith(ADMIN_ONLY_REVIEWER_PREFIX);
}
