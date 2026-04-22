import Link from "next/link";
import { ArrowRight, BookOpen } from "lucide-react";
import { cn } from "@/lib/utils";
import { buttonVariants } from "@/components/ui/button";
import type { CourseSummary } from "@/lib/data/repo";

export function CourseCard({ course }: { course: CourseSummary }) {
  const isArduino = course.slug === "arduino-electronics-trainer";

  return (
    <article
      className={cn(
        "group relative flex flex-col gap-4 overflow-hidden rounded-2xl border bg-card p-5 transition hover:border-foreground/30 hover:shadow-sm",
      )}
    >
      {/* Accent bar along the top */}
      <div
        aria-hidden
        className="absolute inset-x-0 top-0 h-1 bg-gradient-to-r from-primary/40 via-info/40 to-sensor/40"
      />

      <header className="flex items-start gap-3">
        <span
          className={cn(
            "flex size-10 shrink-0 items-center justify-center rounded-xl",
            isArduino ? "bg-led/15 text-led" : "bg-primary/10 text-primary",
          )}
        >
          <BookOpen className="size-5" />
        </span>
        <div className="flex-1 min-w-0">
          <h3 className="truncate font-semibold">{course.title}</h3>
          <p className="line-clamp-2 text-xs text-muted-foreground">
            {course.description}
          </p>
        </div>
      </header>

      <div className="space-y-1.5">
        <div className="flex items-center justify-between text-xs">
          <span className="text-muted-foreground">
            {course.completeCount} of {course.moduleCount} modules
          </span>
          <span className="font-mono tabular-nums">{course.percent}%</span>
        </div>
        <div className="h-1.5 overflow-hidden rounded-full bg-muted">
          <div
            className="h-full rounded-full bg-primary transition-all"
            style={{ width: `${course.percent}%` }}
          />
        </div>
      </div>

      <div className="mt-auto flex items-center justify-between gap-3 pt-2">
        <div className="min-w-0 text-xs text-muted-foreground">
          {course.continueModule ? (
            <>
              <p className="uppercase tracking-wide">Next up</p>
              <p className="truncate font-medium text-foreground">
                {course.continueModule.number} · {course.continueModule.title}
              </p>
            </>
          ) : (
            <p>All modules complete 🎉</p>
          )}
        </div>
        <Link
          href={`/courses/${course.slug}`}
          className={buttonVariants({ size: "sm" })}
          aria-label={`Open ${course.title}`}
        >
          Open
          <ArrowRight className="size-3.5" />
        </Link>
      </div>
    </article>
  );
}
