import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { Illustration, splitLessonBody } from "@/components/illustrations";
import { cn } from "@/lib/utils";

/**
 * Renders a lesson's `body_md` with:
 *  - GitHub-flavored markdown (tables, task lists, strikethrough)
 *  - Inline illustrations via `<!-- ill:NAME -->` markers
 *  - Themed typography that matches the app
 */
export function LessonBody({ body }: { body: string }) {
  const segments = splitLessonBody(body);
  return (
    <article className="space-y-4 rounded-xl border bg-card p-5 text-sm leading-relaxed sm:p-6">
      {segments.map((seg, i) =>
        seg.kind === "ill" ? (
          <Illustration key={i} id={seg.id} />
        ) : (
          <ReactMarkdown
            key={i}
            remarkPlugins={[remarkGfm]}
            components={MD_COMPONENTS}
          >
            {seg.text}
          </ReactMarkdown>
        ),
      )}
    </article>
  );
}

// react-markdown passes an internal `node` prop to every component; it must
// not reach the DOM. We strip it in each custom renderer below.
type HProps = React.HTMLAttributes<HTMLHeadingElement> & { node?: unknown };
type PProps = React.HTMLAttributes<HTMLParagraphElement> & { node?: unknown };
type LProps = React.HTMLAttributes<HTMLUListElement> & { node?: unknown };
type CProps = React.HTMLAttributes<HTMLElement> & { inline?: boolean; node?: unknown };
type LinkProps = React.AnchorHTMLAttributes<HTMLAnchorElement> & { node?: unknown };
type QProps = React.HTMLAttributes<HTMLQuoteElement> & { node?: unknown };
type PreProps = React.HTMLAttributes<HTMLPreElement> & { node?: unknown };
type TableProps = React.TableHTMLAttributes<HTMLTableElement> & { node?: unknown };
type CellProps = React.TdHTMLAttributes<HTMLTableCellElement> & { node?: unknown };
type ThProps = React.ThHTMLAttributes<HTMLTableCellElement> & { node?: unknown };
type StrongProps = React.HTMLAttributes<HTMLElement> & { node?: unknown };

const MD_COMPONENTS = {
  h1: ({ className, node: _n, ...p }: HProps) => (
    <h1 className={cn("mt-4 text-2xl font-semibold tracking-tight", className)} {...p} />
  ),
  h2: ({ className, node: _n, ...p }: HProps) => (
    <h2 className={cn("mt-5 text-lg font-semibold tracking-tight", className)} {...p} />
  ),
  h3: ({ className, node: _n, ...p }: HProps) => (
    <h3 className={cn("mt-4 text-base font-semibold", className)} {...p} />
  ),
  p: ({ className, node: _n, ...p }: PProps) => (
    <p className={cn("leading-7 text-foreground/90", className)} {...p} />
  ),
  ul: ({ className, node: _n, ...p }: LProps) => (
    <ul className={cn("ml-6 list-disc space-y-1", className)} {...p} />
  ),
  ol: ({ className, node: _n, ...p }: LProps) => (
    <ol className={cn("ml-6 list-decimal space-y-1", className)} {...p} />
  ),
  blockquote: ({ className, node: _n, ...p }: QProps) => (
    <blockquote
      className={cn(
        "border-l-2 border-info bg-info/5 px-4 py-2 text-sm italic text-foreground/80",
        className,
      )}
      {...p}
    />
  ),
  a: ({ className, node: _n, ...p }: LinkProps) => (
    <a
      className={cn("font-medium text-info underline underline-offset-2 hover:text-foreground", className)}
      target={p.href?.startsWith("http") ? "_blank" : undefined}
      rel={p.href?.startsWith("http") ? "noreferrer" : undefined}
      {...p}
    />
  ),
  code: ({ className, inline, node: _n, children, ...rest }: CProps) => {
    if (inline) {
      return (
        <code
          className={cn(
            "rounded-md bg-muted px-1.5 py-0.5 font-mono text-[0.85em] text-foreground",
            className,
          )}
          {...rest}
        >
          {children}
        </code>
      );
    }
    return (
      <code className={cn("block font-mono text-xs leading-6", className)} {...rest}>
        {children}
      </code>
    );
  },
  pre: ({ className, node: _n, ...p }: PreProps) => (
    <pre
      className={cn(
        "overflow-x-auto rounded-lg border bg-muted/60 p-3 text-xs leading-relaxed",
        className,
      )}
      {...p}
    />
  ),
  table: ({ className, node: _n, ...p }: TableProps) => (
    <div className="overflow-x-auto">
      <table className={cn("w-full border-collapse text-left text-xs", className)} {...p} />
    </div>
  ),
  th: ({ className, node: _n, ...p }: ThProps) => (
    <th
      className={cn(
        "border-b border-border bg-muted/40 px-2 py-1.5 font-semibold",
        className,
      )}
      {...p}
    />
  ),
  td: ({ className, node: _n, ...p }: CellProps) => (
    <td className={cn("border-b border-border/40 px-2 py-1.5", className)} {...p} />
  ),
  hr: () => <hr className="my-4 border-border" />,
  strong: ({ className, node: _n, ...p }: StrongProps) => (
    <strong className={cn("font-semibold text-foreground", className)} {...p} />
  ),
};
