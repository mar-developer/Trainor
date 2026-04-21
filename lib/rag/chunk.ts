// Markdown chunker tuned for the Arduino spec.
// Strategy: split by H2 → H3, keep heading path as metadata, cap each chunk at
// ~1000 tokens (rough 4 char/token estimate). Chunks below minChars get merged
// with their next sibling so we don't produce noise-sized fragments.

export interface Chunk {
  content: string;
  headingPath: string;
  tokenCount: number;
}

const MAX_CHARS = 4000; // ≈ 1000 tokens
const MIN_CHARS = 400;

export function chunkMarkdown(md: string, rootTitle: string): Chunk[] {
  const lines = md.split(/\r?\n/);
  const sections: { heading: string; body: string[] }[] = [];

  let currentH2 = "";
  let currentH3 = "";
  let buffer: string[] = [];

  const flush = () => {
    if (!buffer.length) return;
    const heading = [rootTitle, currentH2, currentH3].filter(Boolean).join(" › ");
    sections.push({ heading, body: [...buffer] });
    buffer = [];
  };

  for (const line of lines) {
    const h2 = line.match(/^##\s+(.+)$/);
    const h3 = line.match(/^###\s+(.+)$/);
    if (h2) {
      flush();
      currentH2 = h2[1].trim();
      currentH3 = "";
      continue;
    }
    if (h3) {
      flush();
      currentH3 = h3[1].trim();
      continue;
    }
    buffer.push(line);
  }
  flush();

  // Split oversized sections; merge undersized ones.
  const chunks: Chunk[] = [];
  for (const s of sections) {
    const body = s.body.join("\n").trim();
    if (!body) continue;

    if (body.length <= MAX_CHARS) {
      chunks.push({
        content: body,
        headingPath: s.heading,
        tokenCount: estimateTokens(body),
      });
      continue;
    }

    // Paragraph-level split for oversized sections.
    const paragraphs = body.split(/\n\s*\n/);
    let acc: string[] = [];
    for (const p of paragraphs) {
      const candidate = [...acc, p].join("\n\n");
      if (candidate.length > MAX_CHARS && acc.length) {
        const content = acc.join("\n\n");
        chunks.push({
          content,
          headingPath: s.heading,
          tokenCount: estimateTokens(content),
        });
        acc = [p];
      } else {
        acc.push(p);
      }
    }
    if (acc.length) {
      const content = acc.join("\n\n");
      chunks.push({
        content,
        headingPath: s.heading,
        tokenCount: estimateTokens(content),
      });
    }
  }

  // Merge tiny chunks into the next sibling that shares a heading prefix.
  const merged: Chunk[] = [];
  for (const c of chunks) {
    const last = merged[merged.length - 1];
    if (
      last &&
      last.content.length < MIN_CHARS &&
      samePrefix(last.headingPath, c.headingPath)
    ) {
      last.content = `${last.content}\n\n${c.content}`;
      last.tokenCount = estimateTokens(last.content);
      last.headingPath = commonPrefix(last.headingPath, c.headingPath);
      continue;
    }
    merged.push(c);
  }

  return merged;
}

function estimateTokens(text: string) {
  return Math.max(1, Math.round(text.length / 4));
}

function samePrefix(a: string, b: string) {
  return a.split(" › ")[0] === b.split(" › ")[0];
}

function commonPrefix(a: string, b: string) {
  const pa = a.split(" › ");
  const pb = b.split(" › ");
  const out: string[] = [];
  for (let i = 0; i < Math.min(pa.length, pb.length); i++) {
    if (pa[i] === pb[i]) out.push(pa[i]);
    else break;
  }
  return out.join(" › ");
}
