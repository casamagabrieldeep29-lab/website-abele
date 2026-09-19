"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { setBookmark } from "../practice/bookmarks-actions";

export type BookmarkRow = {
  bookmark_id: string;
  question_id: string;
  question_text: string;
  topic_name: string;
  created_at: string;
};

export function BookmarksList({ rows: initialRows }: { rows: BookmarkRow[] }) {
  const [rows, setRows] = useState(initialRows);

  async function remove(questionId: string) {
    await setBookmark(questionId, false);
    setRows((prev) => prev.filter((r) => r.question_id !== questionId));
  }

  if (rows.length === 0) {
    return (
      <p className="mt-4 text-sm text-muted-foreground">
        No saved questions yet — bookmark one with the star icon in Practice.
      </p>
    );
  }

  return (
    <div className="mt-4 space-y-3">
      {rows.map((row) => (
        <Card key={row.bookmark_id}>
          <CardContent className="flex items-start justify-between gap-3 py-3">
            <div>
              <p className="text-xs text-muted-foreground">{row.topic_name}</p>
              <p className="mt-1 text-sm">{row.question_text}</p>
            </div>
            <Button size="sm" variant="outline" className="shrink-0" onClick={() => remove(row.question_id)}>
              Remove
            </Button>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}
