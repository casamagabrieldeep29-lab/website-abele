/** Whitespace-separated word count — the same rule Mock Exam's "too short to be a real board item" filter has always used. */
export function countWords(text: string | null | undefined): number {
  return (text ?? "").trim().split(/\s+/).length;
}
