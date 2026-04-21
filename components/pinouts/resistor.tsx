export function ResistorPinout() {
  return (
    <svg
      viewBox="0 0 320 120"
      className="w-full"
      role="img"
      aria-label="Resistor pinout — 220Ω (red-red-brown-gold)"
    >
      <title>220Ω 5% resistor</title>
      {/* Leads */}
      <line x1="10" y1="60" x2="90" y2="60" stroke="currentColor" strokeWidth="3" />
      <line x1="230" y1="60" x2="310" y2="60" stroke="currentColor" strokeWidth="3" />

      {/* Body */}
      <rect
        x="90"
        y="38"
        width="140"
        height="44"
        rx="22"
        fill="var(--color-resistor)"
        opacity="0.15"
        stroke="var(--color-resistor)"
        strokeWidth="1.5"
      />

      {/* Bands — 220Ω: red red brown gold */}
      <rect x="112" y="38" width="8" height="44" fill="#ef4444" />
      <rect x="132" y="38" width="8" height="44" fill="#ef4444" />
      <rect x="152" y="38" width="8" height="44" fill="#b45309" />
      <rect x="202" y="38" width="8" height="44" fill="#eab308" />

      {/* Labels */}
      <text
        x="30"
        y="90"
        fontSize="11"
        fill="currentColor"
        opacity="0.7"
      >
        lead A
      </text>
      <text
        x="260"
        y="90"
        fontSize="11"
        fill="currentColor"
        opacity="0.7"
      >
        lead B
      </text>
      <text
        x="160"
        y="28"
        fontSize="11"
        fill="currentColor"
        textAnchor="middle"
        fontWeight="600"
      >
        220 Ω · 5%
      </text>
    </svg>
  );
}
