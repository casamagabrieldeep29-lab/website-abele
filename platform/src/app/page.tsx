import Link from "next/link";
import { redirect } from "next/navigation";
import {
  ArrowRight,
  BookOpen,
  CheckCircle2,
  ClipboardCheck,
  Flame,
  ListChecks,
  RotateCcw,
  Sparkles,
  Target,
  TrendingUp,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { createClient } from "@/lib/supabase/server";

const EXAM_AREAS = [
  { name: "Agricultural and Biosystems Power, Energy and Machinery Engineering", weight: "18%" },
  { name: "Land and Water Resources Engineering", weight: "18%" },
  { name: "Agricultural and Biosystems Structures and Environment Engineering", weight: "18%" },
  { name: "Agricultural and Bioprocess Engineering", weight: "18%" },
  {
    name: "Project Management, Feasibility Study Preparation/Evaluation, Research, Development and Extension",
    weight: "8%",
  },
  { name: "Fundamentals of Agricultural, Fishery, Ecological and Environmental Sciences", weight: "6%" },
  { name: "Mathematics and Basic Engineering Principles", weight: "8%" },
  { name: "Laws, Professional Standards, and Ethics", weight: "6%" },
];

// Purely a visual density/grouping label for the landing page — not an official
// PRC category. Derived from the same weight values already shown, nothing new.
function coverageTier(weightPercent: number): { label: string; className: string } {
  if (weightPercent >= 18) return { label: "High-Yield Area", className: "bg-primary/10 text-primary" };
  if (weightPercent >= 8) return { label: "Core Technical Domain", className: "bg-secondary text-secondary-foreground" };
  return { label: "Foundational Topic", className: "bg-muted text-muted-foreground" };
}

const FEATURES = [
  {
    icon: BookOpen,
    title: "Practice",
    description: "Build confidence with focused ABE practice questions.",
  },
  {
    icon: ClipboardCheck,
    title: "Mock Exams",
    description: "Simulate the pressure and structure of the actual examination.",
  },
  {
    icon: ListChecks,
    title: "Review by Topic",
    description: "Study according to the official examination coverage.",
  },
  {
    icon: TrendingUp,
    title: "Track Progress",
    description: "See accuracy, mastery, weak areas, and study progress.",
  },
  {
    icon: RotateCcw,
    title: "Review Mistakes",
    description: "Turn incorrect answers into targeted review.",
  },
  {
    icon: Sparkles,
    title: "AI Explanations",
    description: "Get clearer explanations when you need help understanding a concept.",
  },
];

const PREVIEW_FLOW = ["Practice", "Results", "Weak Areas", "Review Mistakes", "Progress"];

const STUDY_LOOP = ["Practice", "Review", "Identify Weak Areas", "Learn", "Practice Again", "Track Progress"];

export default async function Home() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (user) redirect("/dashboard");

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <header className="sticky top-0 z-10 border-b border-border/70 bg-background/85 backdrop-blur-sm">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
          <span className="text-lg font-bold tracking-tight text-primary">ABELIEVER</span>
          <Button render={<Link href="/login">Sign in</Link>} nativeButton={false} size="sm" />
        </div>
      </header>

      <main className="flex-1">
        {/* Hero */}
        <section className="bg-background py-16 sm:py-24 lg:py-28">
          <div className="mx-auto max-w-6xl px-6">
            <div className="grid gap-12 lg:grid-cols-[1.15fr_1fr] lg:items-center lg:gap-20">
              <div className="animate-in fade-in slide-in-from-bottom-2 duration-700">
                <h1 className="text-4xl leading-[1.05] font-bold tracking-tight sm:text-5xl lg:text-6xl">
                  Prepare smarter for the <span className="text-primary">ABE Board Exam</span>.
                </h1>
                <p className="mt-5 max-w-md text-base leading-relaxed text-muted-foreground lg:max-w-lg lg:text-lg">
                  A focused review platform for the Philippine Agricultural and Biosystems Engineering Licensure
                  Examination — organized by topic, built around the official exam coverage.
                </p>
              </div>

              {/* Product preview — illustrative, not live data */}
              <div className="animate-in fade-in slide-in-from-bottom-2 duration-700 lg:relative">
                {/* Floating context badges — desktop only, fill the wide margins around the frame */}
                <div className="absolute -top-5 -right-4 z-10 hidden items-center gap-1.5 rounded-full border border-border bg-card px-3 py-1.5 shadow-lg lg:flex">
                  <Flame className="size-3.5 text-gold" />
                  <span className="text-xs font-semibold">6-day streak</span>
                </div>
                <div className="absolute -bottom-5 -left-4 z-10 hidden items-center gap-1.5 rounded-full border border-border bg-card px-3 py-1.5 shadow-lg lg:flex">
                  <TrendingUp className="size-3.5 text-primary" />
                  <span className="text-xs font-semibold">64% topic mastery</span>
                </div>

                {/* App-frame chrome */}
                <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-[0_30px_60px_-25px_rgba(15,91,90,0.35)] ring-1 ring-foreground/5">
                  <div className="flex items-center gap-1.5 border-b border-border bg-muted/50 px-4 py-2.5">
                    <span className="size-2.5 rounded-full bg-destructive/40" />
                    <span className="size-2.5 rounded-full bg-gold/50" />
                    <span className="size-2.5 rounded-full bg-success/40" />
                    <span className="ml-3 truncate rounded-md bg-background px-2.5 py-0.5 text-[11px] text-muted-foreground">
                      abeliever.vercel.app/practice
                    </span>
                  </div>

                  <div className="p-5">
                    <p className="text-xs font-medium tracking-wide text-muted-foreground uppercase">
                      Sample session
                    </p>

                    <div className="mt-3 rounded-lg border border-border bg-background p-4">
                      <p className="text-sm leading-relaxed font-medium">
                        Which of the following best describes the function of a venturi meter in an irrigation
                        system?
                      </p>
                      <div className="mt-3 space-y-2">
                        <div className="flex items-center gap-1.5 rounded-lg border-2 border-success bg-success/10 px-3 py-2 text-sm font-medium text-success">
                          <CheckCircle2 className="size-3.5 shrink-0" />
                          Measures flow rate via pressure differential
                        </div>
                        <div className="rounded-lg border-2 border-border px-3 py-2 text-sm text-muted-foreground">
                          Regulates irrigation water pH
                        </div>
                      </div>
                    </div>

                    <div className="mt-4 grid grid-cols-3 gap-2">
                      <div className="rounded-lg border-l-4 border-l-primary bg-card p-3">
                        <p className="text-lg font-semibold tracking-tight">78%</p>
                        <p className="text-[11px] text-muted-foreground">Accuracy</p>
                      </div>
                      <div className="rounded-lg border-l-4 border-l-gold bg-card p-3">
                        <p className="flex items-center gap-1 text-lg font-semibold tracking-tight">
                          6 <Flame className="size-3.5 text-gold" />
                        </p>
                        <p className="text-[11px] text-muted-foreground">Day streak</p>
                      </div>
                      <div className="rounded-lg border-l-4 border-l-border bg-card p-3">
                        <p className="text-lg font-semibold tracking-tight">64%</p>
                        <p className="text-[11px] text-muted-foreground">Mastery</p>
                      </div>
                    </div>

                    <div className="mt-4 flex items-center justify-between gap-3 rounded-lg border-l-4 border-l-destructive bg-destructive/5 px-3 py-2.5">
                      <span className="text-xs font-medium">Needs review: Land &amp; Water Resources Eng.</span>
                      <Target className="size-3.5 shrink-0 text-destructive" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Feature grid */}
        <section className="border-t border-border bg-card py-16 lg:py-20">
          <div className="mx-auto max-w-6xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">What you actually get</h2>
              <p className="mt-2 text-sm text-muted-foreground">
                No fluff, no filler modules — every tool below is already live and working.
              </p>
            </div>
            <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 lg:gap-5">
              {FEATURES.map((f) => (
                <div
                  key={f.title}
                  className="rounded-xl border border-border bg-background p-5 transition-all hover:-translate-y-0.5 hover:shadow-md lg:p-6"
                >
                  <div className="flex size-9 items-center justify-center rounded-lg bg-primary/10 text-primary lg:size-10">
                    <f.icon className="size-4.5" />
                  </div>
                  <p className="mt-3 text-sm font-semibold lg:text-base">{f.title}</p>
                  <p className="mt-1 text-sm text-muted-foreground">{f.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Examination coverage */}
        <section className="border-t border-border bg-background py-16 lg:py-20">
          <div className="mx-auto max-w-6xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">Official Examination Coverage</h2>
              <p className="mt-2 text-sm text-muted-foreground">
                Every topic in ABELIEVER is organized around the official PRC Table of Specifications.
              </p>
            </div>
            <div className="mt-8 grid gap-3 sm:grid-cols-2 lg:gap-4">
              {EXAM_AREAS.map((area) => {
                const pct = parseInt(area.weight, 10);
                const tier = coverageTier(pct);
                return (
                  <div key={area.name} className="rounded-lg border border-border bg-card p-4 lg:p-5">
                    <span className={`inline-block rounded-full px-2 py-0.5 text-[10px] font-medium ${tier.className}`}>
                      {tier.label}
                    </span>
                    <div className="mt-2 flex items-start justify-between gap-3">
                      <p className="text-sm leading-snug font-medium">{area.name}</p>
                      <span className="shrink-0 text-sm font-semibold text-primary">{area.weight}</span>
                    </div>
                    <div className="mt-2.5 h-1.5 overflow-hidden rounded-full bg-primary/10">
                      <div className="h-full rounded-full bg-primary" style={{ width: `${(pct / 18) * 100}%` }} />
                    </div>
                  </div>
                );
              })}
            </div>
            <p className="mt-4 text-xs text-muted-foreground">
              Per the official PRC Table of Specifications. Subject to change — always verify against current
              official PRC/PRB sources.
            </p>
          </div>
        </section>

        {/* Platform preview / interconnected system */}
        <section className="border-t border-border bg-card py-16 lg:py-20">
          <div className="mx-auto max-w-6xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">
                Everything you need to review with purpose.
              </h2>
              <p className="mt-2 text-sm text-muted-foreground">
                ABELIEVER isn&apos;t just a question bank — practice, review, and progress tracking are all connected.
              </p>
            </div>
            <div className="mt-8 rounded-2xl border border-border bg-secondary/40 p-6 lg:p-10">
              <div className="flex flex-wrap items-center justify-center gap-3 lg:flex-nowrap lg:justify-between lg:gap-0">
                {PREVIEW_FLOW.map((step, i) => (
                  <div key={step} className="flex items-center lg:flex-1 lg:justify-center">
                    {i > 0 && <span className="mr-3 hidden h-px flex-1 bg-border lg:block" />}
                    <div className="flex items-center gap-2">
                      <div className="shrink-0 rounded-lg border border-border bg-card px-4 py-2.5 text-sm font-medium">
                        {step}
                      </div>
                      {i < PREVIEW_FLOW.length - 1 && (
                        <ArrowRight className="size-4 shrink-0 text-muted-foreground lg:hidden" />
                      )}
                    </div>
                    {i < PREVIEW_FLOW.length - 1 && (
                      <span className="ml-3 hidden h-px flex-1 bg-border lg:block" />
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        {/* Study workflow loop */}
        <section className="border-t border-border bg-background py-16 lg:py-20">
          <div className="mx-auto max-w-6xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">Practice. Review. Improve. Repeat.</h2>
              <p className="mt-2 text-sm text-muted-foreground">
                ABELIEVER helps you keep improving — not just answer random questions.
              </p>
            </div>
            <div className="mt-8 flex flex-wrap items-center gap-2 lg:gap-3">
              {STUDY_LOOP.map((step, i) => (
                <div key={step} className="flex items-center gap-2 lg:gap-3">
                  <div className="flex items-center gap-2 rounded-full border border-border bg-card px-3.5 py-1.5 text-sm lg:px-4 lg:py-2">
                    <span className="flex size-5 shrink-0 items-center justify-center rounded-full bg-primary/10 text-[11px] font-semibold text-primary">
                      {i + 1}
                    </span>
                    {step}
                  </div>
                  {i < STUDY_LOOP.length - 1 && (
                    <ArrowRight className="size-3.5 shrink-0 text-muted-foreground" />
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Final CTA */}
        <section className="border-t border-border bg-primary">
          <div className="mx-auto max-w-3xl px-6 py-16 text-center lg:py-24">
            <h2 className="text-3xl font-bold tracking-tight text-primary-foreground sm:text-4xl lg:text-5xl">
              Ready to get your shit together, <span className="text-gold">BAYAW</span>?
            </h2>
            <p className="mx-auto mt-3 max-w-md text-sm text-primary-foreground/80 lg:text-base">
              Practice with purpose. Find your weak areas. Build your confidence for the board exam.
            </p>
            <div className="mt-7 flex justify-center">
              <Button
                render={<Link href="/login">Sign in to ABELIEVER</Link>}
                nativeButton={false}
                size="lg"
                className="bg-background text-primary hover:bg-background/90"
              />
            </div>
            <p className="mt-3 text-xs text-primary-foreground/70">
              ABELIEVER currently uses invite-only access.
            </p>
          </div>
        </section>
      </main>

      <footer className="border-t px-6 py-6 text-center text-xs text-muted-foreground">
        ABELIEVER — private ABE Licensure Exam review platform.
      </footer>
    </div>
  );
}
