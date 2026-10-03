"use client";

import { useCallback, useRef, useState } from "react";
import { getReviewerDetails, type ReviewerEntryDetail } from "./detail-actions";

const CHUNK = 150;

type HasDetails = { id: string; has_details?: boolean };

/**
 * Lazily loads the heavy fields of reviewer entries (see detail-actions.ts).
 * Lives in the page-level browser so what was loaded survives a group being
 * closed and reopened. `request` is idempotent; `ready` says whether every
 * entry in a list that needs details has them; `merge` returns the entries
 * with the loaded fields filled in.
 */
export function useEntryDetails() {
  const [details, setDetails] = useState<Record<string, ReviewerEntryDetail>>({});
  const [failed, setFailed] = useState(false);
  const requested = useRef(new Set<string>());

  const request = useCallback((entries: HasDetails[]) => {
    const missing = entries.filter((e) => e.has_details && !requested.current.has(e.id)).map((e) => e.id);
    if (missing.length === 0) return;
    for (const id of missing) requested.current.add(id);
    for (let i = 0; i < missing.length; i += CHUNK) {
      const chunk = missing.slice(i, i + CHUNK);
      getReviewerDetails(chunk)
        .then((result) => setDetails((prev) => ({ ...prev, ...result })))
        .catch(() => {
          for (const id of chunk) requested.current.delete(id);
          setFailed(true);
        });
    }
  }, []);

  const ready = useCallback(
    (entries: HasDetails[]) => entries.every((e) => !e.has_details || details[e.id] !== undefined),
    [details],
  );

  const merge = useCallback(
    <T extends HasDetails>(entries: T[]): T[] =>
      entries.map((e) => (e.has_details && details[e.id] ? { ...e, ...details[e.id] } : e)),
    [details],
  );

  return { request, ready, merge, failed };
}
