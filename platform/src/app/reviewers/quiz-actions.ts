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

async function redirectToQuiz(basePath: string, ids: string[]) {
  if (ids.length === 0) {
    redirect(`${basePath}?empty=1`);
  }
  redirect(`${basePath}/session?ids=${ids.slice(0, MAX_SESSION_SIZE).join(",")}`);
}

async function startKindQuiz(basePath: string, kinds: string[], formData: FormData, requirePaesReference = false) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const count = Number(formData.get("count") ?? 10);
  let query = supabase.from("reviewer_entries").select("id").eq("status", "published").in("kind", kinds);
  if (requirePaesReference) query = query.not("paes_reference", "is", null);
  const { data } = await query;
  const ids = shuffle((data ?? []).map((e) => e.id)).slice(0, count);
  await redirectToQuiz(basePath, ids);
}

/** Formula Trainer: quizzes the 900+ published formula reviewer_entries. */
export async function startFormulaQuiz(formData: FormData) {
  await startKindQuiz("/reviewers/quiz", ["formula"], formData);
}

/** Number Bank Quiz: same scope as /paes/numbers (constant + table kinds, tagged with a paes_reference — the "Number Bank" is specifically the PAES-standard-sourced quick lookups, not every general reviewer constant). */
export async function startNumberBankQuiz(formData: FormData) {
  await startKindQuiz("/paes/numbers/quiz", ["constant", "table"], formData, true);
}

async function startSavedKindQuiz(basePath: string, kinds: string[], requirePaesReference = false) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: saved } = await supabase
    .from("reviewer_entry_progress")
    .select("entry_id")
    .eq("user_id", user.id)
    .eq("is_saved", true);
  const savedIds = (saved ?? []).map((p) => p.entry_id);
  if (savedIds.length === 0) await redirectToQuiz(basePath, []);

  let query = supabase.from("reviewer_entries").select("id").eq("status", "published").in("kind", kinds).in("id", savedIds);
  if (requirePaesReference) query = query.not("paes_reference", "is", null);
  const { data } = await query;
  await redirectToQuiz(basePath, shuffle((data ?? []).map((e) => e.id)));
}

export async function startSavedFormulaQuiz() {
  await startSavedKindQuiz("/reviewers/quiz", ["formula"]);
}

export async function startSavedNumberBankQuiz() {
  await startSavedKindQuiz("/paes/numbers/quiz", ["constant", "table"], true);
}

export async function reviewReviewerEntry(entryId: string, state: "know" | "learning" | "dont_know") {
  const supabase = await createClient();
  const { error } = await supabase.rpc("record_reviewer_entry_review", { p_entry_id: entryId, p_state: state });
  if (error) throw new Error(error.message);
}

export async function toggleSavedReviewerEntry(entryId: string, saved: boolean) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not signed in.");

  const { error } = await supabase
    .from("reviewer_entry_progress")
    .upsert({ user_id: user.id, entry_id: entryId, is_saved: saved }, { onConflict: "user_id,entry_id" });
  if (error) throw new Error(error.message);
}
