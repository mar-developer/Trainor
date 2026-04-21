import { ResistorPinout } from "./resistor";
import { LedPinout } from "./led";
import { TransistorPinout } from "./transistor";
import { ButtonPinout } from "./button";
import { PotentiometerPinout } from "./potentiometer";
import { BuzzerPinout } from "./buzzer";
import { RelayPinout } from "./relay";

const REGISTRY: Record<string, () => React.ReactElement> = {
  resistor: ResistorPinout,
  led: LedPinout,
  transistor: TransistorPinout,
  button: ButtonPinout,
  potentiometer: PotentiometerPinout,
  buzzer: BuzzerPinout,
  relay: RelayPinout,
};

export function hasPinout(slug: string) {
  return slug in REGISTRY;
}

export function Pinout({ slug }: { slug: string }) {
  const Drawing = REGISTRY[slug];
  if (!Drawing) {
    return (
      <div className="rounded-xl border bg-muted/40 p-6 text-center text-sm text-muted-foreground">
        Pinout diagram for <span className="font-mono">{slug}</span> isn't drawn
        yet.
      </div>
    );
  }
  return (
    <div className="rounded-xl border bg-card p-4">
      <Drawing />
    </div>
  );
}
