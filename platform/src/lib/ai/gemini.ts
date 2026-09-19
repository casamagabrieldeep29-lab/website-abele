import "server-only";
import { GoogleGenAI } from "@google/genai";
import { AIProvider, AIProviderError } from "./types";

export class GeminiProvider implements AIProvider {
  private client: GoogleGenAI;
  private model: string;

  constructor(apiKey: string, model: string) {
    this.client = new GoogleGenAI({ apiKey });
    this.model = model;
  }

  async generate({ systemInstruction, prompt }: { systemInstruction: string; prompt: string }): Promise<string> {
    const response = await this.client.models.generateContent({
      model: this.model,
      contents: prompt,
      config: { systemInstruction },
    });

    const text = response.text;
    if (!text || !text.trim()) {
      throw new AIProviderError("Gemini returned an empty response.");
    }
    return text.trim();
  }
}
