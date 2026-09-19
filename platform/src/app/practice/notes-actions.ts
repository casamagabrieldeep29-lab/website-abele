"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";

export async function saveNote(questionId: string, noteText: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not signed in.");

  if (!noteText.trim()) {
    const { error } = await supabase
      .from("question_notes")
      .delete()
      .eq("user_id", user.id)
      .eq("question_id", questionId);
    if (error) throw new Error(error.message);
    return;
  }

  const { error } = await supabase
    .from("question_notes")
    .upsert(
      { user_id: user.id, question_id: questionId, note_text: noteText.trim(), updated_at: new Date().toISOString() },
      { onConflict: "user_id,question_id" },
    );
  if (error) throw new Error(error.message);
  revalidatePath("/notes");
}
