import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowLeft } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";
import { CategoryBadge } from "@/components/category-badge";
import { Pinout, hasPinout } from "@/components/pinouts";
import { getComponentBySlug, getComponents } from "@/lib/data/repo";
import { CATEGORY_LABEL } from "@/lib/data/mock";

export default async function ComponentDetailPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const component = await getComponentBySlug(slug);
  if (!component) notFound();

  const all = await getComponents();
  const related = all.filter(
    (c) => c.category === component.category && c.slug !== component.slug,
  );

  return (
    <div className="flex-1">
      <header className="flex h-16 items-center gap-3 border-b px-4 sm:px-6">
        <Link
          href="/courses/arduino-electronics-trainer"
          className={buttonVariants({ variant: "ghost", size: "sm" })}
        >
          <ArrowLeft className="size-4" />
          Arduino Electronics Trainer
        </Link>
        <div className="ml-2 text-xs text-muted-foreground">
          <span className="font-mono">components</span>
          <span className="mx-1">·</span>
          <span>{CATEGORY_LABEL[component.category]}</span>
        </div>
      </header>

      <div className="mx-auto w-full max-w-4xl space-y-8 px-4 py-6 sm:px-6">
        <div className="flex items-start justify-between gap-4">
          <div className="space-y-2">
            <CategoryBadge category={component.category} />
            <h1 className="text-3xl font-semibold tracking-tight">
              {component.name}
            </h1>
            <p className="max-w-2xl text-muted-foreground">
              {component.blurb}
            </p>
          </div>
        </div>

        <section className="space-y-3">
          <h2 className="text-lg font-semibold">Pinout</h2>
          {hasPinout(component.slug) ? (
            <Pinout slug={component.slug} />
          ) : (
            <div className="rounded-xl border bg-muted/40 p-6 text-sm text-muted-foreground">
              Diagram coming in a later module. For now, check{" "}
              <Link
                href="/chat"
                className="text-foreground underline underline-offset-4"
              >
                the tutor chat
              </Link>{" "}
              — it can describe the pinout from the datasheet.
            </div>
          )}
        </section>

        {related.length > 0 && (
          <section className="space-y-3">
            <h2 className="text-lg font-semibold">
              Other {CATEGORY_LABEL[component.category]}
            </h2>
            <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
              {related.map((c) => (
                <Link
                  key={c.slug}
                  href={`/components/${c.slug}`}
                  className="rounded-xl border bg-card p-4 transition hover:border-foreground/30"
                >
                  <h3 className="font-semibold">{c.name}</h3>
                  <p className="mt-1 text-xs text-muted-foreground">
                    {c.blurb}
                  </p>
                </Link>
              ))}
            </div>
          </section>
        )}
      </div>
    </div>
  );
}
