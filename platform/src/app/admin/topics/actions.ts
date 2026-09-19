"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";

function friendlyError(error: { message: string; code?: string }): string {
  if (error.code === "23503") {
    return "Can't delete this — questions still reference it. Move or delete those first.";
  }
  return error.message;
}

export async function createTopic(examAreaId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  const mockArea = String(formData.get("mockArea") ?? "area_3");
  if (!name) throw new Error("Topic name is required.");

  const { error } = await supabase
    .from("topics")
    .insert({ exam_area_id: examAreaId, name, mock_area: mockArea });
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}

export async function renameTopic(topicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  const mockArea = String(formData.get("mockArea") ?? "");
  if (!name) throw new Error("Topic name is required.");

  const { error } = await supabase
    .from("topics")
    .update({ name, mock_area: mockArea })
    .eq("id", topicId);
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}

export async function deleteTopic(topicId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("topics").delete().eq("id", topicId);
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}

export async function createSubtopic(topicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) throw new Error("Subtopic name is required.");

  const { error } = await supabase.from("subtopics").insert({ topic_id: topicId, name });
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}

export async function renameSubtopic(subtopicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) throw new Error("Subtopic name is required.");

  const { error } = await supabase.from("subtopics").update({ name }).eq("id", subtopicId);
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}

export async function deleteSubtopic(subtopicId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("subtopics").delete().eq("id", subtopicId);
  if (error) throw new Error(friendlyError(error));
  revalidatePath("/admin/topics");
}
