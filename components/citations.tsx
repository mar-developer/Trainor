import { BookOpen, FileText } from "lucide-react";
import { cn } from "@/lib/utils";

export interface Citation {
  index: number;
  source: string;
  heading: string;
}

export function InlineCitation({ index }: { index: number }) {
  return (
    <sup className="mx-0.5 rounded-sm bg-info/10 px-1 font-mono text-[0.65rem] text-info">
      [{index}]
    </sup>
  );
}

export function CitationList({
  citations,
  className,
}: {
  citations: Citation[];
  className?: string;
}) {
  if (!citations.length) return null;
  return (
    <ol className={cn("mt-3 space-y-1 text-xs", className)}>
      {citations.map((c) => {
        const isSpec = c.source === "arduino_trainer_spec.md";
        const Icon = isSpec ? BookOpen : FileText;
        return (
          <li
            key={c.index}
            className="flex items-start gap-2 rounded-md bg-muted/60 px-2 py-1.5"
          >
            <span className="mt-0.5 font-mono text-info">[{c.index}]</span>
            <Icon className="mt-0.5 size-3.5 shrink-0 text-muted-foreground" />
            <div className="min-w-0 flex-1">
              {c.heading ? (
                <>
                  <p className="truncate font-medium">{c.heading}</p>
                  <p className="truncate text-[0.7rem] text-muted-foreground">
                    {c.source}
                  </p>
                </>
              ) : (
                <p className="truncate font-medium">{c.source}</p>
              )}
            </div>
          </li>
        );
      })}
    </ol>
  );
}
