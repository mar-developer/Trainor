import Link from "next/link";
import { cn } from "@/lib/utils";
import { Lock, Check } from "lucide-react";
import type { ComponentCard } from "@/lib/data/mock";
import { CategoryBadge } from "@/components/category-badge";
import { hasPinout } from "@/components/pinouts";

const CATEGORY_BG: Record<string, string> = {
  led: "bg-led/10 border-led/40 hover:border-led",
  resistor: "bg-resistor/10 border-resistor/40 hover:border-resistor",
  sensor: "bg-sensor/10 border-sensor/40 hover:border-sensor",
  motor: "bg-motor/10 border-motor/40 hover:border-motor",
  display: "bg-display/10 border-display/40 hover:border-display",
  switch: "bg-switch/10 border-switch/40 hover:border-switch",
  ic: "bg-ic/10 border-ic/40 hover:border-ic",
  board: "bg-board/10 border-board/40 hover:border-board",
  tool: "bg-tool/10 border-tool/40 hover:border-tool",
  wire: "bg-wire/10 border-wire/40 hover:border-wire",
};

const CATEGORY_ICON: Record<string, string> = {
  led: "text-led",
  resistor: "text-resistor",
  sensor: "text-sensor",
  motor: "text-motor",
  display: "text-display",
  switch: "text-switch",
  ic: "text-ic",
  board: "text-board",
  tool: "text-tool",
  wire: "text-wire",
};

export function ComponentExplorer({
  components,
}: {
  components: ComponentCard[];
}) {
  const done = components.filter((c) => c.status === "done").length;

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h3 className="text-lg font-semibold">Component explorer</h3>
          <p className="text-sm text-muted-foreground">
            {done} of {components.length} components covered — pick a remaining
            one to unlock the next lesson.
          </p>
        </div>
        <div className="hidden items-center gap-2 text-xs text-muted-foreground sm:flex">
          <span className="inline-flex items-center gap-1">
            <span className="size-2 rounded-full bg-foreground/80" /> done
          </span>
          <span className="inline-flex items-center gap-1">
            <span className="size-2 rounded-full bg-foreground/30" /> remaining
          </span>
          <span className="inline-flex items-center gap-1">
            <Lock className="size-3" /> locked
          </span>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
        {components.map((c) => {
          const Icon = c.icon;
          const isDone = c.status === "done";
          const isLocked = c.status === "locked";
          const clickable = (isDone || !isLocked) && hasPinout(c.slug);

          const className = cn(
            "group relative flex flex-col gap-3 rounded-xl border p-4 text-left transition",
            "focus:outline-none focus-visible:ring-2 focus-visible:ring-ring",
            isDone && "border-dashed border-border/60 hover:border-solid hover:border-foreground/40 hover:opacity-100",
            isDone && !clickable && "opacity-60",
            isDone && clickable && "opacity-80 hover:opacity-100",
            isLocked && "cursor-not-allowed opacity-40",
            !isDone && !isLocked && CATEGORY_BG[c.category],
          );

          const body = (
            <>
              <div className="flex items-start justify-between">
                <Icon
                  className={cn(
                    "size-6",
                    isDone
                      ? "text-muted-foreground group-hover:text-foreground"
                      : CATEGORY_ICON[c.category],
                  )}
                />
                {isDone && (
                  <span className="flex size-5 items-center justify-center rounded-full bg-foreground/80 text-background">
                    <Check className="size-3" />
                  </span>
                )}
                {isLocked && <Lock className="size-4 text-muted-foreground" />}
              </div>
              <div className="space-y-1">
                <h4 className="text-sm font-semibold leading-tight">
                  {c.name}
                </h4>
                <p className="text-xs text-muted-foreground">{c.blurb}</p>
              </div>
              <CategoryBadge category={c.category} className="self-start" />
            </>
          );

          if (clickable) {
            return (
              <Link key={c.slug} href={`/components/${c.slug}`} className={className}>
                {body}
              </Link>
            );
          }

          return (
            <button
              key={c.slug}
              disabled={isLocked}
              className={className}
            >
              {body}
            </button>
          );
        })}
      </div>
    </div>
  );
}
