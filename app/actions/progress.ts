"use server";

// Progress server actions: toggleStep + saveStepReport.
// Writes go through the service-role client so they bypass RLS — safe in
// single-user mode because we always scope by DEFAULT_USER_ID on the server.
// When real auth ships, switch to the session client and let RLS enforce.

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { createServiceClient } from "@/lib/supabase/service";
import { getCurrentUserId } from "@/lib/auth";

const toggleSchema = z.object({
  lessonId: z.string().uuid(),
  stepId: z.string().uuid(),
  moduleSlug: z.string().min(1),
  done: z.boolean(),
});

export async function toggleStepComplete(input: z.infer<typeof toggleSchema>) {
  const { lessonId, stepId, moduleSlug, done } = toggleSchema.parse(input);
  const userId = await getCurrentUserId();
  const supabase = createServiceClient();

  if (done) {
    const { error } = await supabase.from("progress").upsert(
      {
        user_id: userId,
        lesson_id: lessonId,
        step_id: stepId,
        completed_at: new Date().toISOString(),
      },
      { onConflict: "user_id,lesson_id,step_id" },
    );
    if (error) throw error;
  } else {
    const { error } = await supabase
      .from("progress")
      .delete()
      .match({ user_id: userId, lesson_id: lessonId, step_id: stepId });
    if (error) throw error;
  }

  revalidatePath(`/modules/${moduleSlug}`);
  revalidatePath("/");
}

const reportSchema = z.object({
  lessonId: z.string().uuid(),
  stepId: z.string().uuid(),
  moduleSlug: z.string().min(1),
  text: z.string().min(1).max(2000),
});

export async function saveStepReport(input: z.infer<typeof reportSchema>) {
  const { lessonId, stepId, moduleSlug, text } = reportSchema.parse(input);
  const userId = await getCurrentUserId();
  const supabase = createServiceClient();

  // Logging a reading implicitly marks the step complete — matches the
  // spec's "report what you measured" UX pattern (arduino_trainer_spec.md §6).
  const { error } = await supabase.from("progress").upsert(
    {
      user_id: userId,
      lesson_id: lessonId,
      step_id: stepId,
      completed_at: new Date().toISOString(),
      self_report: { text },
    },
    { onConflict: "user_id,lesson_id,step_id" },
  );
  if (error) throw error;

  revalidatePath(`/modules/${moduleSlug}`);
  revalidatePath("/");
}
