import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { QuizBuilderForm } from "@/app/quiz-builder/quiz-builder-form";
import { PageHeader } from "@/components/page-header";

export default async function QuizBuilderPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>;
}) {
  const { error } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: topics } = await supabase
    .from("topics")
    .select("id, name, exam_areas(name)")
    .order("name");

  const topicOptions = (topics ?? []).map((t) => ({
    id: t.id,
    name: t.name,
    examAreaName: (t.exam_areas as unknown as { name: string } | null)?.name ?? "",
  }));

  return (
    <div className="mx-auto max-w-xl">
      <PageHeader title="Custom Quiz" description="Build a quiz exactly the way you want it." />

      <QuizBuilderForm topics={topicOptions} showNoMatchError={error === "no-match"} />
    </div>
  );
}
