// scripts/ingest-lessons.ts — pulls every lesson body from Postgres and
// indexes it for RAG. Each lesson becomes its own document titled "Module
// X.Y — Title" so citations are human-readable out of the box.
//
// Run: npm run ingest:lessons
import { config as loadEnv } from "dotenv";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { chunkMarkdown } from "../lib/rag/chunk";
import { database } from "../lib/db";
import { ingestDocument } from "../lib/rag/ingest";

async function main() {
  // Pull every lesson joined up to its module + course so we can build
  // friendly document titles.
  const rows = (await database()`
    select l.id, l.title, l.body_md,
           m.number as module_number, m.title as module_title,
           c.slug as course_slug
      from public.lessons l
      join public.modules m on m.id = l.module_id
      join public.phases p on p.id = m.phase_id
      join public.courses c on c.id = p.course_id
     order by p."order", m."order", l."order"
  `) as unknown as Array<{
    id: string;
    title: string;
    body_md: string | null;
    module_number: string;
    module_title: string;
    course_slug: string;
  }>;

  console.log(`Found ${rows.length} lessons to ingest.`);

  let ok = 0;
  let skipped = 0;
  let empty = 0;
  let failed = 0;

  for (const row of rows) {
    const body = (row.body_md ?? "").trim();
    if (!body) {
      empty++;
      continue;
    }

    const title = `${row.module_number} · ${row.module_title}`;

    const chunks = chunkMarkdown(body, title);
    if (!chunks.length) {
      empty++;
      continue;
    }

    try {
      const result = await retryOnRateLimit(() =>
        ingestDocument({
          source: "spec",
          title,
          // Use lesson id in the URL so each lesson is a unique document in
          // the checksum-dedup table (independent from the legacy spec file).
          url: `lesson://${row.course_slug}/${row.id}`,
          raw: body,
          chunks,
        }),
      );
      if (result.skipped) {
        skipped++;
        console.log(`  = ${title} (unchanged)`);
      } else {
        ok++;
        console.log(`  ✓ ${title} · ${result.chunkCount} chunks`);
      }
    } catch (err) {
      failed++;
      const msg = err instanceof Error ? err.message : String(err);
      console.error(`  × ${title}: ${msg.split("\n")[0]}`);
    }

    // Pace requests so free-tier rate limits don't saturate.
    await sleep(400);
  }

  console.log(
    `\nDone. ${ok} ingested, ${skipped} unchanged, ${empty} empty, ${failed} failed.`,
  );
  if (failed > 0) {
    console.log(
      "Tip: re-run `npm run ingest:lessons` to retry failures " +
        "(successful lessons are checksum-gated, won't re-embed).",
    );
  }
}

function sleep(ms: number) {
  return new Promise((r) => setTimeout(r, ms));
}

/**
 * Wraps a network call with explicit back-off when the gateway returns a
 * 429. The AI SDK already retries transparently; we sit on top of that so
 * long stalls (free-tier throttles) don't kill the whole corpus run.
 */
async function retryOnRateLimit<T>(
  fn: () => Promise<T>,
  attempts = 3,
  baseDelayMs = 45_000,
): Promise<T> {
  for (let i = 0; i < attempts; i++) {
    try {
      return await fn();
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      const isRateLimit = /rate[_ ]limit|429/i.test(msg);
      if (!isRateLimit || i === attempts - 1) throw err;
      const wait = baseDelayMs * (i + 1);
      console.log(
        `  ⏳ rate-limited — waiting ${wait / 1000}s before retry ${i + 1}/${attempts - 1}…`,
      );
      await sleep(wait);
    }
  }
  throw new Error("unreachable");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
