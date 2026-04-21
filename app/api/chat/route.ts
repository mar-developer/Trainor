// POST /api/chat — RAG-grounded tutor chat.
// Retrieves top-k chunks, streams Claude's response with citation markers.
import { convertToModelMessages, streamText, type UIMessage } from "ai";
import { AI_MODELS, TUTOR_SYSTEM_PROMPT } from "@/lib/ai/gateway";
import {
  citationsFromChunks,
  formatContext,
  retrieveChunks,
} from "@/lib/rag/retrieve";

export const maxDuration = 60;

export async function POST(req: Request) {
  const { messages }: { messages: UIMessage[] } = await req.json();

  // The most recent user message is the retrieval query.
  const lastUser = [...messages]
    .reverse()
    .find((m) => m.role === "user");
  const query = lastUser
    ? lastUser.parts
        .filter((p): p is { type: "text"; text: string } => p.type === "text")
        .map((p) => p.text)
        .join("\n")
    : "";

  let contextBlock = "(no relevant context found)";
  let citations: ReturnType<typeof citationsFromChunks> = [];

  if (query.trim()) {
    try {
      const chunks = await retrieveChunks(query, 6);
      contextBlock = formatContext(chunks);
      citations = citationsFromChunks(chunks);
    } catch (err) {
      console.warn("RAG retrieval failed, answering without context:", err);
    }
  }

  const result = streamText({
    model: AI_MODELS.chat,
    system: TUTOR_SYSTEM_PROMPT,
    messages: [
      {
        role: "system",
        content: `CONTEXT (cite as [1]..[n] when used):\n\n${contextBlock}`,
      },
      ...convertToModelMessages(messages),
    ],
  });

  return result.toUIMessageStreamResponse({
    messageMetadata: () => ({ citations }),
  });
}
