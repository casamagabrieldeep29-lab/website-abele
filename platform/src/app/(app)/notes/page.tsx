import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { NotesList, type NoteRow } from "@/app/notes/notes-list";
import { BookmarksList, type BookmarkRow } from "@/app/notes/bookmarks-list";
import { PageHeader } from "@/components/page-header";

export default async function NotesPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data, error }, { data: bookmarkData, error: bookmarkError }] = await Promise.all([
    supabase.rpc("get_my_notes"),
    supabase.rpc("get_my_bookmarks"),
  ]);

  if (error) {
    return <p className="text-sm text-destructive">Couldn&apos;t load notes: {error.message}</p>;
  }
  if (bookmarkError) {
    return <p className="text-sm text-destructive">Couldn&apos;t load bookmarks: {bookmarkError.message}</p>;
  }

  const rows = (data ?? []) as NoteRow[];
  const bookmarkRows = (bookmarkData ?? []) as BookmarkRow[];

  return (
    <div className="mx-auto w-full max-w-4xl space-y-8">
      <PageHeader
        title="Saved"
        description="Questions you've bookmarked, and private reminders you've attached in Practice."
      />

      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">Saved Questions</h2>
        <BookmarksList rows={bookmarkRows} />
      </div>

      <div>
        <h2 className="text-sm font-semibold text-muted-foreground">My Notes</h2>
        <NotesList rows={rows} />
      </div>
    </div>
  );
}
