// scripts/ingest-arduino-docs.ts — fetches curated arduino.cc reference
// pages, strips HTML to text, chunks, and upserts into the RAG store.
//
// Edit ARDUINO_URLS to expand coverage. Each URL is ingested as its own
// document (incremental: checksum-gated).
//
// Run: npm run ingest:arduino-docs

import { config as loadEnv } from "dotenv";
loadEnv({ path: ".env.local" });
loadEnv({ path: ".env", override: false });

import { convert } from "html-to-text";
import { chunkMarkdown } from "../lib/rag/chunk";
import { ingestDocument, supabaseFromEnv } from "../lib/rag/ingest";

const ARDUINO_URLS: Array<{ url: string; title: string }> = [
  // Language essentials
  { url: "https://docs.arduino.cc/language-reference/en/functions/digital-io/digitalwrite/", title: "Arduino Reference — digitalWrite()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/digital-io/digitalread/", title: "Arduino Reference — digitalRead()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/digital-io/pinmode/", title: "Arduino Reference — pinMode()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/analog-io/analogread/", title: "Arduino Reference — analogRead()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/analog-io/analogwrite/", title: "Arduino Reference — analogWrite()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/advanced-io/tone/", title: "Arduino Reference — tone()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/time/millis/", title: "Arduino Reference — millis()" },
  { url: "https://docs.arduino.cc/language-reference/en/functions/communication/serial/", title: "Arduino Reference — Serial" },
  // Getting-started / hardware
  { url: "https://docs.arduino.cc/hardware/uno-rev3", title: "Arduino Uno R3 — datasheet" },
];

function htmlToPlain(html: string): string {
  return convert(html, {
    wordwrap: false,
    selectors: [
      { selector: "nav", format: "skip" },
      { selector: "footer", format: "skip" },
      { selector: "script", format: "skip" },
      { selector: "style", format: "skip" },
      { selector: "a", options: { ignoreHref: true } },
    ],
  });
}

async function main() {
  const supabase = supabaseFromEnv();
  let ok = 0;
  let skipped = 0;

  for (const { url, title } of ARDUINO_URLS) {
    try {
      console.log(`→ ${url}`);
      const res = await fetch(url, {
        headers: { "user-agent": "trainor-ingester/1.0" },
      });
      if (!res.ok) {
        console.warn(`   skip: HTTP ${res.status}`);
        continue;
      }
      const html = await res.text();
      const text = htmlToPlain(html);

      // Treat as markdown so our H2/H3 chunker still does something useful
      // — html-to-text won't produce headings but paragraph splits are preserved.
      const chunks = chunkMarkdown(text, title);
      if (!chunks.length) {
        console.warn("   skip: no chunks produced");
        continue;
      }

      const result = await ingestDocument(supabase, {
        source: "arduino_docs",
        title,
        url,
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

  console.log(`\nDone. ${ok} ingested, ${skipped} unchanged, ${ARDUINO_URLS.length - ok - skipped} failed.`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
