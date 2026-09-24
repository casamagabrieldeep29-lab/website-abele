import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

export class MistralProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string) {
    super("https://api.mistral.ai/v1/chat/completions", apiKey, model, "Mistral");
  }
}
