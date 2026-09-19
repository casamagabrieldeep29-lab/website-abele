import Link from "next/link";
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

export default function Home() {
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
        <section className="mx-auto max-w-6xl px-6 py-16 sm:py-24">
          <div className="grid gap-12 lg:grid-cols-2 lg:items-center lg:gap-16">
            <div className="animate-in fade-in slide-in-from-bottom-2 duration-700">
              <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
                Prepare smarter for the <span className="text-primary">ABE Board Exam</span>.
              </h1>
              <p className="mt-4 max-w-md text-base leading-relaxed text-muted-foreground">
                A focused review platform for the Philippine Agricultural and Biosystems Engineering Licensure
                Examination — organized by topic, built around the official exam coverage.
              </p>
            </div>

            {/* Product preview — illustrative, not live data */}
            <div className="animate-in fade-in slide-in-from-bottom-2 duration-700">
              <div className="rounded-2xl border border-border bg-card p-5 ring-1 ring-foreground/5">
                <p className="text-xs font-medium tracking-wide text-muted-foreground uppercase">Sample session</p>

                <div className="mt-3 rounded-lg border border-border bg-background p-4">
                  <p className="text-sm leading-relaxed font-medium">
                    Which of the following best describes the function of a venturi meter in an irrigation system?
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
        </section>

        {/* Feature grid */}
        <section className="mx-auto max-w-6xl px-6 py-16">
          <div className="max-w-2xl">
            <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">What you actually get</h2>
            <p className="mt-2 text-sm text-muted-foreground">
              No fluff, no filler modules — every tool below is already live and working.
            </p>
          </div>
          <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {FEATURES.map((f) => (
              <div key={f.title} className="rounded-xl border border-border bg-card p-5">
                <div className="flex size-9 items-center justify-center rounded-lg bg-primary/10 text-primary">
                  <f.icon className="size-4.5" />
                </div>
                <p className="mt-3 text-sm font-semibold">{f.title}</p>
                <p className="mt-1 text-sm text-muted-foreground">{f.description}</p>
              </div>
            ))}
          </div>
        </section>

        {/* Examination coverage */}
        <section className="mx-auto max-w-6xl px-6 py-16">
          <div className="max-w-2xl">
            <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">Official Examination Coverage</h2>
            <p className="mt-2 text-sm text-muted-foreground">
              Every topic in ABELIEVER is organized around the official PRC Table of Specifications.
            </p>
          </div>
          <div className="mt-8 grid gap-3 sm:grid-cols-2">
            {EXAM_AREAS.map((area) => (
              <div key={area.name} className="rounded-lg border border-border bg-card p-4">
                <div className="flex items-start justify-between gap-3">
                  <p className="text-sm leading-snug font-medium">{area.name}</p>
                  <span className="shrink-0 text-sm font-semibold text-primary">{area.weight}</span>
                </div>
                <div className="mt-2.5 h-1.5 overflow-hidden rounded-full bg-muted">
                  <div
                    className="h-full rounded-full bg-primary"
                    style={{ width: `${(parseInt(area.weight, 10) / 18) * 100}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
          <p className="mt-4 text-xs text-muted-foreground">
            Per the official PRC Table of Specifications. Subject to change — always verify against current
            official PRC/PRB sources.
          </p>
        </section>

        {/* Platform preview / interconnected system */}
        <section className="mx-auto max-w-6xl px-6 py-16">
          <div className="max-w-2xl">
            <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">
              Everything you need to review with purpose.
            </h2>
            <p className="mt-2 text-sm text-muted-foreground">
              ABELIEVER isn&apos;t just a question bank — practice, review, and progress tracking are all connected.
            </p>
          </div>
          <div className="mt-8 flex flex-wrap items-center justify-center gap-2">
            {PREVIEW_FLOW.map((step, i) => (
              <div key={step} className="flex items-center gap-2">
                <div className="rounded-lg border border-border bg-card px-4 py-2.5 text-sm font-medium">
                  {step}
                </div>
                {i < PREVIEW_FLOW.length - 1 && (
                  <ArrowRight className="size-4 shrink-0 text-muted-foreground" />
                )}
              </div>
            ))}
          </div>
        </section>

        {/* Study workflow loop */}
        <section className="mx-auto max-w-6xl px-6 py-16">
          <div className="max-w-2xl">
            <h2 className="text-2xl font-bold tracking-tight sm:text-3xl">Practice. Review. Improve. Repeat.</h2>
            <p className="mt-2 text-sm text-muted-foreground">
              ABELIEVER helps you keep improving — not just answer random questions.
            </p>
          </div>
          <div className="mt-8 flex flex-wrap items-center gap-2">
            {STUDY_LOOP.map((step, i) => (
              <div key={step} className="flex items-center gap-2">
                <div className="flex items-center gap-2 rounded-full border border-border bg-card px-3.5 py-1.5 text-sm">
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
        </section>

        {/* Final CTA */}
        <section className="border-t border-border bg-primary">
          <div className="mx-auto max-w-3xl px-6 py-16 text-center">
            <h2 className="text-3xl font-bold tracking-tight text-primary-foreground sm:text-4xl">
              Ready to get your shit together, <span className="text-gold">BAYAW</span>?
            </h2>
            <p className="mx-auto mt-3 max-w-md text-sm text-primary-foreground/80">
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
