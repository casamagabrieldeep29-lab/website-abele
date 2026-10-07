import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { fetchAllRows } from "@/lib/supabase/paginate";
import { ADMIN_ONLY_REVIEWER_PREFIX } from "@/lib/flagged-questions";
import type { MidtermRow } from "../midterm-reviewer";
import { MidtermExam } from "./midterm-exam";

/**
 * Admin-only customizable exam built from the Midterm Reviewer entries only
 * (draft reviewer_entries titled "Admin Reviewer: …"). Questions are generated
 * in the browser from those rows; nothing is written to the database.
 */
export default async function MidtermExamPage() {
  await requireAdmin();
  const supabase = await createClient();

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
          ABELIEVER — Midterm Exam (admin only)
        </span>
        <div className="flex gap-4 text-sm text-muted-foreground">
          <Link href="/admin/reviewers/midterm" className="hover:underline">
            Midterm Reviewer
          </Link>
          <Link href="/reviewers" className="hover:underline">
            Reviewers
          </Link>
        </div>
      </header>
      <div className="mx-auto max-w-4xl px-6 py-8">
        <MidtermExam rows={rows} />
      </div>
    </main>
  );
}
