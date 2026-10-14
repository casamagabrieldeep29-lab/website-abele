import { Link2 } from "lucide-react";

/** Where one question sits inside a connected (sequenced) problem. */
export type SeriesInfo = {
  /** 1-based position in the problem; 1 is the opening question. */
  part: number;
  /** The opening question's text, shown above follow-up parts. Null on part 1 itself. */
  statement: string | null;
};

/**
 * Marks a question as one step of a connected problem. Follow-up parts carry the
 * opening question so the student always has the problem statement in front of
 * them, however the question was reached.
 */
export function SeriesBanner({ info }: { info: SeriesInfo }) {
  return (
    <div className="mb-3 rounded-md border border-primary/30 bg-primary/5 px-3 py-2 text-xs">
      <p className="flex items-center gap-1.5 font-semibold text-primary">
        <Link2 className="size-3.5" />
        Connected problem · Part {info.part}
      </p>
      {info.statement && (
        <details open className="mt-1.5">
          <summary className="cursor-pointer text-muted-foreground">Problem statement (Part 1)</summary>
          <p className="mt-1 text-sm leading-relaxed text-foreground">{info.statement}</p>
        </details>
      )}
    </div>
  );
}
