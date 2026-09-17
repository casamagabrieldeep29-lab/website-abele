import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { signOut } from "./actions";

export default async function DashboardPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  return (
    <main className="min-h-screen bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold text-primary">ABELIEVER</span>
        <div className="flex items-center gap-3">
          <span className="text-sm text-muted-foreground">{user.email}</span>
          <form action={signOut}>
            <Button variant="outline" size="sm" type="submit">
              Sign out
            </Button>
          </form>
        </div>
      </header>

      <div className="mx-auto max-w-5xl px-6 py-10">
        <h1 className="text-2xl font-semibold">Welcome back</h1>
        <p className="mt-1 text-muted-foreground">
          Your ABE Licensure Exam review dashboard.
        </p>

        <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          <Card className="opacity-60">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle>Practice Mode</CardTitle>
                <Badge variant="secondary">Coming soon</Badge>
              </div>
              <CardDescription>
                Topic-by-topic questions with instant feedback and explanations.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Button disabled className="w-full">
                Start practicing
              </Button>
            </CardContent>
          </Card>

          <Card className="opacity-60">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle>Mock Exam</CardTitle>
                <Badge variant="secondary">Coming soon</Badge>
              </div>
              <CardDescription>
                Timed, full-length simulated examinations across all exam areas.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Button disabled className="w-full">
                Start mock exam
              </Button>
            </CardContent>
          </Card>

          <Card className="opacity-60">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle>Progress</CardTitle>
                <Badge variant="secondary">Coming soon</Badge>
              </div>
              <CardDescription>
                Topic accuracy, weak areas, and study history.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Button disabled className="w-full">
                View progress
              </Button>
            </CardContent>
          </Card>
        </div>

        <p className="mt-10 text-xs text-muted-foreground">
          PLACEHOLDER: this dashboard is a shell. Practice Mode and Mock Exam will be
          wired up once the question bank (Area 1 &amp; Area 2 pilot content) and
          database schema are in place.
        </p>
      </div>
    </main>
  );
}
