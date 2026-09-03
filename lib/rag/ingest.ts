// Shared ingestion helper. Handles checksum dedupe, embedding, and atomic
// replacement of a document's chunks and vectors.

import { createHash } from "node:crypto";
import { embedMany } from "ai";
import { AI_MODELS } from "@/lib/ai/gateway";
import { database } from "@/lib/db";
import type { Chunk } from "@/lib/rag/chunk";

export type IngestSource =
  | "spec"
  | "arduino_docs"
  | "datasheet"
  | "obsidian"
  | "tutorial";

export interface IngestInput {
  source: IngestSource;
  title: string;
  url?: string;
  raw: string;
  chunks: Chunk[];
}

export async function ingestDocument(
  input: IngestInput,
): Promise<{ skipped: boolean; chunkCount: number }> {
  const sql = database();
  const checksum = createHash("sha256").update(input.raw).digest("hex");
  const [existing] = (input.url
    ? await sql`
        select id, checksum from public.documents
         where source = ${input.source} and url = ${input.url}
         limit 1
      `
    : await sql`
        select id, checksum from public.documents
         where source = ${input.source} and title = ${input.title}
         limit 1
      `) as unknown as Array<{ id: string; checksum: string }>;

  if (existing?.checksum === checksum) {
    return { skipped: true, chunkCount: 0 };
  }

  const allEmbeddings: number[][] = [];
  for (let index = 0; index < input.chunks.length; index += 64) {
    const batch = input.chunks.slice(index, index + 64);
    allEmbeddings.push(
      ...(await embedManyWithRetry(batch.map((chunk) => chunk.content))),
    );
  }

  await sql.begin(async (transaction) => {
    let documentId: string;
    if (existing) {
      await transaction`
        update public.documents
           set checksum = ${checksum}, ingested_at = now()
         where id = ${existing.id}
      `;
      await transaction`
        delete from public.chunks where document_id = ${existing.id}
      `;
      documentId = existing.id;
    } else {
      const [document] = await transaction`
        insert into public.documents (source, title, url, checksum)
        values (
          ${input.source}, ${input.title}, ${input.url ?? null}, ${checksum}
        )
        returning id
      `;
      documentId = document.id as string;
    }

    for (let index = 0; index < input.chunks.length; index++) {
      const chunk = input.chunks[index];
      const [inserted] = await transaction`
        insert into public.chunks
          (document_id, content, token_count, heading_path)
        values (
          ${documentId}, ${chunk.content}, ${chunk.tokenCount},
          ${chunk.headingPath}
        )
        returning id
      `;
      await transaction`
        insert into public.embeddings (chunk_id, embedding)
        values (
          ${inserted.id as string},
          ${JSON.stringify(allEmbeddings[index])}::vector
        )
      `;
    }
  });

  return { skipped: false, chunkCount: input.chunks.length };
}

async function embedManyWithRetry(
  values: string[],
  attempts = 3,
  baseDelayMs = 45_000,
): Promise<number[][]> {
  let lastError: unknown;
  for (let index = 0; index < attempts; index++) {
    try {
      const { embeddings } = await embedMany({
        model: AI_MODELS.embedding,
        values,
      });
      return embeddings;
    } catch (error) {
      lastError = error;
      const message = error instanceof Error ? error.message : String(error);
      const rateLimited = /rate[_ ]limit|429/i.test(message);
      if (!rateLimited || index === attempts - 1) throw error;
      const wait = baseDelayMs * (index + 1);
      console.log(
        `  ⏳ embed rate-limited — waiting ${wait / 1000}s before retry ${index + 1}/${attempts - 1}…`,
      );
      await new Promise((resolve) => setTimeout(resolve, wait));
    }
  }
  throw lastError;
}
