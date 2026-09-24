import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { NOT_FLAGGED_FILTER } from "@/lib/flagged-questions";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { AutoCategorizePanel } from "./auto-categorize-panel";
import { PublishAllDraftsButton } from "./publish-all-drafts-button";

export default async function AdminContentPage() {
  await requireAdmin();
  const supabase = await createClient();

  const [{ data: topics }, { count: uncategorizedCount }, { count: totalDraftCount }, { count: flaggedCount }] =
    await Promise.all([
      supabase.from("topics").select("id, name, exam_areas(name), questions(status)").order("name"),
      supabase
        .from("questions")
        .select("id", { count: "exact", head: true })
        .is("category", null)
        .neq("status", "archived"),
      // Matches publishAllDrafts' own exclusion — the count shown next to the
      // button should equal what clicking it will actually publish.
      supabase
        .from("questions")
        .select("id", { count: "exact", head: true })
        .eq("status", "draft")
        .or(NOT_FLAGGED_FILTER),
      supabase
        .from("questions")
        .select("id", { count: "exact", head: true })
        .ilike("explanation", "%FLAGGED FOR REVIEW%")
        .neq("status", "archived"),
    ]);

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Content Review</span>
        <Link href="/admin" className="text-sm text-muted-foreground hover:underline">
          Back to admin
        </Link>
      </header>

      <div className="mx-auto max-w-3xl px-6 py-10">
        <h1 className="text-2xl font-semibold">Topics</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Only <strong>published</strong> questions are visible to students. Review
          drafts before publishing them.
        </p>

        <div className="mt-6">
          <AutoCategorizePanel initialUncategorized={uncategorizedCount ?? 0} />
        </div>

        <div className="mt-4 flex flex-wrap items-center gap-3">
          <PublishAllDraftsButton draftCount={totalDraftCount ?? 0} />
          {(flaggedCount ?? 0) > 0 && (
            <Link
              href="/admin/content/flagged"
              className="inline-flex items-center gap-1.5 text-sm font-medium text-destructive hover:underline"
            >
              ⚑ {flaggedCount} flagged question{flaggedCount === 1 ? "" : "s"} need review →
            </Link>
          )}
        </div>

        <div className="mt-6 space-y-3">
          {topics?.map((topic) => {
            const questions = (topic.questions ?? []) as { status: string }[];
            const draftCount = questions.filter((q) => q.status === "draft").length;
            const publishedCount = questions.filter((q) => q.status === "published").length;
            const examAreaName = (topic.exam_areas as unknown as { name: string } | null)?.name;

            return (
              <Card key={topic.id}>
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle>{topic.name}</CardTitle>
                      <p className="mt-1 text-xs text-muted-foreground">{examAreaName}</p>
                    </div>
                    <Link
                      href={`/admin/content/${topic.id}`}
                      className="text-sm font-medium text-primary hover:underline"
                    >
                      Review →
                    </Link>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="flex gap-2">
                    <Badge variant="secondary">{draftCount} draft</Badge>
                    <Badge variant="outline">{publishedCount} published</Badge>
                  </div>
                </CardContent>
              </Card>
            );
          })}

          {!topics?.length && (
            <p className="text-sm text-muted-foreground">No topics yet.</p>
          )}
        </div>
      </div>
    </main>
  );
}
