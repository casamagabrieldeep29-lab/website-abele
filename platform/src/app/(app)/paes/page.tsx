import { redirect } from "next/navigation";
import Link from "next/link";
import { ScrollText, ClipboardCheck, Hash, TrendingUp, ArrowRight } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { PageHeader } from "@/components/page-header";
import { PageContainer } from "@/components/page-container";
import { getSessionUser } from "@/lib/auth/session";

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
  const user = await getSessionUser(supabase);
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
    // Only the NUMBER of tracked standards is shown here — a HEAD + exact-count
    // request returns just the count instead of every standard's mastery row.
    supabase.rpc("get_paes_mastery", undefined, { head: true, count: "exact" }),
  ]);
  const libraryCount = libraryResult.error ? null : libraryResult.count;
  const masteryAvailable = !masteryResult.error;
  const masteryTrackedCount = masteryResult.error ? 0 : (masteryResult.count ?? 0);

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
    <PageContainer size="hub">
      <PageHeader
        title="PAES"
        description="Philippine Agricultural Engineering Standards — official technical standards content, separate from the general Reviewers and Practice pool."
      />

      <div className="mt-8 grid grid-cols-1 gap-5 sm:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => {
          const Icon = card.icon;
          const body = (
            <Card
              className={
                card.disabled
                  ? "h-full opacity-70"
                  : "h-full transition-all duration-150 hover:-translate-y-0.5 hover:shadow-md hover:ring-primary/40"
              }
            >
              <CardHeader className="pb-2">
                <div className="flex items-center justify-between">
                  <div className="flex size-12 items-center justify-center rounded-lg bg-primary/15 text-primary">
                    <Icon className="size-6" />
                  </div>
                  {card.disabled && <Badge variant="secondary">Coming soon</Badge>}
                </div>
                <CardTitle className="mt-3 flex items-center gap-1.5 text-lg">
                  {card.title}
                  {!card.disabled && <ArrowRight className="size-4 text-muted-foreground" />}
                </CardTitle>
                <CardDescription className="text-sm leading-relaxed">{card.description}</CardDescription>
              </CardHeader>
              {card.stat && (
                <CardContent className="pt-0">
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
    </PageContainer>
  );
}
