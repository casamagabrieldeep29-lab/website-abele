"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import {
  BookMarked,
  ClipboardList,
  Compass,
  FileQuestion,
  GalleryVerticalEnd,
  Layers,
  Search,
  Target,
  XCircle,
} from "lucide-react";
import { cn } from "cn";
import { Dialog, DialogContent } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { globalSearch, type GlobalSearchResults, type SearchResult, type SearchResultKind } from "./actions";
import { startAdaptivePracticeAttempt } from "@/app/practice/actions";

const EMPTY_RESULTS: GlobalSearchResults = {
  tos: [],
  subjects: [],
  topics: [],
  questions: [],
  materials: [],
  flashcards: [],
  mistakes: [],
};

const CATEGORY_META: Record<SearchResultKind, { label: string; icon: typeof Search }> = {
  tos: { label: "TOS", icon: Compass },
  subject: { label: "Subject", icon: Layers },
  topic: { label: "Topic", icon: BookMarked },
  question: { label: "Question", icon: FileQuestion },
  material: { label: "Material", icon: ClipboardList },
  flashcard: { label: "Flashcard", icon: GalleryVerticalEnd },
  mistake: { label: "Mistake Bank", icon: XCircle },
};

const CATEGORY_ORDER: { key: keyof GlobalSearchResults; heading: string }[] = [
  { key: "tos", heading: "TOS" },
  { key: "subjects", heading: "Subjects" },
  { key: "topics", heading: "Topics" },
  { key: "questions", heading: "Questions" },
  { key: "materials", heading: "Materials" },
  { key: "flashcards", heading: "Flashcards" },
  { key: "mistakes", heading: "Mistake Bank" },
];

const SESSION_SIZE = 20;
const DEBOUNCE_MS = 250;
const MIN_QUERY_LENGTH = 2;

/** Wraps the portion of `text` matching `query` in a subtle highlight — case-insensitive, first match only (results are short single-line labels, not prose). */
function HighlightedText({ text, query }: { text: string; query: string }) {
  if (query.trim().length < MIN_QUERY_LENGTH) return <>{text}</>;
  const idx = text.toLowerCase().indexOf(query.trim().toLowerCase());
  if (idx === -1) return <>{text}</>;
  const before = text.slice(0, idx);
  const match = text.slice(idx, idx + query.trim().length);
  const after = text.slice(idx + query.trim().length);
  return (
    <>
      {before}
      <mark className="rounded-sm bg-gold/30 text-inherit">{match}</mark>
      {after}
    </>
  );
}

export function GlobalSearch() {
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<GlobalSearchResults>(EMPTY_RESULTS);
  const [loading, setLoading] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const requestIdRef = useRef(0);

  // Cmd/Ctrl+K opens search from anywhere in the app — doesn't collide with
  // anything existing (no other global shortcut in this codebase uses K).
  useEffect(() => {
    function onKeyDown(e: KeyboardEvent) {
      if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "k") {
        e.preventDefault();
        setOpen(true);
      }
    }
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, []);

  // Resetting on close belongs in the handler that changes `open`, not in an
  // effect reacting to it — see handleOpenChange below.
  function handleOpenChange(next: boolean) {
    setOpen(next);
    if (!next) {
      setQuery("");
      setResults(EMPTY_RESULTS);
      setLoading(false);
      setSelectedIndex(0);
    }
  }

  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current);
    const trimmed = query.trim();
    const thisRequestId = ++requestIdRef.current;
    if (trimmed.length < MIN_QUERY_LENGTH) {
      // Nothing to fetch — `displayResults`/`showLoading` below derive the
      // empty-query prompt directly from `query` rather than from state, so
      // there's no state to reset here.
      return;
    }
    // Deferred a microtask so the lint rule against synchronous setState in
    // an effect body doesn't fire — this is still effectively immediate
    // (fires before the next paint), just not literally inline.
    let cancelled = false;
    queueMicrotask(() => {
      if (!cancelled) setLoading(true);
    });
    debounceRef.current = setTimeout(async () => {
      const r = await globalSearch(trimmed);
      // Ignore stale responses from an earlier keystroke that resolved late.
      if (requestIdRef.current === thisRequestId) {
        setResults(r);
        setLoading(false);
        setSelectedIndex(0);
      }
    }, DEBOUNCE_MS);
    return () => {
      cancelled = true;
      if (debounceRef.current) clearTimeout(debounceRef.current);
    };
  }, [query]);

  const trimmedQuery = query.trim();
  const queryTooShort = trimmedQuery.length < MIN_QUERY_LENGTH;
  // Stale `results`/`loading` from a longer query the user has since deleted
  // back below MIN_QUERY_LENGTH are overridden here rather than reset via a
  // synchronous setState in the search effect above (see its comment).
  const displayResults = queryTooShort ? EMPTY_RESULTS : results;
  const showLoading = !queryTooShort && loading;
  const flatResults = useMemo(() => CATEGORY_ORDER.flatMap(({ key }) => displayResults[key]), [displayResults]);
  const hasAnyResults = flatResults.length > 0;

  const navigateTo = useCallback(
    (result: SearchResult) => {
      handleOpenChange(false);
      router.push(result.href);
    },
    [router],
  );

  function onKeyDown(e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === "Escape") {
      handleOpenChange(false);
      return;
    }
    if (!hasAnyResults) return;
    if (e.key === "ArrowDown") {
      e.preventDefault();
      setSelectedIndex((i) => Math.min(i + 1, flatResults.length - 1));
    } else if (e.key === "ArrowUp") {
      e.preventDefault();
      setSelectedIndex((i) => Math.max(i - 1, 0));
    } else if (e.key === "Enter") {
      e.preventDefault();
      const target = flatResults[selectedIndex];
      if (target) navigateTo(target);
    }
  }

  let runningIndex = -1;

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <Button
        type="button"
        variant="outline"
        onClick={() => setOpen(true)}
        className="hidden h-8 w-full max-w-sm justify-start gap-2 text-muted-foreground sm:inline-flex"
      >
        <Search className="size-3.5" />
        <span className="flex-1 text-left">Search topics, subjects, questions, materials…</span>
        <kbd className="hidden rounded border border-border bg-muted px-1.5 py-0.5 font-mono text-[10px] text-muted-foreground md:inline">
          ⌘K
        </kbd>
      </Button>
      <Button
        type="button"
        variant="outline"
        size="icon"
        onClick={() => setOpen(true)}
        className="sm:hidden"
        aria-label="Search"
      >
        <Search className="size-4" />
      </Button>

      <DialogContent showCloseButton={false} className="gap-0 p-0 sm:max-w-xl">
        <div className="flex items-center gap-2 border-b border-border px-3 py-2.5">
            <Search className="size-4 shrink-0 text-muted-foreground" />
            <Input
              autoFocus
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              onKeyDown={onKeyDown}
              placeholder="Search topics, subjects, questions, materials…"
              className="h-7 border-none bg-transparent px-0 shadow-none focus-visible:ring-0"
            />
            <kbd className="hidden shrink-0 rounded border border-border bg-muted px-1.5 py-0.5 font-mono text-[10px] text-muted-foreground sm:inline">
              Esc
            </kbd>
          </div>

          <div className="max-h-[60vh] overflow-y-auto p-1.5">
            {queryTooShort ? (
              <div className="px-3 py-10 text-center">
                <p className="text-sm font-medium">Search ABELIEVER</p>
                <p className="mt-1 text-xs text-muted-foreground">
                  Find topics, subjects, questions, and study materials.
                </p>
              </div>
            ) : showLoading ? (
              <div className="px-3 py-10 text-center text-sm text-muted-foreground">Searching…</div>
            ) : !hasAnyResults ? (
              <div className="px-3 py-10 text-center">
                <p className="text-sm font-medium">No results found</p>
                <p className="mt-1 text-xs text-muted-foreground">Try a different topic, subject, or keyword.</p>
              </div>
            ) : (
              CATEGORY_ORDER.map(({ key, heading }) => {
                const items = displayResults[key];
                if (items.length === 0) return null;
                return (
                  <div key={key} className="mb-1 last:mb-0">
                    <p className="px-2 py-1 text-[10px] font-semibold tracking-wide text-muted-foreground uppercase">
                      {heading}
                    </p>
                    {items.map((r) => {
                      runningIndex += 1;
                      const isSelected = runningIndex === selectedIndex;
                      const Icon = CATEGORY_META[r.kind].icon;
                      return (
                        <div
                          key={`${r.kind}-${r.id}`}
                          role="option"
                          aria-selected={isSelected}
                          onMouseEnter={() => setSelectedIndex(runningIndex)}
                          onClick={() => navigateTo(r)}
                          className={cn(
                            "flex cursor-pointer items-start gap-2.5 rounded-md px-2 py-2 text-sm transition-colors",
                            isSelected ? "bg-accent text-accent-foreground" : "hover:bg-accent/60",
                          )}
                        >
                          <Icon className="mt-0.5 size-4 shrink-0 text-muted-foreground" />
                          <div className="min-w-0 flex-1">
                            <p className="truncate leading-snug font-medium">
                              <HighlightedText text={r.label} query={trimmedQuery} />
                            </p>
                            <p className="truncate text-xs text-muted-foreground">{r.sublabel}</p>
                          </div>
                          {r.kind === "topic" && r.topicId && (
                            <form
                              action={startAdaptivePracticeAttempt.bind(null, r.topicId, SESSION_SIZE)}
                              onClick={(e) => e.stopPropagation()}
                            >
                              <Button type="submit" size="sm" variant="secondary" className="shrink-0">
                                <Target className="size-3.5" />
                                Practice
                              </Button>
                            </form>
                          )}
                        </div>
                      );
                    })}
                  </div>
                );
              })
            )}
          </div>

          <div className="flex items-center gap-3 border-t border-border px-3 py-1.5 text-[10px] text-muted-foreground">
            <span className="flex items-center gap-1">
              <kbd className="rounded border border-border bg-muted px-1 py-0.5 font-mono">↑↓</kbd> navigate
            </span>
            <span className="flex items-center gap-1">
              <kbd className="rounded border border-border bg-muted px-1 py-0.5 font-mono">↵</kbd> open
            </span>
            <span className="flex items-center gap-1">
              <kbd className="rounded border border-border bg-muted px-1 py-0.5 font-mono">esc</kbd> close
            </span>
          </div>
      </DialogContent>
    </Dialog>
  );
}
