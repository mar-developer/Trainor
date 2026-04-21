export function TransistorPinout() {
  return (
    <svg
      viewBox="0 0 360 260"
      className="w-full"
      role="img"
      aria-label="PN2222 NPN transistor pinout — flat side facing you, legs down: E B C from left to right"
    >
      <title>PN2222 NPN transistor</title>

      {/* TO-92 body — flat side facing viewer */}
      <path
        d="M 120 30 Q 120 15 135 15 L 225 15 Q 240 15 240 30 L 240 100 L 120 100 Z"
        fill="var(--color-ic)"
        opacity="0.2"
        stroke="var(--color-ic)"
        strokeWidth="1.5"
      />
      {/* Flat side label */}
      <text
        x="180"
        y="58"
        fontSize="12"
        textAnchor="middle"
        fill="currentColor"
        fontWeight="600"
      >
        PN2222
      </text>
      <text
        x="180"
        y="76"
        fontSize="10"
        textAnchor="middle"
        fill="currentColor"
        opacity="0.7"
      >
        flat side facing you
      </text>

      {/* Legs */}
      <line x1="150" y1="100" x2="150" y2="190" stroke="currentColor" strokeWidth="3" />
      <line x1="180" y1="100" x2="180" y2="190" stroke="currentColor" strokeWidth="3" />
      <line x1="210" y1="100" x2="210" y2="190" stroke="currentColor" strokeWidth="3" />

      {/* Pin labels */}
      <text x="150" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        E
      </text>
      <text x="180" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        B
      </text>
      <text x="210" y="210" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        C
      </text>

      {/* Explanatory labels — positioned below the pins so nothing overlaps */}
      <text x="20" y="232" fontSize="10" fill="currentColor" opacity="0.8">
        E → GND   ·   B → 1 KΩ → signal   ·   C → load → 5 V
      </text>
    </svg>
  );
}
