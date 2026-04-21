// scripts/ingest-datasheets.ts — reads every .pdf in ./datasheets,
// extracts text with pdfjs-dist, chunks, and upserts.
//
// Drop component datasheets into web/datasheets/, name them descriptively
// (e.g. `PN2222.pdf`, `SG90.pdf`). The file name is used as the document
// title. Run: npm run ingest:datasheets

import { config as loadEnv } from "dotenv";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { readdir, readFile } from "node:fs/promises";
import { basename, resolve } from "node:path";
import { chunkMarkdown } from "../lib/rag/chunk";
import { ingestDocument, supabaseFromEnv } from "../lib/rag/ingest";

const DATASHEET_DIR = resolve(process.cwd(), "./datasheets");

async function extractPdfText(buffer: Uint8Array): Promise<string> {
  // Lazy-load pdfjs-dist (it's ESM-ish and heavy).
  const pdfjs = await import("pdfjs-dist/legacy/build/pdf.mjs");
  // Disable the worker — fine for scripts.
  // @ts-expect-error — runtime flag, no types.
  pdfjs.GlobalWorkerOptions.workerSrc = undefined;

  const loadingTask = pdfjs.getDocument({ data: buffer, useSystemFonts: true });
  const doc = await loadingTask.promise;

  const pieces: string[] = [];
  for (let p = 1; p <= doc.numPages; p++) {
    const page = await doc.getPage(p);
    const content = await page.getTextContent();
    const lines: string[] = [];
    let lastY: number | null = null;
    for (const item of content.items as Array<{
      str: string;
      transform?: number[];
    }>) {
      const y = item.transform?.[5] ?? 0;
      if (lastY !== null && Math.abs(y - lastY) > 4) lines.push("\n");
      lines.push(item.str);
      lastY = y;
    }
    pieces.push(lines.join(" ").replace(/\s+\n/g, "\n").trim());
  }
  return pieces.join("\n\n");
}

async function main() {
  let files: string[];
  try {
    files = (await readdir(DATASHEET_DIR)).filter((f) => f.toLowerCase().endsWith(".pdf"));
  } catch {
    console.log(`No datasheets/ folder at ${DATASHEET_DIR}. Create it and drop PDFs in to ingest.`);
    return;
  }
  if (!files.length) {
    console.log("No .pdf files found in ./datasheets");
    return;
  }

  const supabase = supabaseFromEnv();
  let ok = 0;
  let skipped = 0;

  for (const file of files) {
    const title = basename(file, ".pdf");
    const path = resolve(DATASHEET_DIR, file);
    console.log(`→ ${title}`);
    try {
      const buf = new Uint8Array(await readFile(path));
      const text = await extractPdfText(buf);
      const chunks = chunkMarkdown(text, title);
      if (!chunks.length) {
        console.warn("   skip: no chunks produced");
        continue;
      }

      const result = await ingestDocument(supabase, {
        source: "datasheet",
        title,
        url: `local:./datasheets/${file}`,
        raw: text,
        chunks,
      });

      if (result.skipped) {
        skipped++;
        console.log("   ✓ unchanged");
      } else {
        ok++;
        console.log(`   ✓ ${result.chunkCount} chunks`);
      }
    } catch (err) {
      console.error(`   error:`, err);
    }
  }

  console.log(`\nDone. ${ok} ingested, ${skipped} unchanged.`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
