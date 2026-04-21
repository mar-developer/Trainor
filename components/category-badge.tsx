import { cn } from "@/lib/utils";
import type { ComponentCategory } from "@/lib/data/mock";
import { CATEGORY_LABEL } from "@/lib/data/mock";

const CATEGORY_CLASSES: Record<ComponentCategory, string> = {
  led: "bg-led text-led-foreground",
  resistor: "bg-resistor text-resistor-foreground",
  sensor: "bg-sensor text-sensor-foreground",
  motor: "bg-motor text-motor-foreground",
  display: "bg-display text-display-foreground",
  switch: "bg-switch text-switch-foreground",
  ic: "bg-ic text-ic-foreground",
  board: "bg-board text-board-foreground",
  tool: "bg-tool text-tool-foreground",
  wire: "bg-wire text-wire-foreground",
};

export function CategoryBadge({
  category,
  className,
}: {
  category: ComponentCategory;
  className?: string;
}) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium tracking-wide",
        CATEGORY_CLASSES[category],
        className,
      )}
    >
      {CATEGORY_LABEL[category]}
    </span>
  );
}

export function CategoryDot({
  category,
  className,
}: {
  category: ComponentCategory;
  className?: string;
}) {
  return (
    <span
      className={cn(
        "inline-block size-2 rounded-full",
        CATEGORY_CLASSES[category],
        className,
      )}
      aria-hidden
    />
  );
}
