import { redirect } from "next/navigation";
import Link from "next/link";
import { ScrollText, ClipboardCheck, Hash, TrendingUp, ArrowRight } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { PageHeader } from "@/components/page-header";

type HubCard = {
  href: string;
  icon: typeof ScrollText;
  title: string;
  description: string;
  stat?: string;
  disabled?: boolean;
};

export default async function PaesHubPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ count: questionCount }, libraryResult, masteryResult] = await Promise.all([
    supabase.from("student_questions").select("id", { count: "exact", head: true }).eq("is_paes", true),
    // paes_reference may not exist yet on a DB that hasn't picked up the
    // 027 migration — degrade to "no count yet" rather than failing the
    // whole hub page over one supplementary stat.
    supabase
      .from("reviewer_entries")
      .select("id", { count: "exact", head: true })
      .eq("status", "published")
      .not("paes_reference", "is", null),
    // get_paes_mastery() may not exist yet on a DB that hasn't picked up the
    // 029 migration — same degrade-gracefully treatment as the Library count
    // above, just for a lightweight "how many standards have any tracked
    // mastery" stat rather than the full mastery breakdown.
    supabase.rpc("get_paes_mastery"),
  ]);
  const libraryCount = libraryResult.error ? null : libraryResult.count;
  const masteryAvailable = !masteryResult.error;
  const masteryTrackedCount = masteryResult.error
    ? 0
    : (masteryResult.data ?? []).filter((m: { total_attempts: number }) => m.total_attempts > 0).length;

  const cards: HubCard[] = [
    {
      href: "/paes/library",
      icon: ScrollText,
      title: "PAES Library",
      description: "Official standard numbers as quick-reference pages — formulas, tables, and constants.",
      stat: libraryCount === null ? undefined : `${libraryCount} ${libraryCount === 1 ? "entry" : "entries"}`,
    },
    {
      href: "/paes/quiz",
      icon: ClipboardCheck,
      title: "PAES Quizzer",
      description: "Take a scored quiz pooled from PAES-tagged questions, all standards or just one.",
      stat: `${questionCount ?? 0} ${questionCount === 1 ? "question" : "questions"}`,
    },
    {
      href: "/paes/numbers",
      icon: Hash,
      title: "PAES Number Bank",
      description: "Scannable values, dimensions, and space requirements for quick lookup.",
    },
    {
      href: "/paes/mastery",
      icon: TrendingUp,
      title: "PAES Mastery",
      description: "Per-standard mastery tracking, built on the same engine as Progress.",
      stat: masteryAvailable && masteryTrackedCount > 0 ? `${masteryTrackedCount} tracked` : undefined,
    },
  ];

  return (
    <div className="mx-auto max-w-5xl">
      <PageHeader
        title="PAES"
        description="Philippine Agricultural Engineering Standards — official technical standards content, separate from the general Reviewers and Practice pool."
      />

      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
        {cards.map((card) => {
          const Icon = card.icon;
          const body = (
            <Card className={card.disabled ? "opacity-70" : "transition-colors hover:border-primary/40"}>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex size-9 items-center justify-center rounded-md bg-primary/15 text-primary">
                    <Icon className="size-5" />
                  </div>
                  {card.disabled && <Badge variant="secondary">Coming soon</Badge>}
                </div>
                <CardTitle className="mt-2 flex items-center gap-1.5">
                  {card.title}
                  {!card.disabled && <ArrowRight className="size-4 text-muted-foreground" />}
                </CardTitle>
                <CardDescription>{card.description}</CardDescription>
              </CardHeader>
              {card.stat && (
                <CardContent>
                  <p className="text-xs font-medium text-muted-foreground">{card.stat}</p>
                </CardContent>
              )}
            </Card>
          );

          return card.disabled ? (
            <div key={card.href}>{body}</div>
          ) : (
            <Link key={card.href} href={card.href}>
              {body}
            </Link>
          );
        })}
      </div>
    </div>
  );
}
