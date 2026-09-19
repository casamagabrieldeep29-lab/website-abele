import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { FlashcardStudy, type StudyCard } from "./flashcard-study";

export default async function FlashcardStudyPage({
  searchParams,
}: {
  searchParams: Promise<{ ids?: string }>;
}) {
  const { ids } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const idList = (ids ?? "").split(",").filter(Boolean);
  if (idList.length === 0) redirect("/flashcards");

  const [{ data: cards }, { data: topics }, { data: progress }] = await Promise.all([
    supabase.from("flashcards").select("id, front, back, topic_id, source").in("id", idList),
    supabase.from("topics").select("id, name"),
    supabase.from("flashcard_progress").select("flashcard_id, is_saved").eq("user_id", user.id).in("flashcard_id", idList),
  ]);

  const topicById = new Map((topics ?? []).map((t) => [t.id, t.name]));
  const savedIds = new Set((progress ?? []).filter((p) => p.is_saved).map((p) => p.flashcard_id));
  const cardById = new Map((cards ?? []).map((c) => [c.id, c]));

  // Preserve the original (already-shuffled) order from the URL.
  const studyCards: StudyCard[] = idList
    .map((id) => cardById.get(id))
    .filter((c): c is NonNullable<typeof c> => Boolean(c))
    .map((c) => ({
      id: c.id,
      front: c.front,
      back: c.back,
      topicName: topicById.get(c.topic_id) ?? "Unknown topic",
      source: c.source,
      isSaved: savedIds.has(c.id),
    }));

  if (studyCards.length === 0) {
    return (
      <div className="mx-auto max-w-lg text-center">
        <p className="text-sm text-muted-foreground">These flashcards are no longer available.</p>
        <Link href="/flashcards" className="mt-2 inline-block text-sm text-primary hover:underline">
          Back to Flashcards →
        </Link>
      </div>
    );
  }

  return <FlashcardStudy cards={studyCards} />;
}
