import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Flashcards are grouped by exam Area (Area 1/2/3) through the topics'
 * `mock_area`, not through dedicated "Area N" placeholder topics. A card
 * lives on its real topic (Hydrology, Pumps, ...) and the Area is derived.
 */
export const FLASHCARD_AREAS = [
  { key: "area_1", label: "Area 1" },
  { key: "area_2", label: "Area 2" },
  { key: "area_3", label: "Area 3" },
] as const;

export type FlashcardAreaKey = (typeof FLASHCARD_AREAS)[number]["key"];

export function flashcardAreaLabel(key: string | null | undefined): string | null {
  return FLASHCARD_AREAS.find((a) => a.key === key)?.label ?? null;
}

export function isFlashcardAreaKey(value: string | undefined): value is FlashcardAreaKey {
  return FLASHCARD_AREAS.some((a) => a.key === value);
}

/** Ids of every topic in one Area. The topic list is tiny (~40 rows). */
export async function fetchAreaTopicIds(supabase: SupabaseClient, areaKey: string): Promise<string[]> {
  const { data } = await supabase.from("topics").select("id").eq("mock_area", areaKey);
  return (data ?? []).map((t: { id: string }) => t.id);
}
