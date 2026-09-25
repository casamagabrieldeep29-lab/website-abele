import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { PageHeader } from "@/components/page-header";
import { derivePaesCategory, PAES_CATEGORY_ORDER } from "@/lib/paes-categories";
import { PaesMasteryView, type PaesMasteryCategory, type PaesMasteryReference } from "./paes-mastery-view";

type PaesMasteryRow = {
  paes_reference: string;
  sample_title: string | null;
  total_attempts: number;
  overall_accuracy: number | null;
  recent_accuracy: number | null;
  mastery: number | null;
  status: PaesMasteryReference["status"];
  last_answered_at: string | null;
};

/** Simple mean of the already-computed per-reference mastery numbers, same rollup progress/page.tsx uses for topic -> subject/area averages. References without enough data (mastery === null) are excluded rather than counted as 0. */
function avgMastery(rows: { mastery: number | null }[]): number | null {
  const scored = rows.filter((r) => r.mastery !== null).map((r) => r.mastery as number);
  if (scored.length === 0) return null;
  return Math.round(scored.reduce((sum, m) => sum + m, 0) / scored.length);
}

export default async function PaesMasteryPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // get_paes_mastery() ships in supabase/patches/029_paes_mastery.sql — a
  // migration that may not be applied to every environment yet. Rather than
  // crash the page over a missing function (Postgres "function ... does not
  // exist" / PostgREST "Could not find the function"), degrade to a pending
  // state, same defensive pattern the hub page uses for reviewer_entries.
  // paes_reference possibly not existing yet.
  const { data: rows, error } = await supabase.rpc("get_paes_mastery");

  if (error) {
    return (
      <div className="mx-auto max-w-3xl space-y-6">
        <PageHeader
          title="PAES Mastery"
          description="Per-standard mastery tracking, built on the same engine as Progress."
        />
        <p className="text-sm text-muted-foreground">
          Mastery tracking will appear here once you&apos;ve answered a few PAES questions.
        </p>
      </div>
    );
  }

  const mastery = (rows ?? []) as PaesMasteryRow[];

  const byCategory = new Map<string, PaesMasteryReference[]>();
  for (const m of mastery) {
    const category = derivePaesCategory(m.paes_reference, m.sample_title ?? m.paes_reference);
    const list = byCategory.get(category) ?? [];
    list.push({
      paesReference: m.paes_reference,
      sampleTitle: m.sample_title,
      totalAttempts: m.total_attempts,
      overallAccuracy: m.overall_accuracy,
      recentAccuracy: m.recent_accuracy,
      mastery: m.mastery,
      status: m.status,
    });
    byCategory.set(category, list);
  }

  const categories: PaesMasteryCategory[] = PAES_CATEGORY_ORDER.filter((c) => byCategory.has(c)).map((c) => {
    const references = byCategory.get(c)!;
    return { category: c, mastery: avgMastery(references), references };
  });

  const scoredReferences = mastery.filter((m) => m.status !== "insufficient_data");
  const weakest: PaesMasteryReference[] = scoredReferences
    .filter((m) => m.status !== "strong")
    .sort((a, b) => (a.mastery ?? 0) - (b.mastery ?? 0))
    .slice(0, 3)
    .map((m) => ({
      paesReference: m.paes_reference,
      sampleTitle: m.sample_title,
      totalAttempts: m.total_attempts,
      overallAccuracy: m.overall_accuracy,
      recentAccuracy: m.recent_accuracy,
      mastery: m.mastery,
      status: m.status,
    }));

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <PageHeader
        title="PAES Mastery"
        description="Per-standard mastery tracking, built on the same engine as Progress."
      />

      {mastery.length === 0 ? (
        <p className="text-sm text-muted-foreground">
          Mastery tracking will appear here once you&apos;ve answered a few PAES questions.
        </p>
      ) : (
        <PaesMasteryView categories={categories} weakest={weakest} />
      )}
    </div>
  );
}
