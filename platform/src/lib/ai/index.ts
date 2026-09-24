import "server-only";
import { GeminiProvider } from "./gemini";
import { GroqProvider } from "./groq";
import { OpenRouterProvider } from "./openrouter";
import { CerebrasProvider } from "./cerebras";
import { MistralProvider } from "./mistral";
import { NvidiaProvider } from "./nvidia";
import { SambaNovaProvider } from "./sambanova";
import { AIProvider, FallbackAIProvider } from "./types";

export const AI_DAILY_LIMIT = Number(process.env.AI_DAILY_LIMIT ?? 500);

let cached: AIProvider | null = null;

/**
 * Configured AI provider — tries every configured key across seven free-tier
 * vendors, in this order: Gemini (x2 keys), Groq (x2 keys), OpenRouter,
 * Cerebras, Mistral, NVIDIA NIM, SambaNova (see FallbackAIProvider). A
 * vendor's "_2" key is a second account: one account's rate limit/quota
 * errors fall through to the other's separate allowance, effectively
 * doubling that vendor's free-tier quota. Every env var here is optional —
 * only the ones actually set become part of the chain. Returns null if
 * none are set at all (callers must handle this — never crash the
 * request).
 *
 * The Mistral/NVIDIA/SambaNova default model names below are NOT verified
 * against a live key the way Gemini's and Groq's are (see the comment on
 * groqModel — a guessed model name silently broke Groq for a while before
 * being caught). If one of these vendors' key gets added and "Teach Me
 * This" still fails, check that vendor's own live model list first.
 */
export function getAIProvider(): AIProvider | null {
  if (!cached) {
    const providers: AIProvider[] = [];
    const geminiModel = process.env.GEMINI_MODEL ?? "gemini-3.1-flash-lite";
    // "llama-3.3-70b-versatile" was retired from Groq's lineup — verified
    // against Groq's live /models list and a real generate call before
    // adopting this replacement (2026-09-24), same caution as Gemini's own
    // model-selection history in 24_CHANGELOG.md's 2026-09-18 entry.
    const groqModel = process.env.GROQ_MODEL ?? "openai/gpt-oss-120b";

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

    const mistralKey = process.env.MISTRAL_API_KEY;
    if (mistralKey) {
      providers.push(new MistralProvider(mistralKey, process.env.MISTRAL_MODEL ?? "mistral-small-latest"));
    }

    const nvidiaKey = process.env.NVIDIA_API_KEY;
    if (nvidiaKey) {
      providers.push(new NvidiaProvider(nvidiaKey, process.env.NVIDIA_MODEL ?? "meta/llama-3.3-70b-instruct"));
    }

    const sambanovaKey = process.env.SAMBANOVA_API_KEY;
    if (sambanovaKey) {
      providers.push(new SambaNovaProvider(sambanovaKey, process.env.SAMBANOVA_MODEL ?? "Meta-Llama-3.3-70B-Instruct"));
    }

    if (providers.length === 0) return null;
    cached = providers.length === 1 ? providers[0] : new FallbackAIProvider(providers);
  }
  return cached;
}

export { AIProviderError } from "./types";
export type { AIProvider } from "./types";
