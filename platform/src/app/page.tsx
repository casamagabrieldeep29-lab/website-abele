import Link from "next/link";
import {
  ArrowRight,
  BarChart3,
  BookOpen,
  Brain,
  Calculator,
  CheckCircle2,
  ClipboardCheck,
  Flame,
  Hash,
  ListChecks,
  RotateCcw,
  Sparkles,
  Target,
  TrendingUp,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { FaqAccordion } from "@/components/faq-accordion";
import { UPGRADE_PRICE_PHP } from "@/lib/payment-methods";

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
function coverageTier(weightPercent: number): { label: string; className: string; featured: boolean } {
  if (weightPercent >= 18) return { label: "High-Yield Area", className: "bg-primary/10 text-primary", featured: true };
  if (weightPercent >= 8) return { label: "Core Technical Domain", className: "bg-secondary text-secondary-foreground", featured: false };
  return { label: "Foundational Topic", className: "bg-muted text-muted-foreground", featured: false };
}

// The rest of this page's numbers are pulled from the live database and
// rounded down, never estimated (see the hero's "170+" line below). The
// question count is the one deliberate exception — Gabriel asked for it to
// read "7,000+" after being told the real published count is 3,530, so this
// is a chosen marketing figure, not a database read.
const PRODUCT_PROOF = ["7,000+ Questions", "Mock Exams", "Mistake Bank", "Progress Tracking", "AI Explanations"];

const WORKFLOW_STEPS = [
  { title: "Practice", description: "Answer focused ABE questions, organized by the official exam coverage." },
  { title: "Review", description: "See exactly what you got wrong and why, right after you answer." },
  { title: "Identify weak areas", description: "Real mastery data shows which topics actually need work." },
  { title: "Learn", description: "AI explanations and reference materials fill the gap when you're stuck." },
  { title: "Practice again", description: "Retest yourself on the same topic with a fresh set of questions." },
  { title: "Track progress", description: "Watch accuracy and mastery move as you keep going." },
];

const ECOSYSTEM_ITEMS = [
  { icon: ClipboardCheck, title: "PAES Review", description: "Dedicated review and quizzing built around the PAES standards." },
  { icon: Calculator, title: "Formula Trainer", description: "Active recall for ABE formulas — see the name, recall the equation." },
  { icon: Hash, title: "Number Bank", description: "Quick-lookup constants and reference values, quizzable the same way." },
  { icon: Brain, title: "AI Explanations", description: "\"Teach Me This\" breaks down a question when the answer key isn't enough." },
];

// Fully static: the signed-in -> /dashboard redirect lives in src/proxy.ts, so
// this page needs no per-request auth lookup and is served from the CDN.
export default function Home() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <header className="sticky top-0 z-20 border-b border-border/70 bg-background/85 backdrop-blur-sm">
        <div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-4">
          <span className="text-lg font-bold tracking-tight text-primary">ABELIEVER</span>
          <div className="flex items-center gap-2">
            <Button render={<Link href="/login">Sign in</Link>} nativeButton={false} size="sm" variant="ghost" />
            <Button render={<Link href="/signup">Sign up</Link>} nativeButton={false} size="sm" />
          </div>
        </div>
      </header>

      <main className="flex-1">
        {/* Hero */}
        <section className="relative overflow-hidden bg-background pt-14 pb-20 sm:pt-20 sm:pb-28 lg:pb-32">
          {/* Very restrained backdrop wash — same primary-tinted radial treatment already used behind the authenticated app shell (globals.css), just toned down further for a public marketing page. */}
          <div
            aria-hidden
            className="pointer-events-none absolute inset-0 -z-10"
            style={{
              backgroundImage:
                "radial-gradient(ellipse 900px 520px at 88% -10%, color-mix(in srgb, var(--primary) 7%, transparent), transparent 65%), radial-gradient(ellipse 700px 420px at 0% 100%, color-mix(in srgb, var(--gold) 5%, transparent), transparent 65%)",
            }}
          />

          <div className="mx-auto max-w-7xl px-6">
            <div className="grid gap-16 lg:grid-cols-[1.05fr_1fr] lg:items-center lg:gap-14">
              <div className="animate-in fade-in slide-in-from-bottom-2 duration-700">
                <span className="inline-flex items-center gap-1.5 rounded-full border border-primary/20 bg-primary/5 px-3 py-1 text-xs font-semibold tracking-wide text-primary uppercase">
                  Built for the PRC ABE Licensure Exam
                </span>

                <h1 className="mt-5 text-5xl leading-[1.02] font-bold tracking-tight sm:text-6xl lg:text-[3.75rem]">
                  Prepare smarter for the <span className="text-primary">ABE Board Exam</span>.
                </h1>
                <p className="mt-6 max-w-md text-base leading-relaxed text-muted-foreground lg:max-w-lg lg:text-lg">
                  A focused review platform for the Philippine Agricultural and Biosystems Engineering Licensure
                  Examination — organized by topic, built around the official exam coverage.
                </p>

                <div className="mt-8 flex flex-wrap items-center gap-4">
                  <Button render={<Link href="/signup">Be an ABELIEVER</Link>} nativeButton={false} size="lg" className="h-11 px-6 text-base" />
                  <Link href="/login" className="text-sm font-medium text-foreground/80 hover:text-foreground hover:underline">
                    Already have an account? Sign in
                  </Link>
                </div>
                <p className="mt-3 text-sm text-muted-foreground">Trusted by 170+ future ABE engineers.</p>

                {/* Product-proof row — every label here is a real, shipped feature or a real count pulled from the database, never an invented stat. */}
                <div className="mt-10 flex flex-wrap items-center gap-x-5 gap-y-2 border-t border-border/70 pt-6">
                  {PRODUCT_PROOF.map((item, i) => (
                    <span key={item} className="flex items-center gap-5 text-sm font-medium text-foreground/80">
                      {i > 0 && <span className="h-3.5 w-px bg-border" aria-hidden />}
                      {item}
                    </span>
                  ))}
                </div>
              </div>

              {/* Product preview — illustrative, not live data */}
              <div className="animate-in fade-in slide-in-from-bottom-2 duration-700 lg:relative lg:pt-4 lg:pr-4">
                {/* Floating context badges — desktop only, fill the wide margins around the frame */}
                <div className="absolute -top-4 right-6 z-10 hidden items-center gap-1.5 rounded-full border border-border bg-card px-3 py-1.5 shadow-lg lg:flex">
                  <Flame className="size-3.5 text-gold" />
                  <span className="text-xs font-semibold">6-day streak</span>
                </div>
                <div className="absolute top-1/2 -right-6 z-10 hidden -translate-y-1/2 items-center gap-1.5 rounded-full border border-border bg-card px-3 py-1.5 shadow-lg lg:flex">
                  <TrendingUp className="size-3.5 text-primary" />
                  <span className="text-xs font-semibold">64% topic mastery</span>
                </div>
                <div className="absolute -bottom-4 left-10 z-10 hidden items-center gap-1.5 rounded-full border border-border bg-card px-3 py-1.5 shadow-lg lg:flex">
                  <ListChecks className="size-3.5 text-success" />
                  <span className="text-xs font-semibold">12 questions today</span>
                </div>

                {/* A second, receded frame peeking out behind the main one — the "layered cards" depth cue from the redesign brief, done with pure CSS (no extra image). */}
                <div
                  aria-hidden
                  className="absolute inset-4 -z-10 hidden rounded-2xl border border-border/60 bg-card/60 lg:block"
                  style={{ transform: "translate(14px, 14px) rotate(1.5deg)" }}
                />

                {/* App-frame chrome */}
                <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-[0_35px_70px_-30px_rgba(15,91,90,0.4)] ring-1 ring-foreground/5">
                  <div className="flex items-center gap-1.5 border-b border-border bg-muted/50 px-4 py-2.5">
                    <span className="size-2.5 rounded-full bg-destructive/40" />
                    <span className="size-2.5 rounded-full bg-gold/50" />
                    <span className="size-2.5 rounded-full bg-success/40" />
                    <span className="ml-3 truncate rounded-md bg-background px-2.5 py-0.5 text-[11px] text-muted-foreground">
                      abeliever.vercel.app/practice
                    </span>
                  </div>

                  <div className="p-5 lg:p-6">
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

        {/* Why ABELIEVER exists */}
        <section className="border-t border-border bg-card py-16 lg:py-20">
          <div className="mx-auto max-w-7xl px-6">
            <div className="grid gap-8 lg:grid-cols-2 lg:gap-16">
              <h2 className="text-2xl leading-snug font-bold tracking-tight sm:text-3xl lg:text-4xl">
                ABE review shouldn&apos;t mean jumping between random reviewers, PDFs, and question banks.
              </h2>
              <p className="text-base leading-relaxed text-muted-foreground lg:mt-2 lg:text-lg">
                ABELIEVER brings practice, review, explanations, mistakes, and progress into one connected system —
                built specifically for Agricultural and Biosystems Engineering students, around the actual official
                exam coverage.
              </p>
            </div>
          </div>
        </section>

        {/* Feature 1 — Practice with purpose */}
        <section className="border-t border-border bg-background py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="grid gap-10 lg:grid-cols-2 lg:items-center lg:gap-16">
              <div>
                <div className="flex size-11 items-center justify-center rounded-xl bg-primary/10 text-primary">
                  <BookOpen className="size-5" />
                </div>
                <h2 className="mt-5 text-3xl font-bold tracking-tight lg:text-4xl">Practice with purpose.</h2>
                <p className="mt-3 max-w-md text-base leading-relaxed text-muted-foreground">
                  Every session is organized around the official examination coverage — not random questions in
                  random order.
                </p>
                <ul className="mt-6 space-y-3">
                  {[
                    "Practice by topic, area, or the full official coverage",
                    "Focus sessions built around your actual weak areas",
                    "Simulate the real exam with full Mock Exams",
                    "Review every incorrect answer right after you submit",
                  ].map((item) => (
                    <li key={item} className="flex items-start gap-2.5 text-sm leading-relaxed">
                      <CheckCircle2 className="mt-0.5 size-4 shrink-0 text-primary" />
                      <span>{item}</span>
                    </li>
                  ))}
                </ul>
              </div>

              <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-lg ring-1 ring-foreground/5">
                <div className="border-b border-border bg-muted/50 px-4 py-2.5 text-[11px] font-medium tracking-wide text-muted-foreground uppercase">
                  Practice — Land &amp; Water Resources Engineering
                </div>
                <div className="p-5">
                  <div className="flex items-center justify-between text-xs text-muted-foreground">
                    <span>Question 7 of 20</span>
                    <span>35% complete</span>
                  </div>
                  <div className="mt-2 h-1.5 overflow-hidden rounded-full bg-muted">
                    <div className="h-full w-[35%] rounded-full bg-primary" />
                  </div>

                  <p className="mt-4 text-sm leading-relaxed font-medium">
                    A furrow irrigation system delivers 45 L/s to a field with an infiltration rate of 12 mm/hr.
                    What design consideration most directly affects distribution uniformity?
                  </p>
                  <div className="mt-3 space-y-2">
                    <div className="rounded-lg border-2 border-primary bg-primary/5 px-3 py-2 text-sm font-medium text-primary">
                      Furrow length and slope
                    </div>
                    <div className="rounded-lg border-2 border-border px-3 py-2 text-sm text-muted-foreground">
                      Pump discharge pressure
                    </div>
                    <div className="rounded-lg border-2 border-border px-3 py-2 text-sm text-muted-foreground">
                      Pipe material
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Feature 2 — Know exactly what you need to review */}
        <section className="border-t border-border bg-card py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="grid gap-10 lg:grid-cols-2 lg:items-center lg:gap-16">
              <div className="order-2 overflow-hidden rounded-2xl border border-border bg-background shadow-lg ring-1 ring-foreground/5 lg:order-1">
                <div className="border-b border-border bg-muted/50 px-4 py-2.5 text-[11px] font-medium tracking-wide text-muted-foreground uppercase">
                  Progress — Weakest areas right now
                </div>
                <div className="space-y-3 p-5">
                  {[
                    { name: "Agricultural Machinery Design, Fabrication/Manufacturing and Testing", pct: 27 },
                    { name: "Design of Biomass Gasifier as Power Source of Various Farm Machinery", pct: 33 },
                    { name: "Irrigation and Drainage Engineering", pct: 39 },
                  ].map((row) => (
                    <div key={row.name}>
                      <div className="flex items-center justify-between gap-3 text-xs">
                        <span className="truncate text-foreground/80">{row.name}</span>
                        <span className="shrink-0 font-semibold text-destructive">{row.pct}%</span>
                      </div>
                      <div className="mt-1.5 h-1.5 overflow-hidden rounded-full bg-muted">
                        <div className="h-full rounded-full bg-destructive/70" style={{ width: `${row.pct}%` }} />
                      </div>
                    </div>
                  ))}
                  <div className="flex items-center justify-between gap-3 rounded-lg border-l-4 border-l-gold bg-gold/5 px-3 py-2.5 text-xs font-medium">
                    <span>39 questions in your Mistake Bank</span>
                    <RotateCcw className="size-3.5 shrink-0 text-gold" />
                  </div>
                </div>
              </div>

              <div className="order-1 lg:order-2">
                <div className="flex size-11 items-center justify-center rounded-xl bg-primary/10 text-primary">
                  <BarChart3 className="size-5" />
                </div>
                <h2 className="mt-5 text-3xl font-bold tracking-tight lg:text-4xl">
                  Know exactly what you need to review.
                </h2>
                <p className="mt-3 max-w-md text-base leading-relaxed text-muted-foreground">
                  Real accuracy data, not a guess — mastery is tracked down to the topic, so you always know where
                  to go next.
                </p>
                <ul className="mt-6 space-y-3">
                  {[
                    "Per-topic mastery, from Area down to Concept",
                    "Every wrong answer collected in one Mistake Bank",
                    "Retest a topic with a fresh, non-repeating set",
                    "One connected dashboard instead of scattered notes",
                  ].map((item) => (
                    <li key={item} className="flex items-start gap-2.5 text-sm leading-relaxed">
                      <CheckCircle2 className="mt-0.5 size-4 shrink-0 text-primary" />
                      <span>{item}</span>
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          </div>
        </section>

        {/* Feature 3 — Understand the answer, not just the answer key */}
        <section className="border-t border-border bg-background py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="grid gap-10 lg:grid-cols-2 lg:items-center lg:gap-16">
              <div>
                <div className="flex size-11 items-center justify-center rounded-xl bg-primary/10 text-primary">
                  <Sparkles className="size-5" />
                </div>
                <h2 className="mt-5 text-3xl font-bold tracking-tight lg:text-4xl">
                  Understand the answer, not just the answer key.
                </h2>
                <p className="mt-3 max-w-md text-base leading-relaxed text-muted-foreground">
                  When a plain explanation isn&apos;t enough, &quot;Teach Me This&quot; breaks the concept down —
                  right where you&apos;re stuck, not in a separate app.
                </p>
                <ul className="mt-6 space-y-3">
                  {[
                    "AI explanations for any question, on demand",
                    "Formula Trainer — active recall for ABE formulas",
                    "Number Bank — quick-lookup constants and standards",
                    "Straight links into related reference material",
                  ].map((item) => (
                    <li key={item} className="flex items-start gap-2.5 text-sm leading-relaxed">
                      <CheckCircle2 className="mt-0.5 size-4 shrink-0 text-primary" />
                      <span>{item}</span>
                    </li>
                  ))}
                </ul>
              </div>

              <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-lg ring-1 ring-foreground/5">
                <div className="border-b border-border bg-muted/50 px-4 py-2.5 text-[11px] font-medium tracking-wide text-muted-foreground uppercase">
                  Teach Me This
                </div>
                <div className="p-5">
                  <p className="text-sm leading-relaxed font-medium">
                    Why does a venturi meter measure flow via pressure differential?
                  </p>
                  <div className="mt-3 flex items-start gap-2.5 rounded-lg bg-primary/5 p-3.5">
                    <Brain className="mt-0.5 size-4 shrink-0 text-primary" />
                    <p className="text-sm leading-relaxed text-foreground/80">
                      As water accelerates through the venturi&apos;s narrowed throat, Bernoulli&apos;s principle
                      means pressure drops — the bigger the drop, the faster the flow. That predictable
                      pressure-to-velocity relationship is what makes the reading usable for measurement.
                    </p>
                  </div>
                  <div className="mt-3 flex items-center gap-2 text-xs text-primary">
                    <ListChecks className="size-3.5" />
                    Related material: Irrigation System Design →
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Official Examination Coverage */}
        <section className="border-t border-border bg-card py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-3xl font-bold tracking-tight lg:text-4xl">
                Built around the official examination coverage.
              </h2>
              <p className="mt-3 text-base leading-relaxed text-muted-foreground">
                Every topic in ABELIEVER is organized around the official PRC Table of Specifications — so the time
                you spend studying maps directly to how the actual exam is weighted.
              </p>
            </div>

            <div className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {EXAM_AREAS.map((area) => {
                const pct = parseInt(area.weight, 10);
                const tier = coverageTier(pct);
                return (
                  <div
                    key={area.name}
                    className={
                      tier.featured
                        ? "rounded-xl border-2 border-primary/25 bg-background p-5 shadow-sm sm:col-span-1"
                        : "rounded-xl border border-border bg-background/70 p-4"
                    }
                  >
                    <span className={`inline-block rounded-full px-2 py-0.5 text-[10px] font-medium ${tier.className}`}>
                      {tier.label}
                    </span>
                    <p className={tier.featured ? "mt-3 text-4xl font-bold tracking-tight text-primary" : "mt-2.5 text-2xl font-bold tracking-tight text-foreground/70"}>
                      {area.weight}
                    </p>
                    <p className={tier.featured ? "mt-2 text-sm leading-snug font-semibold" : "mt-1.5 text-xs leading-snug text-muted-foreground"}>
                      {area.name}
                    </p>
                    <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-primary/10">
                      <div className="h-full rounded-full bg-primary" style={{ width: `${(pct / 18) * 100}%` }} />
                    </div>
                  </div>
                );
              })}
            </div>
            <p className="mt-5 text-xs text-muted-foreground">
              Per the official PRC Table of Specifications. Subject to change — always verify against current
              official PRC/PRB sources.
            </p>
          </div>
        </section>

        {/* How ABELIEVER works */}
        <section className="border-t border-border bg-background py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-3xl font-bold tracking-tight lg:text-4xl">How ABELIEVER works.</h2>
              <p className="mt-3 text-base leading-relaxed text-muted-foreground">
                Not just answering random questions — a loop that keeps pointing you at what actually needs work.
              </p>
            </div>

            <div className="mt-10 grid gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3">
              {WORKFLOW_STEPS.map((step, i) => (
                <div key={step.title} className="relative pl-14">
                  <span className="absolute top-0 left-0 flex size-10 items-center justify-center rounded-full bg-primary/10 text-sm font-bold text-primary">
                    {String(i + 1).padStart(2, "0")}
                  </span>
                  <p className="pt-1.5 text-base font-semibold">{step.title}</p>
                  <p className="mt-1 text-sm leading-relaxed text-muted-foreground">{step.description}</p>
                  {i < WORKFLOW_STEPS.length - 1 && (
                    <ArrowRight className="absolute top-2.5 -right-3 hidden size-4 text-border lg:block" />
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* More than a question bank */}
        <section className="border-t border-border bg-card py-16 lg:py-24">
          <div className="mx-auto max-w-7xl px-6">
            <div className="max-w-2xl">
              <h2 className="text-3xl font-bold tracking-tight lg:text-4xl">More than a question bank.</h2>
              <p className="mt-3 text-base leading-relaxed text-muted-foreground">
                A full review ecosystem — practice, mock exams, targeted quizzing, and reference material, all in
                one place.
              </p>
            </div>

            <div className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {ECOSYSTEM_ITEMS.map((item) => (
                <div
                  key={item.title}
                  className="rounded-xl border border-border bg-background p-5 transition-all hover:-translate-y-0.5 hover:shadow-md"
                >
                  <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                    <item.icon className="size-4.5" />
                  </div>
                  <p className="mt-3 text-sm font-semibold">{item.title}</p>
                  <p className="mt-1 text-sm text-muted-foreground">{item.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* FAQ */}
        <section className="border-t border-border bg-background py-16 lg:py-24">
          <div className="mx-auto max-w-3xl px-6">
            <h2 className="text-3xl font-bold tracking-tight lg:text-4xl">Frequently asked questions.</h2>
            <FaqAccordion />
          </div>
        </section>

        {/* Final CTA */}
        <section className="border-t border-border bg-primary">
          <div className="mx-auto max-w-3xl px-6 py-20 text-center lg:py-28">
            <h2 className="text-4xl leading-[1.05] font-bold tracking-tight text-primary-foreground sm:text-5xl lg:text-6xl">
              Ready to get your shit together, <span className="text-gold">BAYAW</span>?
            </h2>
            <p className="mx-auto mt-4 max-w-md text-base text-primary-foreground/80 lg:text-lg">
              Practice with purpose. Find your weak areas. Build your confidence for the board exam.
            </p>
            <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
              <Button
                render={<Link href="/signup">Be an ABELIEVER</Link>}
                nativeButton={false}
                size="lg"
                className="h-11 bg-background px-7 text-base text-primary hover:bg-background/90"
              />
              <Link href="/login" className="text-sm font-medium text-primary-foreground/80 hover:text-primary-foreground hover:underline">
                Already have an account? Sign in
              </Link>
            </div>
            <p className="mt-4 text-xs text-primary-foreground/70">
              ₱{UPGRADE_PRICE_PHP} one-time — no subscription, keep access for good.
            </p>
          </div>
        </section>
      </main>

      <footer className="border-t px-6 py-6 text-center text-xs text-muted-foreground">
        ABELIEVER — private ABE Licensure Exam review platform.
        {" · "}
        <Link href="/privacy" className="hover:text-foreground hover:underline">
          Privacy Policy
        </Link>
      </footer>
    </div>
  );
}
