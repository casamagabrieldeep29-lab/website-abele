import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

export class SambaNovaProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string) {
    super("https://api.sambanova.ai/v1/chat/completions", apiKey, model, "SambaNova");
  }
}
