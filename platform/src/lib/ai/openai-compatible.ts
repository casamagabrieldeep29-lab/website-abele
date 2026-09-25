import "server-only";
import { AIProvider, AIProviderError } from "./types";

/**
 * Shared implementation for any provider that speaks the OpenAI chat-
 * completions shape (Groq, OpenRouter, Cerebras all do) — only the
 * endpoint/model/key differ per vendor, so each vendor's file is just a
 * thin subclass fixing those in, rather than repeating this fetch/parse
 * logic per provider.
 */
export class OpenAICompatibleProvider implements AIProvider {
  readonly label: string;

  constructor(
    private endpoint: string,
    private apiKey: string,
    private model: string,
    private providerLabel: string,
  ) {
    this.label = providerLabel;
  }

  async generate({ systemInstruction, prompt }: { systemInstruction: string; prompt: string }): Promise<string> {
    const response = await fetch(this.endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${this.apiKey}`,
      },
      body: JSON.stringify({
        model: this.model,
        messages: [
          { role: "system", content: systemInstruction },
          { role: "user", content: prompt },
        ],
      }),
    });

    if (!response.ok) {
      const body = await response.text().catch(() => "");
      throw new AIProviderError(`${this.providerLabel} request failed (${response.status}): ${body.slice(0, 300)}`);
    }

    const data = await response.json();
    const text = data?.choices?.[0]?.message?.content as string | undefined;
    if (!text || !text.trim()) {
      throw new AIProviderError(`${this.providerLabel} returned an empty response.`);
    }
    return text.trim();
  }
}
