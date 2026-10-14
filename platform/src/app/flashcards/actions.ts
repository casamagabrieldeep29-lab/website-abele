"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { fetchTopicMastery } from "@/lib/mastery";
import { fetchAreaTopicIds, isFlashcardAreaKey } from "@/lib/flashcard-areas";

const MAX_SESSION_SIZE = 50;

function shuffle<T>(arr: T[]): T[] {
  const copy = [...arr];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

async function redirectToSession(ids: string[]) {
  if (ids.length === 0) {
    redirect("/flashcards?empty=1");
  }
  redirect(`/flashcards/study?ids=${ids.slice(0, MAX_SESSION_SIZE).join(",")}`);
}

/** Back to the area page (not the picker) when a mode finds nothing. */
async function redirectEmpty(areaKey: string) {
  redirect(`/flashcards?area=${areaKey}&empty=1`);
}

async function requireUser() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");
  return { supabase, user };
}

/** Published card ids on the given topics. */
async function publishedCardIds(supabase: Awaited<ReturnType<typeof createClient>>, topicIds: string[]) {
  if (topicIds.length === 0) return [];
  const { data } = await supabase
    .from("flashcards")
    .select("id")
    .eq("status", "published")
    .in("topic_id", topicIds);
  return (data ?? []).map((c) => c.id as string);
}

/** Quick / Random: N flashcards drawn from the given Area's published pool. */
export async function startQuickFlashcards(areaKey: string, formData: FormData) {
  if (!isFlashcardAreaKey(areaKey)) redirect("/flashcards");
  const { supabase } = await requireUser();

  const count = Number(formData.get("count") ?? 10);
  const ids = shuffle(await publishedCardIds(supabase, await fetchAreaTopicIds(supabase, areaKey))).slice(0, count);
  if (ids.length === 0) await redirectEmpty(areaKey);
  await redirectToSession(ids);
}

/**
 * By topic (Question Bank / dashboard deep-links into one specific topic).
 * Cards live on the real topics, so serve that topic's own cards; if the
 * topic has none, fall back to the rest of its Area.
 */
export async function startFlashcardsByTopic(topicId: string) {
  const { supabase } = await requireUser();

  const own = await publishedCardIds(supabase, [topicId]);
  if (own.length > 0) await redirectToSession(shuffle(own));

  const { data: topic } = await supabase.from("topics").select("mock_area").eq("id", topicId).single();
  if (!topic) await redirectToSession([]);
  const ids = await publishedCardIds(supabase, await fetchAreaTopicIds(supabase, topic!.mock_area));
  await redirectToSession(shuffle(ids));
}

/** Weak Areas: cards on the Area's topics the caller is weak in (developing / needs review). */
export async function startWeakAreaFlashcards(areaKey: string) {
  if (!isFlashcardAreaKey(areaKey)) redirect("/flashcards");
  const { supabase } = await requireUser();

  const [areaTopicIds, { data: mastery }] = await Promise.all([
    fetchAreaTopicIds(supabase, areaKey),
    fetchTopicMastery(supabase),
  ]);
  const inArea = new Set(areaTopicIds);
  const weakTopicIds = (mastery ?? [])
    .filter((m: { status: string }) => m.status === "needs_review" || m.status === "developing")
    .map((m: { topic_id: string }) => m.topic_id)
    .filter((id: string) => inArea.has(id));

  const ids = await publishedCardIds(supabase, weakTopicIds);
  if (ids.length === 0) await redirectEmpty(areaKey);
  await redirectToSession(shuffle(ids));
}

/** Mistakes: cards on the Area's topics that currently appear in the caller's Mistake Bank. */
export async function startMistakeFlashcards(areaKey: string) {
  if (!isFlashcardAreaKey(areaKey)) redirect("/flashcards");
  const { supabase } = await requireUser();

  const [areaTopicIds, { data: mistakes }] = await Promise.all([
    fetchAreaTopicIds(supabase, areaKey),
    supabase.rpc("get_mistake_bank"),
  ]);
  const inArea = new Set(areaTopicIds);
  const mistakeTopicIds = [...new Set((mistakes ?? []).map((m: { topic_id: string }) => m.topic_id))].filter((id) =>
    inArea.has(id as string),
  ) as string[];

  const ids = await publishedCardIds(supabase, mistakeTopicIds);
  if (ids.length === 0) await redirectEmpty(areaKey);
  await redirectToSession(shuffle(ids));
}

/** Saved flashcards (bookmarked via `is_saved` on flashcard_progress), scoped to one Area. */
export async function startSavedFlashcards(areaKey: string) {
  if (!isFlashcardAreaKey(areaKey)) redirect("/flashcards");
  const { supabase, user } = await requireUser();

  const { data: saved } = await supabase
    .from("flashcard_progress")
    .select("flashcard_id")
    .eq("user_id", user.id)
    .eq("is_saved", true);
  const savedIds = (saved ?? []).map((p) => p.flashcard_id);
  if (savedIds.length === 0) await redirectEmpty(areaKey);

  const areaTopicIds = await fetchAreaTopicIds(supabase, areaKey);
  if (areaTopicIds.length === 0) await redirectEmpty(areaKey);
  const { data } = await supabase.from("flashcards").select("id").in("topic_id", areaTopicIds).in("id", savedIds);
  const ids = (data ?? []).map((c) => c.id as string);
  if (ids.length === 0) await redirectEmpty(areaKey);
  await redirectToSession(shuffle(ids));
}

export async function reviewFlashcard(flashcardId: string, state: "know" | "learning" | "dont_know") {
  const supabase = await createClient();
  const { error } = await supabase.rpc("record_flashcard_review", { p_flashcard_id: flashcardId, p_state: state });
  if (error) throw new Error(error.message);
}

export async function toggleSavedFlashcard(flashcardId: string, saved: boolean) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not signed in.");

  const { error } = await supabase
    .from("flashcard_progress")
    .upsert({ user_id: user.id, flashcard_id: flashcardId, is_saved: saved }, { onConflict: "user_id,flashcard_id" });
  if (error) throw new Error(error.message);
}
