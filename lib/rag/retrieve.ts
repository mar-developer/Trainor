import { embed } from "ai";
import { AI_MODELS } from "@/lib/ai/gateway";
import { database } from "@/lib/db";

export interface RetrievedChunk {
  chunkId: string;
  source: "spec" | "arduino_docs" | "datasheet" | "obsidian" | "tutorial";
  title: string;
  url: string | null;
  headingPath: string | null;
  content: string;
  similarity: number;
}

export async function retrieveChunks(
  query: string,
  topK = 6,
): Promise<RetrievedChunk[]> {
  const { embedding } = await embed({
    model: AI_MODELS.embedding,
    value: query,
  });

  const matchCount = Math.max(1, Math.min(20, Math.trunc(topK)));
  const data = await database()`
    select * from public.match_chunks(
      ${JSON.stringify(embedding)}::vector,
      ${matchCount}
    )
  `;

  return (data ?? []).map((row: Record<string, unknown>) => ({
    chunkId: row.chunk_id as string,
    source: row.source as RetrievedChunk["source"],
    title: row.title as string,
    url: (row.url as string) ?? null,
    headingPath: (row.heading_path as string) ?? null,
    content: row.content as string,
    similarity: row.similarity as number,
  }));
}

export function formatContext(chunks: RetrievedChunk[]): string {
  if (!chunks.length) return "(no relevant context found)";
  return chunks
    .map((c, i) => {
      const path = c.headingPath ?? c.title;
      return `[${i + 1}] ${c.title} › ${path}\n${c.content}`;
    })
    .join("\n\n---\n\n");
}

export function citationsFromChunks(chunks: RetrievedChunk[]) {
  return chunks.map((c, i) => {
    // Strip the document title from the heading path — the UI shows the
    // title separately as the source label, so repeating it is noise.
    let heading = c.headingPath ?? "";
    const prefix = `${c.title} › `;
    if (heading.startsWith(prefix)) heading = heading.slice(prefix.length);
    if (heading === c.title) heading = "";
    return {
      index: i + 1,
      source: c.title,
      heading, // "" when the chunk is the document root — let the UI degrade
      chunkId: c.chunkId,
      url: c.url,
    };
  });
}
