"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";

export async function createFlashcard(formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const front = String(formData.get("front") ?? "").trim();
  const back = String(formData.get("back") ?? "").trim();
  const topicId = String(formData.get("topicId") ?? "");
  const subtopicId = String(formData.get("subtopicId") ?? "").trim() || null;
  const source = String(formData.get("source") ?? "").trim() || null;
  if (!front || !back || !topicId) throw new Error("Front, back, and topic are required.");

  const { error } = await supabase
    .from("flashcards")
    .insert({ front, back, topic_id: topicId, subtopic_id: subtopicId, source, status: "draft", created_by: user?.id });
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}

export async function updateFlashcard(flashcardId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();

  const front = String(formData.get("front") ?? "").trim();
  const back = String(formData.get("back") ?? "").trim();
  const topicId = String(formData.get("topicId") ?? "");
  const subtopicId = String(formData.get("subtopicId") ?? "").trim() || null;
  const source = String(formData.get("source") ?? "").trim() || null;
  if (!front || !back || !topicId) throw new Error("Front, back, and topic are required.");

  const { error } = await supabase
    .from("flashcards")
    .update({ front, back, topic_id: topicId, subtopic_id: subtopicId, source, updated_at: new Date().toISOString() })
    .eq("id", flashcardId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}

export async function publishFlashcard(flashcardId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("flashcards").update({ status: "published" }).eq("id", flashcardId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}

export async function unpublishFlashcard(flashcardId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("flashcards").update({ status: "draft" }).eq("id", flashcardId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}

export async function publishAllDraftFlashcards(topicId?: string) {
  await requireAdmin();
  const supabase = await createClient();
  let query = supabase.from("flashcards").update({ status: "published" }).eq("status", "draft");
  if (topicId) query = query.eq("topic_id", topicId);
  const { error } = await query;
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}

export async function deleteFlashcard(flashcardId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("flashcards").delete().eq("id", flashcardId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/flashcards");
}
