import "server-only";
import { OpenAICompatibleProvider } from "./openai-compatible";

export class NvidiaProvider extends OpenAICompatibleProvider {
  constructor(apiKey: string, model: string) {
    super("https://integrate.api.nvidia.com/v1/chat/completions", apiKey, model, "NVIDIA NIM");
  }
}
