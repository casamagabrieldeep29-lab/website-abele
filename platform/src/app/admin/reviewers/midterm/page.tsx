import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { ADMIN_ONLY_REVIEWER_PREFIX } from "@/lib/flagged-questions";
import { MidtermReviewer, type MidtermRow } from "./midterm-reviewer";

/**
 * Admin-only "Midterm Reviewer": terms, formulas (each with a worked sample
 * problem) and key concepts, grouped by section and topic. It is part of the
 * Reviewers section but deliberately separate from the Formulas / Tables /
 * Constants tabs. The rows are draft reviewer_entries titled "Admin Reviewer:
 * …", so students can never read them (RLS only exposes published rows) and
 * the bulk "Publish All Drafts" action skips them.
 */
export default async function MidtermReviewerPage() {
  await requireAdmin();
  const supabase = await createClient();

  // Admin-only page (a handful of people): explicit columns, filtered to the
  // admin-only rows, paginated past PostgREST's 1,000-row default.
  const rows = await fetchAllRows<MidtermRow>((from, to) =>
    supabase
      .from("reviewer_entries")
      .select(
        "id, kind, title, formula, variables, table_content, description, notes",
      )
      .ilike("title", `${ADMIN_ONLY_REVIEWER_PREFIX}%`)
      .order("notes")
      .range(from, to),
  );

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">
          ABELIEVER — Midterm Reviewer (admin only)
        </span>
        <div className="flex gap-4 text-sm text-muted-foreground">
          <Link
            href="/admin/reviewers/midterm/exam"
            className="font-medium text-primary hover:underline"
          >
            Custom exam →
          </Link>
          <Link href="/reviewers" className="hover:underline">
            Reviewers
          </Link>
          <Link href="/admin/reviewers" className="hover:underline">
            Reviewer materials
          </Link>
        </div>
      </header>
      <div className="mx-auto max-w-5xl px-6 py-8">
        <MidtermReviewer rows={rows} />
      </div>
    </main>
  );
}
