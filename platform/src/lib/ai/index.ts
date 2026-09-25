import "server-only";
import { GeminiProvider } from "./gemini";
import { GroqProvider } from "./groq";
import { OpenRouterProvider } from "./openrouter";
import { CerebrasProvider } from "./cerebras";
import { MistralProvider } from "./mistral";
import { NvidiaProvider } from "./nvidia";
import { AIProvider, FallbackAIProvider } from "./types";

export const AI_DAILY_LIMIT = Number(process.env.AI_DAILY_LIMIT ?? 500);
// Stricter cap for free-trial accounts specifically — enforced inside
// check_and_log_ai_usage() (patch 034), not here; this is just the value
// passed in as p_trial_daily_limit. Subscribers/admins are unaffected.
export const AI_TRIAL_DAILY_LIMIT = Number(process.env.AI_TRIAL_DAILY_LIMIT ?? 15);

let cached: AIProvider | null = null;

/**
 * Reads KEY, KEY_2, KEY_3, ... (one env var per separate account on that
 * vendor) and stops at the first gap — so adding a 3rd/4th account's key
 * later is just setting one more numbered env var in Vercel, no code
 * change needed. Capped at 10 purely as a sanity bound, not a real limit
 * anyone should hit.
 */
function collectApiKeys(envPrefix: string): string[] {
  const keys: string[] = [];
  const first = process.env[envPrefix];
  if (first) keys.push(first);
  for (let i = 2; i <= 10; i++) {
    const key = process.env[`${envPrefix}_${i}`];
    if (!key) break;
    keys.push(key);
  }
  return keys;
}

/**
 * Configured AI provider — tries every configured key across six free-tier
 * vendors, in this order: Gemini (all keys), Groq (all keys), OpenRouter,
 * Cerebras, Mistral, NVIDIA NIM (see FallbackAIProvider). SambaNova was
 * removed 2026-09-25 after its free tier ended (its API started returning
 * 402 Payment Required on every call). Each extra numbered key (`_2`, `_3`,
 * ...) is a separate account: one account's rate limit/quota errors fall
 * through to the next account's separate allowance, effectively
 * multiplying that vendor's free-tier quota by however many accounts are
 * configured. Every env var here is optional — only the ones actually set
 * become part of the chain. Returns null if none are set at all (callers
 * must handle this — never crash the request).
 *
 * The Mistral/NVIDIA default model names below are NOT verified against a
 * live key the way Gemini's and Groq's are (see the comment on groqModel —
 * a guessed model name silently broke Groq for a while before being
 * caught). If one of these vendors' key gets added and "Teach Me This"
 * still fails, check that vendor's own live model list first.
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

    collectApiKeys("GEMINI_API_KEY").forEach((key, i) => {
      providers.push(new GeminiProvider(key, geminiModel, `Gemini (key ${i + 1})`));
    });

    collectApiKeys("GROQ_API_KEY").forEach((key, i) => {
      providers.push(new GroqProvider(key, groqModel, `Groq (key ${i + 1})`));
    });

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

    if (providers.length === 0) return null;
    cached = providers.length === 1 ? providers[0] : new FallbackAIProvider(providers);
  }
  return cached;
}

/**
 * check_and_log_ai_usage() returns which cap was actually hit
 * ('trial_limit' vs 'daily_limit') so the two AI routes can show the right
 * message — a trial account hitting its stricter 15/day cap should be told
 * to upgrade, not just "try again tomorrow" like a subscriber's much higher
 * daily cap.
 */
export function buildAiLimitMessage(limitReason: string | null | undefined): string {
  if (limitReason === "trial_limit") {
    return `Limit reached for your Free Trial account (${AI_TRIAL_DAILY_LIMIT}/day). Upgrade to a Subscriber account for a much higher daily limit.`;
  }
  return `You've reached today's AI request limit (${AI_DAILY_LIMIT}/day). Try again tomorrow.`;
}

export { AIProviderError } from "./types";
export type { AIProvider } from "./types";
