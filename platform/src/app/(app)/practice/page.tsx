import { redirect } from "next/navigation";
import Link from "next/link";
import { SlidersHorizontal } from "lucide-react";
import { getAuthContext } from "@/lib/auth/session";
import { getPublishedSnapshot } from "@/lib/published-counts";
import { PageHeader } from "@/components/page-header";
import { Button } from "@/components/ui/button";
import { PracticeAreaTabs, type PracticeTopic } from "./practice-area-tabs";
import type { MockArea } from "@/app/mock/actions";

export default async function PracticePage() {
  const { supabase, user } = await getAuthContext();
  if (!user) redirect("/login");

  // PostgREST can't embed through a view via a topics(...) join, so fetch
  // topics and published-question counts separately and merge in JS.
  const [{ data: topics }, snapshot, { data: subjects }, { data: examAreas }] = await Promise.all([
    supabase.from("topics").select("id, name, mock_area, exam_area_id, subject_id, exam_areas(name)").order("name"),
    // Per-topic counts come from a shared, cached snapshot (see
    // src/lib/published-counts.ts) instead of paging through every
    // published row on each page view.
    getPublishedSnapshot(),
    supabase.from("subjects").select("id, name, sort_order"),
    supabase.from("exam_areas").select("id, sort_order"),
  ]);

  const countByTopic = new Map<string, number>(Object.entries(snapshot.byTopic));

  const subjectById = new Map((subjects ?? []).map((s) => [s.id, s]));
  const examAreaSortById = new Map((examAreas ?? []).map((a) => [a.id, a.sort_order]));

  const practiceTopics: PracticeTopic[] = (topics ?? []).map((topic) => ({
    id: topic.id,
    name: topic.name,
    mockArea: topic.mock_area as MockArea,
    examAreaId: topic.exam_area_id,
    examAreaName: (topic.exam_areas as unknown as { name: string } | null)?.name ?? null,
    examAreaSortOrder: examAreaSortById.get(topic.exam_area_id) ?? 0,
    subjectId: topic.subject_id,
    subjectName: topic.subject_id ? (subjectById.get(topic.subject_id)?.name ?? null) : null,
    subjectSortOrder: topic.subject_id ? (subjectById.get(topic.subject_id)?.sort_order ?? 0) : 0,
    questionCount: countByTopic.get(topic.id) ?? 0,
  }));

  return (
    <div className="mx-auto w-full max-w-5xl">
      <PageHeader
        title="Practice"
        description="Pick a topic. Questions are answered one at a time with immediate feedback."
        action={
          <Button render={<Link href="/quiz-builder" />} nativeButton={false} variant="outline" size="sm">
            <SlidersHorizontal className="size-4" />
            Customize a session
          </Button>
        }
      />

      <div className="mt-6">
        <PracticeAreaTabs topics={practiceTopics} />

        {!practiceTopics.length && (
          <p className="mt-3 text-sm text-muted-foreground">No topics yet.</p>
        )}
      </div>
    </div>
  );
}
