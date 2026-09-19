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

/** Quick / Random: N flashcards drawn from the whole published pool. */
export async function startQuickFlashcards(formData: FormData) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const count = Number(formData.get("count") ?? 10);
  const { data } = await supabase.from("flashcards").select("id").eq("status", "published");
  const ids = shuffle((data ?? []).map((c) => c.id)).slice(0, count);
  await redirectToSession(ids);
}

/** By exam area (the existing top-level taxonomy — "Subject/Area" in the spec). */
export async function startFlashcardsByArea(examAreaId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: topics } = await supabase.from("topics").select("id").eq("exam_area_id", examAreaId);
  const topicIds = (topics ?? []).map((t) => t.id);
  if (topicIds.length === 0) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").in("topic_id", topicIds);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/** By topic. */
export async function startFlashcardsByTopic(topicId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").eq("topic_id", topicId);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/**
 * Weak Areas: flashcards for topics the caller's REAL mastery data (existing
 * get_topic_mastery() RPC) flags as "developing" or "needs_review". No
 * fabricated mastery — reuses the same RPC the dashboard/progress pages do.
 */
export async function startWeakAreaFlashcards() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: mastery } = await supabase.rpc("get_topic_mastery");
  const weakTopicIds = (mastery ?? [])
    .filter((m: { status: string }) => m.status === "needs_review" || m.status === "developing")
    .map((m: { topic_id: string }) => m.topic_id);

  if (weakTopicIds.length === 0) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").in("topic_id", weakTopicIds);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/**
 * Mistakes: flashcards for topics that currently show up in the caller's
 * REAL mistake bank (existing get_mistake_bank() RPC).
 */
export async function startMistakeFlashcards() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: mistakes } = await supabase.rpc("get_mistake_bank");
  const topicIds = [...new Set((mistakes ?? []).map((m: { topic_id: string }) => m.topic_id))];

  if (topicIds.length === 0) await redirectToSession([]);

  const { data } = await supabase.from("flashcards").select("id").eq("status", "published").in("topic_id", topicIds);
  await redirectToSession(shuffle((data ?? []).map((c) => c.id)));
}

/** Saved flashcards (bookmarked via `is_saved` on flashcard_progress). */
export async function startSavedFlashcards() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data } = await supabase
    .from("flashcard_progress")
    .select("flashcard_id")
    .eq("user_id", user.id)
    .eq("is_saved", true);
  await redirectToSession(shuffle((data ?? []).map((p) => p.flashcard_id)));
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
