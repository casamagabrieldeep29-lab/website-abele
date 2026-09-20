"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth/require-admin";
import { createClient } from "@/lib/supabase/server";
import { getAIProvider } from "@/lib/ai";
import { buildCategorizeQuestionsPrompt, buildCategorizeQuestionsSystemInstruction } from "@/lib/ai/prompts";

const CATEGORIZE_BATCH_SIZE = 25;

/**
 * Classifies one batch of uncategorized questions (Term/Solving) via AI and
 * returns how many were processed and how many remain — called repeatedly
 * from the client (see auto-categorize-panel.tsx) rather than trying to
 * process everything in one request, since a bulk run over hundreds of
 * questions would exceed a serverless function's execution time budget.
 * Admin-only bulk content management, not a student-facing feature, so it
 * doesn't go through check_and_log_ai_usage (that's the per-student daily
 * Teach-Me/Study-Assistant quota, unrelated to this).
 */
export async function autoCategorizeBatch(): Promise<{ processed: number; remaining: number; error?: string }> {
  await requireAdmin();
  const supabase = await createClient();

  const provider = getAIProvider();
  if (!provider) {
    return { processed: 0, remaining: 0, error: "AI provider isn't configured (GEMINI_API_KEY missing)." };
  }

  const { data: batch } = await supabase
    .from("questions")
    .select("id, question_text")
    .is("category", null)
    .neq("status", "archived")
    .order("created_at")
    .limit(CATEGORIZE_BATCH_SIZE);

  if (!batch || batch.length === 0) {
    return { processed: 0, remaining: 0 };
  }

  const indexed = batch.map((q, i) => ({ index: i + 1, text: q.question_text }));

  let classifications: { index: number; category: string }[];
  try {
    const raw = await provider.generate({
      systemInstruction: buildCategorizeQuestionsSystemInstruction(),
      prompt: buildCategorizeQuestionsPrompt(indexed),
    });
    const cleaned = raw.trim().replace(/^```(?:json)?\n?/, "").replace(/\n?```$/, "");
    classifications = JSON.parse(cleaned);
  } catch {
    return { processed: 0, remaining: batch.length, error: "AI classification failed for this batch — try again." };
  }

  let processed = 0;
  for (const item of classifications) {
    const question = batch[item.index - 1];
    if (!question) continue;
    const category = item.category === "term" || item.category === "solving" ? item.category : null;
    if (!category) continue;
    const { error } = await supabase.from("questions").update({ category }).eq("id", question.id);
    if (!error) processed++;
  }

  const { count: remaining } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .is("category", null)
    .neq("status", "archived");

  revalidatePath("/admin/content");
  return { processed, remaining: remaining ?? 0 };
}

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
