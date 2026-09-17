import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

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

export default function Home() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <header className="flex items-center justify-between border-b px-6 py-4">
        <span className="text-lg font-bold tracking-tight text-primary">ABELIEVER</span>
        <Button render={<Link href="/login">Sign in</Link>} nativeButton={false} size="sm" />
      </header>

      <main className="flex-1">
        <section className="mx-auto max-w-3xl px-6 py-20 text-center">
          <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
            Your structured ABE board exam study environment
          </h1>
          <p className="mt-4 text-lg text-muted-foreground">
            ABELIEVER is a private review platform for the Philippine Agricultural
            and Biosystems Engineers (ABE) Licensure Examination — organized topic
            review, practice questions, and mock exams built around the official
            examination scope.
          </p>
          <div className="mt-8 flex justify-center gap-3">
            <Button
              render={<Link href="/login">Sign in to your account</Link>}
              nativeButton={false}
              size="lg"
            />
          </div>
          <p className="mt-4 text-xs text-muted-foreground">
            Access is invite-only. Contact your administrator if you need an invite.
          </p>
        </section>

        <section className="mx-auto max-w-3xl px-6 pb-20">
          <Card>
            <CardHeader>
              <CardTitle>Official Examination Coverage</CardTitle>
            </CardHeader>
            <CardContent>
              <ul className="divide-y">
                {EXAM_AREAS.map((area) => (
                  <li key={area.name} className="flex items-center justify-between gap-4 py-3">
                    <span className="text-sm">{area.name}</span>
                    <span className="shrink-0 text-sm font-semibold text-primary">
                      {area.weight}
                    </span>
                  </li>
                ))}
              </ul>
              <p className="mt-4 text-xs text-muted-foreground">
                Per the official PRC Table of Specifications. Subject to change —
                always verify against current official PRC/PRB sources.
              </p>
            </CardContent>
          </Card>
        </section>
      </main>

      <footer className="border-t px-6 py-6 text-center text-xs text-muted-foreground">
        ABELIEVER — private ABE Licensure Exam review platform.
      </footer>
    </div>
  );
}
