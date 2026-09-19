"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";

function fieldsFromForm(formData: FormData) {
  const str = (name: string) => {
    const v = String(formData.get(name) ?? "").trim();
    return v || null;
  };
  return {
    kind: String(formData.get("kind") ?? "formula"),
    title: str("title") ?? "",
    topic_id: String(formData.get("topicId") ?? ""),
    subtopic_id: str("subtopicId"),
    formula: str("formula"),
    variables: str("variables"),
    symbol: str("symbol"),
    value: str("value"),
    unit: str("unit"),
    table_content: str("tableContent"),
    description: str("description"),
    notes: str("notes"),
    source: str("source"),
  };
}

export async function createReviewerEntry(formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  const fields = fieldsFromForm(formData);
  if (!fields.title || !fields.topic_id) throw new Error("Title and topic are required.");

  const { error } = await supabase.from("reviewer_entries").insert({ ...fields, status: "draft", created_by: user?.id });
  if (error) throw new Error(error.message);
  revalidatePath("/admin/reviewers");
}

export async function updateReviewerEntry(entryId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const fields = fieldsFromForm(formData);
  if (!fields.title || !fields.topic_id) throw new Error("Title and topic are required.");

  const { error } = await supabase
    .from("reviewer_entries")
    .update({ ...fields, updated_at: new Date().toISOString() })
    .eq("id", entryId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/reviewers");
}

export async function publishReviewerEntry(entryId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("reviewer_entries").update({ status: "published" }).eq("id", entryId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/reviewers");
}

export async function unpublishReviewerEntry(entryId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("reviewer_entries").update({ status: "draft" }).eq("id", entryId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/reviewers");
}

export async function deleteReviewerEntry(entryId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("reviewer_entries").delete().eq("id", entryId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/reviewers");
}
