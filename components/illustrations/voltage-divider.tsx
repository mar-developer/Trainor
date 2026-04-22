export function VoltageDivider() {
  return (
    <svg
      viewBox="0 0 520 240"
      className="w-full"
      role="img"
      aria-label="Voltage divider: 5V to reference resistor to sensor resistor to GND, with A0 tapping the midpoint"
    >
      {/* Rails */}
      <line x1="40" y1="40" x2="480" y2="40" stroke="var(--color-led)" strokeWidth="2" />
      <line x1="40" y1="200" x2="480" y2="200" stroke="currentColor" strokeWidth="2" opacity="0.4" />
      <text x="20" y="45" fontSize="11" textAnchor="end" fill="var(--color-led)" fontWeight="600">5V</text>
      <text x="20" y="205" fontSize="11" textAnchor="end" fill="currentColor" opacity="0.6">GND</text>

      {/* Reference resistor (top) */}
      <line x1="200" y1="40" x2="200" y2="60" stroke="currentColor" strokeWidth="2" />
      <path
        d="M 200 60 L 215 70 L 185 80 L 215 90 L 185 100 L 215 110 L 200 120"
        fill="none" stroke="var(--color-resistor)" strokeWidth="2.5"
      />
      <text x="230" y="85" fontSize="11" fill="currentColor" opacity="0.75">10 KΩ reference</text>

      {/* Sensor (bottom) */}
      <line x1="200" y1="120" x2="200" y2="140" stroke="currentColor" strokeWidth="2" />
      <rect x="178" y="140" width="44" height="44" rx="4" fill="var(--color-sensor)" opacity="0.2" stroke="var(--color-sensor)" strokeWidth="1.5" />
      <text x="200" y="163" fontSize="10" textAnchor="middle" fill="currentColor" fontWeight="700">LDR</text>
      <text x="200" y="176" fontSize="8" textAnchor="middle" fill="currentColor" opacity="0.65">0.5K–100K</text>
      <line x1="200" y1="184" x2="200" y2="200" stroke="currentColor" strokeWidth="2" />

      {/* Tap to A0 */}
      <line x1="200" y1="130" x2="330" y2="130" stroke="var(--color-info)" strokeWidth="2" />
      <circle cx="200" cy="130" r="4" fill="var(--color-info)" />
      <text x="340" y="124" fontSize="11" fill="var(--color-info)" fontWeight="700">A0</text>
      <text x="340" y="138" fontSize="9" fill="currentColor" opacity="0.65">analogRead → 0-1023</text>

      {/* Formula callout */}
      <g transform="translate(380, 60)">
        <rect x="0" y="0" width="120" height="96" rx="8" fill="var(--color-info)" opacity="0.12" stroke="var(--color-info)" strokeWidth="1" strokeDasharray="3 3" />
        <text x="10" y="20" fontSize="10" fill="var(--color-info)" fontWeight="700">MIDPOINT</text>
        <text x="10" y="42" fontSize="11" fill="currentColor" fontFamily="monospace">V_A0 = 5V ×</text>
        <line x1="10" y1="56" x2="110" y2="56" stroke="currentColor" opacity="0.4" />
        <text x="18" y="54" fontSize="10" fill="currentColor" fontFamily="monospace">R_sensor</text>
        <text x="12" y="72" fontSize="10" fill="currentColor" fontFamily="monospace">R_ref + R_sensor</text>
        <text x="10" y="90" fontSize="9" fill="currentColor" opacity="0.6">bright→low R→low V</text>
      </g>
    </svg>
  );
}
