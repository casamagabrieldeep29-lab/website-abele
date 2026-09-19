"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase/server";

export async function setBookmark(questionId: string, bookmarked: boolean) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not signed in.");

  if (!bookmarked) {
    const { error } = await supabase
      .from("bookmarks")
      .delete()
      .eq("user_id", user.id)
      .eq("question_id", questionId);
    if (error) throw new Error(error.message);
    revalidatePath("/notes");
    return;
  }

  const { error } = await supabase
    .from("bookmarks")
    .upsert({ user_id: user.id, question_id: questionId }, { onConflict: "user_id,question_id" });
  if (error) throw new Error(error.message);
  revalidatePath("/notes");
}
