export function PotentiometerPinout() {
  return (
    <svg
      viewBox="0 0 320 220"
      className="w-full"
      role="img"
      aria-label="10KΩ potentiometer pinout — Pin 1 to 5V, Pin 2 (wiper) output, Pin 3 to GND. Total resistance Pin 1 to Pin 3 is always 10KΩ."
    >
      <title>10KΩ Potentiometer</title>

      {/* Body */}
      <circle cx="160" cy="80" r="50" fill="var(--color-sensor)" opacity="0.15" stroke="var(--color-sensor)" strokeWidth="1.5" />
      <circle cx="160" cy="80" r="18" fill="var(--color-sensor)" opacity="0.4" />
      {/* Knob indicator */}
      <line x1="160" y1="80" x2="178" y2="54" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />

      {/* Pins */}
      <line x1="110" y1="130" x2="110" y2="190" stroke="currentColor" strokeWidth="3" />
      <line x1="160" y1="130" x2="160" y2="190" stroke="currentColor" strokeWidth="3" />
      <line x1="210" y1="130" x2="210" y2="190" stroke="currentColor" strokeWidth="3" />

      <text x="110" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        1
      </text>
      <text x="160" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        2
      </text>
      <text x="210" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        3
      </text>

      {/* Annotations */}
      <text x="10" y="155" fontSize="10" fill="currentColor" opacity="0.7">
        5V
      </text>
      <text x="135" y="155" fontSize="10" fill="currentColor" opacity="0.7">
        wiper (output)
      </text>
      <text x="235" y="155" fontSize="10" fill="currentColor" opacity="0.7">
        GND
      </text>

      <text x="160" y="40" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">
        Pin 1 ↔ Pin 3 = 10 KΩ (always)
      </text>
    </svg>
  );
}
