import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { MistakeBankView, type MistakeRow } from "@/app/mistakes/mistake-bank-view";
import { PageHeader } from "@/components/page-header";

export default async function MistakesPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data, error }, { data: topics }, { data: examAreas }] = await Promise.all([
    supabase.rpc("get_mistake_bank"),
    supabase.from("topics").select("id, exam_area_id"),
    supabase.from("exam_areas").select("id, name").order("sort_order"),
  ]);

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load mistake bank: {error.message}</p>;
  }

  const examAreaIdByTopic = new Map((topics ?? []).map((t) => [t.id, t.exam_area_id]));
  const areaNameById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));

  const rows: MistakeRow[] = (data ?? []).map((r: Omit<MistakeRow, "exam_area_id" | "exam_area_name">) => {
    const examAreaId = examAreaIdByTopic.get(r.topic_id) ?? "unknown";
    return {
      ...r,
      exam_area_id: examAreaId,
      exam_area_name: areaNameById.get(examAreaId) ?? "Unknown area",
    };
  });

  return (
    <div className="mx-auto max-w-2xl">
      <PageHeader
        title="Mistakes"
        description="Questions whose most recent answer was incorrect. Get one right on retry and it drops off this list."
      />

      <MistakeBankView rows={rows} />
    </div>
  );
}
