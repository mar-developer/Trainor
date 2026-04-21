export function LedPinout() {
  return (
    <svg
      viewBox="0 0 320 180"
      className="w-full"
      role="img"
      aria-label="LED pinout — anode (long leg, +) and cathode (short leg, flat side, −)"
    >
      <title>LED pinout</title>

      {/* Bulb — dome + flat on cathode side */}
      <path
        d="M 130 50 Q 130 20 160 20 Q 190 20 190 50 L 190 100 L 130 100 Z"
        fill="var(--color-led)"
        opacity="0.2"
        stroke="var(--color-led)"
        strokeWidth="1.5"
      />
      {/* Flat marker on cathode side */}
      <line
        x1="185"
        y1="55"
        x2="185"
        y2="100"
        stroke="var(--color-led)"
        strokeWidth="2"
      />

      {/* Leads — long (anode, left) and short (cathode, right) */}
      <line x1="145" y1="100" x2="145" y2="165" stroke="currentColor" strokeWidth="3" />
      <line x1="175" y1="100" x2="175" y2="145" stroke="currentColor" strokeWidth="3" />

      {/* Labels */}
      <text x="100" y="150" fontSize="11" fill="currentColor" opacity="0.7" textAnchor="end">
        long leg
      </text>
      <text x="100" y="165" fontSize="11" fill="currentColor" textAnchor="end" fontWeight="600">
        anode (+)
      </text>
      <line x1="108" y1="147" x2="140" y2="147" stroke="currentColor" strokeWidth="1" opacity="0.4" />

      <text x="220" y="130" fontSize="11" fill="currentColor" opacity="0.7">
        short leg · flat side
      </text>
      <text x="220" y="145" fontSize="11" fill="currentColor" fontWeight="600">
        cathode (−)
      </text>
      <line x1="180" y1="130" x2="216" y2="130" stroke="currentColor" strokeWidth="1" opacity="0.4" />
    </svg>
  );
}
