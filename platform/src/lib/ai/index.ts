import "server-only";
import { GeminiProvider } from "./gemini";
import { GroqProvider } from "./groq";
import { OpenRouterProvider } from "./openrouter";
import { CerebrasProvider } from "./cerebras";
import { AIProvider, FallbackAIProvider } from "./types";

export const AI_DAILY_LIMIT = Number(process.env.AI_DAILY_LIMIT ?? 500);

let cached: AIProvider | null = null;

/**
 * Configured AI provider — tries every configured key across four free-tier
 * vendors, in this order: Gemini (x2 keys), Groq (x2 keys), OpenRouter,
 * Cerebras (see FallbackAIProvider). A vendor's "_2" key is a second
 * account: one account's rate limit/quota errors fall through to the
 * other's separate allowance, effectively doubling that vendor's free-tier
 * quota. Every env var here is optional — only the ones actually set
 * become part of the chain. Returns null if none are set at all (callers
 * must handle this — never crash the request).
 */
export function getAIProvider(): AIProvider | null {
  if (!cached) {
    const providers: AIProvider[] = [];
    const geminiModel = process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite";
    const groqModel = process.env.GROQ_MODEL ?? "llama-3.3-70b-versatile";

    const geminiKey = process.env.GEMINI_API_KEY;
    if (geminiKey) providers.push(new GeminiProvider(geminiKey, geminiModel));

    const geminiKey2 = process.env.GEMINI_API_KEY_2;
    if (geminiKey2) providers.push(new GeminiProvider(geminiKey2, geminiModel));

    const groqKey = process.env.GROQ_API_KEY;
    if (groqKey) providers.push(new GroqProvider(groqKey, groqModel));

    const groqKey2 = process.env.GROQ_API_KEY_2;
    if (groqKey2) providers.push(new GroqProvider(groqKey2, groqModel));

    const openRouterKey = process.env.OPENROUTER_API_KEY;
    if (openRouterKey) {
      const model = process.env.OPENROUTER_MODEL ?? "meta-llama/llama-3.3-70b-instruct:free";
      providers.push(new OpenRouterProvider(openRouterKey, model));
    }

    const cerebrasKey = process.env.CEREBRAS_API_KEY;
    if (cerebrasKey) {
      providers.push(new CerebrasProvider(cerebrasKey, process.env.CEREBRAS_MODEL ?? "llama-3.3-70b"));
    }

    if (providers.length === 0) return null;
    cached = providers.length === 1 ? providers[0] : new FallbackAIProvider(providers);
  }
  return cached;
}

export { AIProviderError } from "./types";
export type { AIProvider } from "./types";
