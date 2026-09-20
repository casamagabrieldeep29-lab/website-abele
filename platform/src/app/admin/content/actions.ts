"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";

export async function publishQuestion(questionId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase
    .from("questions")
    .update({ status: "published" })
    .eq("id", questionId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/content");
}

export async function unpublishQuestion(questionId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase
    .from("questions")
    .update({ status: "draft" })
    .eq("id", questionId);
  if (error) throw new Error(error.message);
  revalidatePath("/admin/content");
}

export async function publishAllInTopic(topicId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase
    .from("questions")
    .update({ status: "published" })
    .eq("topic_id", topicId)
    .eq("status", "draft");
  if (error) throw new Error(error.message);
  revalidatePath("/admin/content");
}

/**
 * Manual admin judgment call: tag a question into an ADDITIONAL real
 * board-exam area beyond its topic's default `mock_area`, when the
 * question's content is topically relevant there too (e.g. an Engineering
 * Economy question about machinery costs, also relevant to Area 1). Never
 * automatic — content accuracy over convenience.
 */
export async function setQuestionAdditionalMockAreas(questionId: string, topicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const areas = formData.getAll("additionalMockAreas").map(String);
  const { error } = await supabase
    .from("questions")
    .update({ additional_mock_areas: areas })
    .eq("id", questionId);
  if (error) throw new Error(error.message);
  revalidatePath(`/admin/content/${topicId}`);
}

export async function updateQuestion(questionId: string, topicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();

  const questionText = String(formData.get("questionText") ?? "").trim();
  const difficulty = String(formData.get("difficulty") ?? "") || null;
  const explanation = String(formData.get("explanation") ?? "").trim() || null;
  const seriesKey = String(formData.get("seriesKey") ?? "").trim() || null;
  const seriesPositionRaw = String(formData.get("seriesPosition") ?? "").trim();
  const seriesPosition = seriesKey && seriesPositionRaw ? Number(seriesPositionRaw) : null;
  const categoryRaw = String(formData.get("category") ?? "");
  const category = categoryRaw === "term" || categoryRaw === "solving" ? categoryRaw : null;
  if (!questionText) throw new Error("Question text is required.");

  const { error: qErr } = await supabase
    .from("questions")
    .update({
      question_text: questionText,
      difficulty,
      explanation,
      series_key: seriesKey,
      series_position: seriesPosition,
      category,
      updated_at: new Date().toISOString(),
    })
    .eq("id", questionId);
  if (qErr) throw new Error(qErr.message);

  const choiceIds = formData.getAll("choiceId").map(String);
  const choiceTexts = formData.getAll("choiceText").map(String);
  const correctIds = new Set(formData.getAll("correctChoiceId").map(String));

  for (let i = 0; i < choiceIds.length; i++) {
    const { error } = await supabase
      .from("choices")
      .update({ choice_text: choiceTexts[i]?.trim() ?? "", is_correct: correctIds.has(choiceIds[i]) })
      .eq("id", choiceIds[i]);
    if (error) throw new Error(error.message);
  }

  revalidatePath(`/admin/content/${topicId}`);
}

export async function archiveQuestion(questionId: string, topicId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("questions").update({ status: "archived" }).eq("id", questionId);
  if (error) throw new Error(error.message);
  revalidatePath(`/admin/content/${topicId}`);
}

export async function unarchiveQuestion(questionId: string, topicId: string) {
  await requireAdmin();
  const supabase = await createClient();
  const { error } = await supabase.from("questions").update({ status: "draft" }).eq("id", questionId);
  if (error) throw new Error(error.message);
  revalidatePath(`/admin/content/${topicId}`);
}

export async function createQuestion(topicId: string, formData: FormData) {
  await requireAdmin();
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const questionText = String(formData.get("questionText") ?? "").trim();
  const difficulty = String(formData.get("difficulty") ?? "") || null;
  const explanation = String(formData.get("explanation") ?? "").trim() || null;
  const seriesKey = String(formData.get("seriesKey") ?? "").trim() || null;
  const seriesPositionRaw = String(formData.get("seriesPosition") ?? "").trim();
  const seriesPosition = seriesKey && seriesPositionRaw ? Number(seriesPositionRaw) : null;
  const categoryRaw = String(formData.get("category") ?? "");
  const category = categoryRaw === "term" || categoryRaw === "solving" ? categoryRaw : null;
  if (!questionText) throw new Error("Question text is required.");

  const { data: newQuestion, error: qErr } = await supabase
    .from("questions")
    .insert({
      topic_id: topicId,
      question_text: questionText,
      difficulty,
      explanation,
      series_key: seriesKey,
      series_position: seriesPosition,
      category,
      status: "draft",
      created_by: user?.id,
    })
    .select("id")
    .single();
  if (qErr || !newQuestion) throw new Error(qErr?.message ?? "Failed to create question.");

  const choiceTexts = formData.getAll("newChoiceText").map(String);
  const correctIndexes = new Set(formData.getAll("newCorrectIndex").map(String));

  const choiceRows = choiceTexts
    .map((text, i) => ({
      question_id: newQuestion.id,
      choice_text: text.trim(),
      is_correct: correctIndexes.has(String(i)),
      sort_order: i,
    }))
    .filter((c) => c.choice_text);

  if (choiceRows.length > 0) {
    const { error: cErr } = await supabase.from("choices").insert(choiceRows);
    if (cErr) throw new Error(cErr.message);
  }

  revalidatePath(`/admin/content/${topicId}`);
}
