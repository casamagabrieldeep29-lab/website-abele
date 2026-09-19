// Small provider abstraction so ABELIEVER isn't tied to one AI vendor —
// swapping Gemini for another provider later means writing one new file
// that implements this interface, not touching call sites.
export interface AIProvider {
  generate(input: { systemInstruction: string; prompt: string }): Promise<string>;
}

export class AIProviderError extends Error {}
