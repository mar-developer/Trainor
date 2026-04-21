// Unified read API. Tries Supabase when env is configured, falls back to the
// typed mock data in ./mock so the app still renders locally without a DB.
// All functions are server-side (await cookies() inside the Supabase client).

import { createClient } from "@/lib/supabase/server";
import { createServiceClient } from "@/lib/supabase/service";
import { getCurrentUserId } from "@/lib/auth";
import {
  COMPONENTS,
  EXPERIMENTS,
  LESSONS,
  PHASE_ONE_MODULES,
  type ComponentCard,
  type ComponentCategory,
  type Experiment,
  type HandsOnStep,
  type LessonContent,
  type Module,
} from "@/lib/data/mock";

export type {
  ComponentCard,
  ComponentCategory,
  Experiment,
  HandsOnStep,
  LessonContent,
  Module,
};

function isSupabaseConfigured() {
  return Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_URL &&
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  );
}

// ─── Modules ──────────────────────────────────────────────────────────
export async function getPhaseOneModules(): Promise<Module[]> {
  if (!isSupabaseConfigured()) return PHASE_ONE_MODULES;

  try {
    const supabase = await createClient();
    // Sort numerically by `number` ("1.1", "1.2", ...) — avoids the PostgREST
    // reserved-word collision with the `order` column + .order() method.
    const { data, error } = await supabase
      .from("modules")
      .select("slug, number, title, kind, status, estimated_minutes, summary")
      .like("number", "1.%");
    if (error || !data) throw error ?? new Error("no data");
    return data
      .map(dbModuleToMock)
      .sort((a, b) => a.number.localeCompare(b.number, undefined, { numeric: true }));
  } catch (err) {
    console.warn("[repo] getPhaseOneModules falling back to mock:", err);
    return PHASE_ONE_MODULES;
  }
}

export async function getModuleBySlug(slug: string): Promise<Module | null> {
  if (!isSupabaseConfigured()) {
    return PHASE_ONE_MODULES.find((m) => m.slug === slug) ?? null;
  }

  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("modules")
      .select("slug, number, title, kind, status, estimated_minutes, summary")
      .eq("slug", slug)
      .maybeSingle();
    if (error) throw error;
    if (!data) return null;
    return dbModuleToMock(data);
  } catch (err) {
    console.warn("[repo] getModuleBySlug falling back to mock:", err);
    return PHASE_ONE_MODULES.find((m) => m.slug === slug) ?? null;
  }
}

function dbModuleToMock(row: Record<string, unknown>): Module {
  const statusRaw = row.status as string;
  return {
    slug: row.slug as string,
    number: row.number as string,
    title: row.title as string,
    kind: row.kind as Module["kind"],
    // DB uses snake_case enum; mock uses kebab-case strings.
    status:
      statusRaw === "not_started"
        ? "not-started"
        : statusRaw === "in_progress"
          ? "in-progress"
          : (statusRaw as Module["status"]),
    estimatedMinutes: (row.estimated_minutes as number) ?? 20,
    summary: (row.summary as string) ?? "",
  };
}

// ─── Components ───────────────────────────────────────────────────────
export async function getComponents(): Promise<ComponentCard[]> {
  if (!isSupabaseConfigured()) return COMPONENTS;

  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("components")
      .select("slug, name, category, blurb, status");
    if (error || !data) throw error ?? new Error("no data");

    // Merge with mock to preserve icon mapping — icons live in the client bundle.
    // Mock also defines the intended display order; we sort by it below.
    const iconBySlug = new Map(COMPONENTS.map((c) => [c.slug, c.icon]));
    const orderBySlug = new Map(COMPONENTS.map((c, i) => [c.slug, i]));

    return data
      .map<ComponentCard>((row) => ({
        slug: row.slug as string,
        name: row.name as string,
        category: row.category as ComponentCategory,
        blurb: row.blurb as string,
        status:
          row.status === "complete"
            ? "done"
            : row.status === "not_started"
              ? "remaining"
              : "locked",
        icon: iconBySlug.get(row.slug as string) ?? COMPONENTS[0].icon,
      }))
      .sort((a, b) => {
        const ao = orderBySlug.get(a.slug) ?? 99;
        const bo = orderBySlug.get(b.slug) ?? 99;
        return ao - bo;
      });
  } catch (err) {
    console.warn("[repo] getComponents falling back to mock:", err);
    return COMPONENTS;
  }
}

export async function getComponentBySlug(
  slug: string,
): Promise<ComponentCard | null> {
  const all = await getComponents();
  return all.find((c) => c.slug === slug) ?? null;
}

// ─── Lesson (by module slug) ──────────────────────────────────────────
export async function getLessonForModule(
  moduleSlug: string,
): Promise<(LessonContent & { lessonId?: string }) | null> {
  if (!isSupabaseConfigured()) return LESSONS[moduleSlug] ?? null;

  try {
    const supabase = await createClient();
    const { data: lessons, error } = await supabase
      .from("lessons")
      .select(
        `
          id,
          title,
          body_md,
          modules!inner (slug),
          hands_on_steps!hands_on_steps_lesson_id_fkey ( id, "order", instruction, expected_measurement ),
          lesson_safety ( "order", kind, message )
        `,
      )
      .eq("modules.slug", moduleSlug)
      .limit(1)
      .maybeSingle();

    if (error) throw error;
    if (!lessons) return null;

    const row = lessons as {
      id: string;
      title: string;
      body_md: string | null;
      hands_on_steps: Array<{
        id: string;
        order: number;
        instruction: string;
        expected_measurement: string | null;
      }>;
      lesson_safety: Array<{
        order: number;
        kind: "danger" | "caution" | "info";
        message: string;
      }>;
    };

    const steps: HandsOnStep[] = (row.hands_on_steps ?? [])
      .slice()
      .sort((a, b) => a.order - b.order)
      .map((s) => ({
        id: s.id,
        order: s.order,
        instruction: s.instruction,
        expected: s.expected_measurement ?? undefined,
      }));

    // Hydrate progress for each step (single user mode).
    // Uses the service-role client to bypass RLS — same trust model as the
    // server actions that write these rows. Flip to supabase.auth.getUser()
    // when real Supabase Auth ships.
    const userId = await getCurrentUserId();
    const stepIds = steps.map((s) => s.id).filter((id): id is string => Boolean(id));
    if (stepIds.length) {
      const admin = createServiceClient();
      const { data: progRows } = await admin
        .from("progress")
        .select("step_id, completed_at, self_report")
        .eq("user_id", userId)
        .in("step_id", stepIds);
      const byStep = new Map(
        (progRows ?? []).map((r) => [
          r.step_id as string,
          r as { completed_at: string; self_report: { text?: string } | null },
        ]),
      );
      steps.forEach((s) => {
        const p = s.id ? byStep.get(s.id) : undefined;
        s.completedAt = p?.completed_at ?? null;
        s.selfReport = p?.self_report?.text ?? null;
      });
    }

    return {
      lessonId: row.id,
      moduleSlug,
      title: row.title,
      body: row.body_md ?? "",
      handsOn: steps,
      safety: (row.lesson_safety ?? [])
        .slice()
        .sort((a, b) => a.order - b.order)
        .map((s) => ({ kind: s.kind, message: s.message })),
    };
  } catch (err) {
    console.warn("[repo] getLessonForModule falling back to mock:", err);
    return LESSONS[moduleSlug] ?? null;
  }
}

// ─── Lesson progress summary (for completion badges / auto-advance) ──
export async function getModuleProgressSummary(
  moduleSlug: string,
): Promise<{ totalSteps: number; completedStepOrders: number[] }> {
  if (!isSupabaseConfigured()) return { totalSteps: 0, completedStepOrders: [] };

  try {
    const supabase = await createClient();
    const admin = createServiceClient();
    const userId = await getCurrentUserId();

    // First fetch the lesson's steps (anon client is fine for curriculum).
    const { data: lesson } = await supabase
      .from("lessons")
      .select(
        `
          id,
          hands_on_steps!hands_on_steps_lesson_id_fkey ( id, "order" ),
          modules!inner (slug)
        `,
      )
      .eq("modules.slug", moduleSlug)
      .maybeSingle();

    if (!lesson) return { totalSteps: 0, completedStepOrders: [] };
    const steps = (lesson as { hands_on_steps?: Array<{ id: string; order: number }> })
      .hands_on_steps ?? [];
    const stepIds = steps.map((s) => s.id);
    if (!stepIds.length) return { totalSteps: 0, completedStepOrders: [] };

    // Progress requires service client to bypass RLS in single-user mode.
    const { data: done } = await admin
      .from("progress")
      .select("step_id")
      .eq("user_id", userId)
      .in("step_id", stepIds)
      .not("completed_at", "is", null);

    const doneSet = new Set((done ?? []).map((r) => r.step_id as string));
    return {
      totalSteps: steps.length,
      completedStepOrders: steps
        .filter((s) => doneSet.has(s.id))
        .map((s) => s.order),
    };
  } catch (err) {
    console.warn("[repo] getModuleProgressSummary failed:", err);
    return { totalSteps: 0, completedStepOrders: [] };
  }
}

// ─── Experiments (per-user) ──────────────────────────────────────────
// Uses the service-role client (RLS bypass) because single-user mode has no
// session. Scope-by-user is enforced explicitly with .eq('user_id', ...).
export async function getExperiments(): Promise<Experiment[]> {
  if (!isSupabaseConfigured()) return EXPERIMENTS;

  try {
    const admin = createServiceClient();
    const userId = await getCurrentUserId();
    const { data, error } = await admin
      .from("experiments")
      .select("id, title, observation, created_at")
      .eq("user_id", userId)
      .order("created_at", { ascending: false });
    if (error) throw error;
    if (!data || data.length === 0) return []; // empty state, not mock
    return data.map((row) => ({
      id: row.id as string,
      title: row.title as string,
      observation: (row.observation as string) ?? "",
      createdAt: new Date(row.created_at as string).toISOString().slice(0, 10),
    }));
  } catch (err) {
    console.warn("[repo] getExperiments falling back to mock:", err);
    return EXPERIMENTS;
  }
}
