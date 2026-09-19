import Link from "next/link";
import { requireAdmin } from "@/lib/auth/require-admin";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { InviteForm } from "./invite-form";

export default async function AdminPage() {
  await requireAdmin();

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER — Admin</span>
        <Link href="/dashboard" className="text-sm text-muted-foreground hover:underline">
          Back to dashboard
        </Link>
      </header>

      <div className="mx-auto max-w-xl px-6 py-10 space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Review &amp; publish content</CardTitle>
            <CardDescription>
              Questions imported from source materials start as drafts.
              Review them and publish before students can see them in
              Practice Mode.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/content" className="text-sm font-medium text-primary hover:underline">
              Go to content review →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Content quality</CardTitle>
            <CardDescription>
              Automatic flags for questions with no explanation, no correct choice marked,
              multiple correct choices on a single-choice question, or possible duplicates.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/quality" className="text-sm font-medium text-primary hover:underline">
              Go to content quality →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Group performance</CardTitle>
            <CardDescription>
              Aggregate mastery and mistake data across everyone invited, by topic.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/performance" className="text-sm font-medium text-primary hover:underline">
              Go to group performance →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Topics &amp; subtopics</CardTitle>
            <CardDescription>
              Add, rename, or reorder topics and subtopics. The 8 official PRC exam areas stay fixed.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/topics" className="text-sm font-medium text-primary hover:underline">
              Go to topic management →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Reviewer materials</CardTitle>
            <CardDescription>
              Tables, formulas, and constants for the student-facing Reviewers section. Verified content only.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/reviewers" className="text-sm font-medium text-primary hover:underline">
              Go to reviewer materials →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Flashcards</CardTitle>
            <CardDescription>
              Front/back study cards for active recall, organized by the same topic taxonomy.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Link href="/admin/flashcards" className="text-sm font-medium text-primary hover:underline">
              Go to flashcards →
            </Link>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Invite a reviewee</CardTitle>
            <CardDescription>
              Access is invite-only. Inviting an email address lets that
              person sign in with a magic link. They won&apos;t be able to
              request one until you&apos;ve invited them.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <InviteForm />
          </CardContent>
        </Card>

        <p className="text-xs text-muted-foreground">
          PLACEHOLDER: a full user list (beyond invites) is not built yet.
        </p>
      </div>
    </main>
  );
}
