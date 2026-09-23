import { redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth/session";
import { PageHeader } from "@/components/page-header";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { startPaesQuizAttempt } from "@/app/practice/actions";

const QUIZ_SIZE_CAP = 50;

const DOCUMENTS = [
  {
    title: "PAES Agricultural Structures 401-414",
    description: "Definitions and terminology reference for the PAES 400-series structures standards.",
    href: "/paes/paes-agricultural-structures-401-414.pdf",
  },
  {
    title: "PAES Production Machinery 101-106",
    description: "Definitions and terminology reference for the PAES 100-series machinery standards.",
    href: "/paes/paes-production-machinery-101-106.pdf",
  },
  {
    title: "Green Gears — PAES Structures and Post-Harvest Machineries",
    description: "Final coaching deck covering PAES standards for structures and post-harvest machinery.",
    href: "/paes/green-gears-paes-structures-and-post-harvest.pdf",
  },
];

export default async function PaesPage() {
  const { supabase, user } = await getAuthContext();
  if (!user) redirect("/login");

  const { count: paesQuestionCount } = await supabase
    .from("student_questions")
    .select("id", { count: "exact", head: true })
    .eq("is_paes", true);

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <PageHeader
        title="PAES"
        description="Philippine Agricultural Engineering Standards — reference documents plus a quiz drawn from questions that specifically test PAES standards."
      />

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Take PAES Quiz</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            {paesQuestionCount
              ? `${paesQuestionCount} published question${paesQuestionCount === 1 ? "" : "s"} testing PAES standards.`
              : "No published PAES questions yet."}
          </p>
          <form action={startPaesQuizAttempt.bind(null, QUIZ_SIZE_CAP)} className="mt-3">
            <Button type="submit" disabled={!paesQuestionCount}>
              Start PAES Quiz
            </Button>
          </form>
        </CardContent>
      </Card>

      <div className="space-y-3">
        <h2 className="text-sm font-semibold text-muted-foreground">Reference documents</h2>
        {DOCUMENTS.map((doc) => (
          <Card key={doc.href}>
            <CardHeader>
              <CardTitle className="text-base">{doc.title}</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm text-muted-foreground">{doc.description}</p>
              <a
                href={doc.href}
                target="_blank"
                rel="noopener noreferrer"
                className="mt-3 inline-block text-sm font-medium text-primary hover:underline"
              >
                Open PDF →
              </a>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
