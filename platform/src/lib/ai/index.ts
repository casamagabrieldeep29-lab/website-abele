import "server-only";
import { GeminiProvider } from "./gemini";
import { AIProvider } from "./types";

export const AI_DAILY_LIMIT = Number(process.env.AI_DAILY_LIMIT ?? 500);

let cached: AIProvider | null = null;

/** Configured AI provider, or null if GEMINI_API_KEY isn't set (callers must handle this — never crash the request). */
export function getAIProvider(): AIProvider | null {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) return null;

  if (!cached) {
    const model = process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite";
    cached = new GeminiProvider(apiKey, model);
  }
  return cached;
}

export { AIProviderError } from "./types";
export type { AIProvider } from "./types";
