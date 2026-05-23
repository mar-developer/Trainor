import { cookies } from "next/headers";
import { createServerClient } from "@supabase/ssr";
import type { Database } from "@/lib/supabase/types";

// Server Components, Route Handlers, Server Actions.
// Next 16: cookies() is async — await it inside getAll/setAll.
export async function createClient() {
  const cookieStore = await cookies();

  return createServerClient<Database>(
    // Prefer a server-only URL when set (e.g. reaching the host's Supabase from
    // inside a container); falls back to the public URL on host/Vercel.
    (process.env.SUPABASE_URL ?? process.env.NEXT_PUBLIC_SUPABASE_URL)!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            for (const { name, value, options } of cookiesToSet) {
              cookieStore.set(name, value, options);
            }
          } catch {
            // Set in a Server Component — session refresh is handled by proxy.ts.
          }
        },
      },
    },
  );
}
