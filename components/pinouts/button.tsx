export function ButtonPinout() {
  return (
    <svg
      viewBox="0 0 320 240"
      className="w-full"
      role="img"
      aria-label="Tactile button pinout — 4 legs, two pairs. A1↔A2 left side, B1↔B2 right side. A↔B closes when pressed."
    >
      <title>Tactile button</title>

      {/* Body */}
      <rect
        x="100"
        y="70"
        width="120"
        height="100"
        rx="8"
        fill="var(--color-switch)"
        opacity="0.15"
        stroke="var(--color-switch)"
        strokeWidth="1.5"
      />
      <circle
        cx="160"
        cy="120"
        r="22"
        fill="var(--color-switch)"
        opacity="0.4"
      />

      {/* Legs */}
      <line x1="115" y1="70" x2="115" y2="30" stroke="currentColor" strokeWidth="3" />
      <line x1="115" y1="170" x2="115" y2="210" stroke="currentColor" strokeWidth="3" />
      <line x1="205" y1="70" x2="205" y2="30" stroke="currentColor" strokeWidth="3" />
      <line x1="205" y1="170" x2="205" y2="210" stroke="currentColor" strokeWidth="3" />

      {/* Always-connected indicators */}
      <path
        d="M 115 50 L 115 70"
        stroke="var(--color-switch)"
        strokeWidth="1.5"
        strokeDasharray="2 2"
      />
      <path
        d="M 115 170 L 115 190"
        stroke="var(--color-switch)"
        strokeWidth="1.5"
        strokeDasharray="2 2"
      />

      {/* Pin labels */}
      <text x="115" y="20" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        A1
      </text>
      <text x="115" y="228" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        A2
      </text>
      <text x="205" y="20" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        B1
      </text>
      <text x="205" y="228" fontSize="12" textAnchor="middle" fontWeight="600" fill="currentColor">
        B2
      </text>

      {/* Notes */}
      <text x="10" y="125" fontSize="10" fill="currentColor" opacity="0.7">
        A1↔A2 always
      </text>
      <text x="240" y="125" fontSize="10" fill="currentColor" opacity="0.7">
        B1↔B2 always
      </text>
      <text x="160" y="128" fontSize="10" textAnchor="middle" fill="currentColor" fontWeight="600">
        A↔B when pressed
      </text>
    </svg>
  );
}
