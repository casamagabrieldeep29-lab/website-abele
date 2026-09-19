"use client";

import { useState } from "react";
import { StickyNote } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { saveNote } from "../practice/notes-actions";

export type NoteRow = {
  note_id: string;
  question_id: string;
  question_text: string;
  topic_name: string;
  note_text: string;
  updated_at: string;
};

export function NotesList({ rows: initialRows }: { rows: NoteRow[] }) {
  const [rows, setRows] = useState(initialRows);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [draft, setDraft] = useState("");
  const [confirmingDeleteId, setConfirmingDeleteId] = useState<string | null>(null);

  function startEdit(row: NoteRow) {
    setEditingId(row.question_id);
    setDraft(row.note_text);
  }

  async function save(questionId: string) {
    await saveNote(questionId, draft);
    setRows((prev) =>
      draft.trim()
        ? prev.map((r) => (r.question_id === questionId ? { ...r, note_text: draft.trim() } : r))
        : prev.filter((r) => r.question_id !== questionId),
    );
    setEditingId(null);
  }

  async function remove(questionId: string) {
    await saveNote(questionId, "");
    setRows((prev) => prev.filter((r) => r.question_id !== questionId));
    setConfirmingDeleteId(null);
  }

  if (rows.length === 0) {
    return (
      <p className="mt-8 text-sm text-muted-foreground">
        No notes yet — add one from any question in Practice Mode.
      </p>
    );
  }

  return (
    <div className="mt-6 space-y-3">
      {rows.map((row) => (
        <Card key={row.note_id}>
          <CardContent className="py-3">
            <p className="text-xs text-muted-foreground">{row.topic_name}</p>
            <p className="mt-1 text-sm">{row.question_text}</p>

            {editingId === row.question_id ? (
              <div className="mt-2 space-y-2">
                <textarea
                  value={draft}
                  onChange={(e) => setDraft(e.target.value)}
                  rows={2}
                  className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm"
                  autoFocus
                />
                <div className="flex gap-2">
                  <Button size="sm" onClick={() => save(row.question_id)}>
                    Save
                  </Button>
                  <Button size="sm" variant="outline" onClick={() => setEditingId(null)}>
                    Cancel
                  </Button>
                </div>
              </div>
            ) : confirmingDeleteId === row.question_id ? (
              <div className="mt-2 flex items-center justify-between gap-3">
                <p className="text-sm text-muted-foreground">Delete this note?</p>
                <div className="flex shrink-0 gap-2">
                  <Button size="sm" variant="destructive" onClick={() => remove(row.question_id)}>
                    Delete
                  </Button>
                  <Button size="sm" variant="outline" onClick={() => setConfirmingDeleteId(null)}>
                    Cancel
                  </Button>
                </div>
              </div>
            ) : (
              <div className="mt-2 flex items-start justify-between gap-3">
                <p className="flex items-start gap-1.5 text-sm text-primary">
                  <StickyNote className="mt-0.5 size-3.5 shrink-0" />
                  {row.note_text}
                </p>
                <div className="flex shrink-0 gap-2">
                  <Button size="sm" variant="outline" onClick={() => startEdit(row)}>
                    Edit
                  </Button>
                  <Button size="sm" variant="outline" onClick={() => setConfirmingDeleteId(row.question_id)}>
                    Delete
                  </Button>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      ))}
    </div>
  );
}
