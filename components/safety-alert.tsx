import { AlertTriangle, Info, ShieldAlert } from "lucide-react";
import { cn } from "@/lib/utils";

type Kind = "danger" | "caution" | "info";

const STYLES: Record<
  Kind,
  { wrap: string; icon: string; label: string; Icon: typeof Info }
> = {
  danger: {
    wrap: "border-danger/40 bg-danger/10 text-foreground",
    icon: "text-danger",
    label: "Danger",
    Icon: ShieldAlert,
  },
  caution: {
    wrap: "border-caution/40 bg-caution/10 text-foreground",
    icon: "text-caution",
    label: "Caution",
    Icon: AlertTriangle,
  },
  info: {
    wrap: "border-info/40 bg-info/10 text-foreground",
    icon: "text-info",
    label: "Good to know",
    Icon: Info,
  },
};

export function SafetyAlert({
  kind,
  message,
}: {
  kind: Kind;
  message: string;
}) {
  const s = STYLES[kind];
  const Icon = s.Icon;
  return (
    <div
      className={cn(
        "flex items-start gap-3 rounded-lg border p-3 text-sm",
        s.wrap,
      )}
    >
      <Icon className={cn("mt-0.5 size-4 shrink-0", s.icon)} />
      <div className="space-y-0.5">
        <p className={cn("text-xs font-semibold uppercase tracking-wide", s.icon)}>
          {s.label}
        </p>
        <p className="leading-relaxed">{message}</p>
      </div>
    </div>
  );
}
