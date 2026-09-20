"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

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

/** Quick / Random: N flashcards drawn from the given Area's published pool. */
export async function startQuickFlashcards(areaTopicId: string, formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const count = Number(formData.get("count") ?? 10);
  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").eq("topic_id", areaTopicId);
  const ids = shuffle((data ?? []).map((c) => c.id)).slice(0, count);
  await redirectToSession(ids);
}

/**
 * By topic (used by Question Bank / dashboard deep-links into one specific
 * MCQ topic). Flashcards only ever live on the Area 1/2/3 umbrella topics,
 * so this maps the given topic to its mock_area and serves that Area's
 * flashcards rather than querying the specific topic id directly (which
 * would always return nothing).
 */
export async function startFlashcardsByTopic(topicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: topic } = await supabase.from("topics").select("mock_area").eq("id", topicId).single();
  if (!topic) await redirectToSession([]);

  const areaNumber = topic!.mock_area.split("_")[1];
  const { data: areaTopic } = await supabase.from("topics").select("id").eq("name", `Area ${areaNumber}`).single();
  if (!areaTopic) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").eq("topic_id", areaTopic!.id);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/**
 * Weak Areas, scoped to one Area 1/2/3 topic. Flashcards live at Area
 * granularity, but real mastery data (get_topic_mastery()) is tracked per
 * fine-grained MCQ topic — so this checks whether ANY of the caller's
 * weak/needs-review topics falls under this Area's mock_area, and if so
 * serves that Area's whole flashcard set. That's the coarsest honest match
 * available given the data shape, not a fabricated finer-grained result.
 */
export async function startWeakAreaFlashcards(areaTopicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: areaTopic } = await supabase.from("topics").select("mock_area").eq("id", areaTopicId).single();
  const { data: mastery } = await supabase.rpc("get_topic_mastery");
  const weakTopicIds = (mastery ?? [])
    .filter((m: { status: string }) => m.status === "needs_review" || m.status === "developing")
    .map((m: { topic_id: string }) => m.topic_id);

  if (!areaTopic || weakTopicIds.length === 0) await redirectToSession([]);

  const { data: weakTopics } = await supabase.from("topics").select("mock_area").in("id", weakTopicIds);
  const hasWeakInArea = (weakTopics ?? []).some((t) => t.mock_area === areaTopic!.mock_area);
  if (!hasWeakInArea) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").eq("topic_id", areaTopicId);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/** Mistakes, scoped to one Area 1/2/3 topic — same reasoning as Weak Areas above. */
export async function startMistakeFlashcards(areaTopicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: areaTopic } = await supabase.from("topics").select("mock_area").eq("id", areaTopicId).single();
  const { data: mistakes } = await supabase.rpc("get_mistake_bank");
  const mistakeTopicIds = [...new Set((mistakes ?? []).map((m: { topic_id: string }) => m.topic_id))];

  if (!areaTopic || mistakeTopicIds.length === 0) await redirectToSession([]);

  const { data: mistakeTopics } = await supabase.from("topics").select("mock_area").in("id", mistakeTopicIds);
  const hasMistakeInArea = (mistakeTopics ?? []).some((t) => t.mock_area === areaTopic!.mock_area);
  if (!hasMistakeInArea) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").eq("topic_id", areaTopicId);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/** Saved flashcards (bookmarked via `is_saved` on flashcard_progress), scoped to one Area. */
export async function startSavedFlashcards(areaTopicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: saved } = await supabase
    .from("flashcard_progress")
    .select("flashcard_id")
    .eq("user_id", user.id)
    .eq("is_saved", true);
  const savedIds = (saved ?? []).map((p) => p.flashcard_id);
  if (savedIds.length === 0) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("topic_id", areaTopicId).in("id", savedIds);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
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
