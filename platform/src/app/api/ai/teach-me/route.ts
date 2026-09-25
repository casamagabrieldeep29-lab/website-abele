import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { getAIProvider, AIProviderError, AI_DAILY_LIMIT, AI_TRIAL_DAILY_LIMIT, buildAiLimitMessage } from "@/lib/ai";
import { buildTeachMePrompt, buildTeachMeSystemInstruction, type TeachMeContext } from "@/lib/ai/prompts";

const FRIENDLY_ERROR = "AI explanation is temporarily unavailable. Please try again.";

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

  let body: { attemptId?: string; questionId?: string; followUp?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request." }, { status: 400 });
  }

  const { attemptId, questionId, followUp } = body;
  if (!attemptId || !questionId) {
    return NextResponse.json({ error: "Invalid request." }, { status: 400 });
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

  const { data: contextRows, error: contextError } = await supabase.rpc("get_teach_me_context", {
    p_attempt_id: attemptId,
    p_question_id: questionId,
  });
  if (contextError || !contextRows?.length) {
    return NextResponse.json({ error: "Couldn't load this question's context." }, { status: 400 });
  }
  const row = contextRows[0];
  const context: TeachMeContext = {
    questionText: row.question_text,
    choices: row.choices ?? [],
    explanation: row.explanation,
    topicName: row.topic_name,
    subtopicName: row.subtopic_name,
    examAreaName: row.exam_area_name,
    relevantFormulas: row.relevant_formulas ?? [],
  };

  try {
    const text = await provider.generate({
      systemInstruction: buildTeachMeSystemInstruction(),
      prompt: buildTeachMePrompt(context, followUp),
    });
    return NextResponse.json({ text, remaining: usageRow.remaining });
  } catch (err) {
    console.error("[teach-me] Gemini request failed:", err instanceof Error ? err.message : err);
    if (err instanceof AIProviderError) {
      return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 502 });
    }
    return NextResponse.json({ error: FRIENDLY_ERROR }, { status: 500 });
  }
}
