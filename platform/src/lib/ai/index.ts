import "server-only";
import { GeminiProvider } from "./gemini";
import { GroqProvider } from "./groq";
import { AIProvider, FallbackAIProvider } from "./types";

export const AI_DAILY_LIMIT = Number(process.env.AI_DAILY_LIMIT ?? 500);

let cached: AIProvider | null = null;

/**
 * Configured AI provider — Gemini first, falling back to Groq if Gemini
 * fails (see FallbackAIProvider) — or null if neither GEMINI_API_KEY nor
 * GROQ_API_KEY is set (callers must handle this — never crash the request).
 */
export function getAIProvider(): AIProvider | null {
  if (!cached) {
    const providers: AIProvider[] = [];

    const geminiKey = process.env.GEMINI_API_KEY;
    if (geminiKey) {
      providers.push(new GeminiProvider(geminiKey, process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite"));
    }

    const groqKey = process.env.GROQ_API_KEY;
    if (groqKey) {
      providers.push(new GroqProvider(groqKey, process.env.GROQ_MODEL ?? "llama-3.3-70b-versatile"));
    }

    if (providers.length === 0) return null;
    cached = providers.length === 1 ? providers[0] : new FallbackAIProvider(providers);
  }
  return cached;
}

export { AIProviderError } from "./types";
export type { AIProvider } from "./types";
