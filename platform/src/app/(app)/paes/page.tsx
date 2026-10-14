import { redirect } from "next/navigation";
import Link from "next/link";
import { ScrollText, ClipboardCheck, Hash, TrendingUp, ArrowRight } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { Card, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { PageHeader } from "@/components/page-header";
import { PageContainer } from "@/components/page-container";
import { getSessionUser } from "@/lib/auth/session";

type HubCard = {
  href: string;
  icon: typeof ScrollText;
  title: string;
  description: string;
  disabled?: boolean;
};

export default async function PaesHubPage() {
  const supabase = await createClient();
  const user = await getSessionUser(supabase);
  if (!user) redirect("/login");

  const cards: HubCard[] = [
    {
      href: "/paes/library",
      icon: ScrollText,
      title: "PAES Library",
      description: "Official standard numbers as quick-reference pages — formulas, tables, and constants.",
    },
    {
      href: "/paes/quiz",
      icon: ClipboardCheck,
      title: "PAES Quizzer",
      description: "Take a scored quiz pooled from PAES-tagged questions, all standards or just one.",
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
