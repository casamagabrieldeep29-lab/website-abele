// Small provider abstraction so ABELIEVER isn't tied to one AI vendor —
// swapping Gemini for another provider later means writing one new file
// that implements this interface, not touching call sites.
export interface AIProvider {
  generate(input: { systemInstruction: string; prompt: string }): Promise<string>;
}

export class AIProviderError extends Error {}

/**
 * Tries each provider in order, falling through to the next on any
 * failure — Gemini's free tier has repeatedly hit model deprecation/high-
 * demand errors in production (see 24_CHANGELOG.md's 2026-09-18 entry), so
 * a second provider on a different vendor's infrastructure means one
 * vendor's outage/quota exhaustion doesn't take "Teach Me This" down. Only
 * throws once every provider in the chain has failed.
 */
export class FallbackAIProvider implements AIProvider {
  constructor(private providers: AIProvider[]) {}

  async generate(input: { systemInstruction: string; prompt: string }): Promise<string> {
    let lastError: unknown;
    for (const provider of this.providers) {
      try {
        return await provider.generate(input);
      } catch (err) {
        lastError = err;
        console.error(
          `[ai] ${provider.constructor.name} failed, trying next provider:`,
          err instanceof Error ? err.message : err,
        );
      }
    }
    throw lastError instanceof Error ? lastError : new AIProviderError("All AI providers failed.");
  }
}
