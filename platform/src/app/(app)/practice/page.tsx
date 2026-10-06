import { redirect } from "next/navigation";
import Link from "next/link";
import { SlidersHorizontal } from "lucide-react";
import { getAuthContext } from "@/lib/auth/session";
import { getPublishedSnapshot } from "@/lib/published-counts";
import { getTaxonomy } from "@/lib/shared-content";
import { PageHeader } from "@/components/page-header";
import { Button } from "@/components/ui/button";
import { PracticeAreaTabs, type PracticeTopic } from "./practice-area-tabs";
import type { MockArea } from "@/app/mock/actions";

export default async function PracticePage() {
  const { user } = await getAuthContext();
  if (!user) redirect("/login");

  // PostgREST can't embed through a view via a topics(...) join, so fetch
  // topics and published-question counts separately and merge in JS.
  // Topic/subject/area names and per-topic counts are identical for every student,
  // so both come from shared caches (src/lib/shared-content.ts and
  // src/lib/published-counts.ts) rather than being re-downloaded each view.
  const [snapshot, taxonomy] = await Promise.all([getPublishedSnapshot(), getTaxonomy()]);
  const { topics, subjects, examAreas } = taxonomy;

  const countByTopic = new Map<string, number>(Object.entries(snapshot.byTopic));

  const subjectById = new Map((subjects ?? []).map((s) => [s.id, s]));
  const examAreaSortById = new Map((examAreas ?? []).map((a) => [a.id, a.sort_order]));
  const examAreaNameById = new Map((examAreas ?? []).map((a) => [a.id, a.name]));

  const practiceTopics: PracticeTopic[] = (topics ?? []).map((topic) => ({
    id: topic.id,
    name: topic.name,
    mockArea: topic.mock_area as MockArea,
    examAreaId: topic.exam_area_id,
    examAreaName: examAreaNameById.get(topic.exam_area_id) ?? null,
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
