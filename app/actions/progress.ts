"use server";

// Progress server actions: toggleStep + saveStepReport.

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { database } from "@/lib/db";
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
  const sql = database();

  if (done) {
    await sql`
      insert into public.progress (user_id, lesson_id, step_id, completed_at)
      values (${userId}, ${lessonId}, ${stepId}, now())
      on conflict (user_id, lesson_id, step_id)
      do update set completed_at = excluded.completed_at
    `;
  } else {
    await sql`
      delete from public.progress
       where user_id = ${userId}
         and lesson_id = ${lessonId}
         and step_id = ${stepId}
    `;
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
  const sql = database();

  // Logging a reading implicitly marks the step complete — matches the
  // spec's "report what you measured" UX pattern (arduino_trainer_spec.md §6).
  await sql`
    insert into public.progress
      (user_id, lesson_id, step_id, completed_at, self_report)
    values (${userId}, ${lessonId}, ${stepId}, now(), ${sql.json({ text })})
    on conflict (user_id, lesson_id, step_id)
    do update set
      completed_at = excluded.completed_at,
      self_report = excluded.self_report
  `;

  revalidatePath(`/modules/${moduleSlug}`);
  revalidatePath("/");
}
