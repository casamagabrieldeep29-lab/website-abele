import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { fetchAnswerSummary } from "@/lib/study-stats";
import { getAIProvider, AIProviderError, AI_DAILY_LIMIT, AI_TRIAL_DAILY_LIMIT, buildAiLimitMessage } from "@/lib/ai";
import { buildStudyAssistantPrompt, buildStudyAssistantSystemInstruction, type StudyAssistantContext } from "@/lib/ai/prompts";
import { checkRateLimit } from "@/lib/rate-limit";
import { logError } from "@/lib/log-error";
import { fetchTopicMastery } from "@/lib/mastery";

const FRIENDLY_ERROR = "AI explanation is temporarily unavailable. Please try again.";
const MAX_QUESTION_LENGTH = 500;

// Same burst cap as /api/ai/teach-me — see that file's comment.
const AI_BURST_LIMIT = 8;
const AI_BURST_WINDOW_SECONDS = 60;

type TopicMasteryRow = {
  topic_name: string;
  exam_area_name: string;
  mastery: number | null;
  status: string;
};

export async function POST(req: NextRequest) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }

  const provider = getAIProvider();
  if (!provider) {
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 503 });
  }

  const burstAllowed = await checkRateLimit(`ai-burst:${user.id}`, AI_BURST_LIMIT, AI_BURST_WINDOW_SECONDS);
  if (!burstAllowed) {
    return NextResponse.json({ error: "You're sending requests too quickly. Please wait a moment." }, { status: 429 });
  }

  let body: { question?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request." }, { status: 400 });
  }

  const question = body.question?.trim().slice(0, MAX_QUESTION_LENGTH);
  if (!question) {
    return NextResponse.json({ error: "Ask a question first." }, { status: 400 });
  }

  const { data: usage, error: usageError } = await supabase.rpc("check_and_log_ai_usage", {
    p_daily_limit: AI_DAILY_LIMIT,
    p_trial_daily_limit: AI_TRIAL_DAILY_LIMIT,
  });
  if (usageError) {
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
  const usageRow = Array.isArray(usage) ? usage[0] : usage;
  if (!usageRow?.allowed) {
    return NextResponse.json({ error: buildAiLimitMessage(usageRow?.limit_reason) }, { status: 429 });
  }

  const [{ data: masteryRows }, answerSummary, { count: mistakeTotal }] = await Promise.all([
    fetchTopicMastery(supabase),
    fetchAnswerSummary(supabase, user.id),
    // Only the count is used — HEAD + exact count avoids downloading every mistake's text.
    supabase.rpc("get_mistake_bank", undefined, { head: true, count: "exact" }),
  ]);

  const mastery = (masteryRows ?? []) as TopicMasteryRow[];
  const context: StudyAssistantContext = {
    questionsAnswered: answerSummary.total,
    overallAccuracy: answerSummary.total ? Math.round((100 * answerSummary.correct) / answerSummary.total) : null,
    mistakeCount: mistakeTotal ?? 0,
    topicMastery: mastery.map((m) => ({
      topicName: m.topic_name,
      examAreaName: m.exam_area_name,
      mastery: m.mastery,
      status: m.status,
    })),
  };

  try {
    const text = await provider.generate({
      systemInstruction: buildStudyAssistantSystemInstruction(),
      prompt: buildStudyAssistantPrompt(context, question),
    });
    return NextResponse.json({ text, remaining: usageRow.remaining });
  } catch (err) {
    await logError("study-assistant", err);
    if (err instanceof AIProviderError) {
      return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 502 });
    }
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
}
