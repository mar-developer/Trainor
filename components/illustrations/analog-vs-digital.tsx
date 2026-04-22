export function AnalogVsDigital() {
  return (
    <svg
      viewBox="0 0 720 240"
      className="w-full"
      role="img"
      aria-label="Analog signal is smooth (any value 0-5V); digital is stepped (HIGH or LOW only)"
    >
      {/* ── ANALOG (left) ── */}
      <g>
        <text x="180" y="22" fontSize="12" textAnchor="middle" fontWeight="700" fill="var(--color-info)">ANALOG</text>
        <text x="180" y="38" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.65">any value 0–5 V</text>

        {/* Axes */}
        <line x1="40" y1="60" x2="40" y2="200" stroke="currentColor" opacity="0.5" strokeWidth="1" />
        <line x1="40" y1="200" x2="320" y2="200" stroke="currentColor" opacity="0.5" strokeWidth="1" />

        {/* Sine-ish curve */}
        <path
          d="M 40 160 Q 80 90 120 120 T 200 140 T 280 80 T 320 130"
          fill="none" stroke="var(--color-info)" strokeWidth="2.5"
        >
          <animate attributeName="stroke-dashoffset" from="0" to="20" dur="2s" repeatCount="indefinite" />
        </path>

        <text x="20" y="70" fontSize="9" textAnchor="end" fill="currentColor" opacity="0.55">5V</text>
        <text x="20" y="200" fontSize="9" textAnchor="end" fill="currentColor" opacity="0.55">0V</text>
        <text x="180" y="224" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.55">time →</text>

        {/* Examples */}
        <g transform="translate(50, 210)">
          <text x="0" y="12" fontSize="9" fill="currentColor" opacity="0.7">potentiometer · LDR · thermistor · sound</text>
        </g>

        {/* Reading label */}
        <g transform="translate(340, 90)">
          <rect x="0" y="0" width="18" height="80" rx="3" fill="var(--color-info)" opacity="0.15" />
          <text x="9" y="14" fontSize="9" textAnchor="middle" fill="var(--color-info)" fontWeight="700">A0</text>
          <text x="9" y="50" fontSize="10" textAnchor="middle" fill="currentColor" fontWeight="700">512</text>
          <text x="9" y="70" fontSize="7" textAnchor="middle" fill="currentColor" opacity="0.6">0–1023</text>
        </g>
      </g>

      {/* Divider */}
      <line x1="400" y1="50" x2="400" y2="210" stroke="currentColor" opacity="0.15" strokeDasharray="4 3" />

      {/* ── DIGITAL (right) ── */}
      <g transform="translate(400, 0)">
        <text x="180" y="22" fontSize="12" textAnchor="middle" fontWeight="700" fill="var(--color-switch)">DIGITAL</text>
        <text x="180" y="38" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.65">HIGH (5V) or LOW (0V) only</text>

        <line x1="40" y1="60" x2="40" y2="200" stroke="currentColor" opacity="0.5" strokeWidth="1" />
        <line x1="40" y1="200" x2="320" y2="200" stroke="currentColor" opacity="0.5" strokeWidth="1" />

        {/* Square wave */}
        <path
          d="M 40 200 L 40 80 L 120 80 L 120 200 L 180 200 L 180 80 L 260 80 L 260 200 L 320 200"
          fill="none" stroke="var(--color-switch)" strokeWidth="2.5"
        />

        <text x="20" y="86" fontSize="9" textAnchor="end" fill="currentColor" opacity="0.55">HIGH</text>
        <text x="20" y="200" fontSize="9" textAnchor="end" fill="currentColor" opacity="0.55">LOW</text>
        <text x="180" y="224" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.55">time →</text>

        <g transform="translate(50, 210)">
          <text x="0" y="12" fontSize="9" fill="currentColor" opacity="0.7">button · tilt · reed · PIR · photo-interrupter</text>
        </g>

        {/* Reading label */}
        <g transform="translate(340, 90)">
          <rect x="0" y="0" width="18" height="80" rx="3" fill="var(--color-switch)" opacity="0.15" />
          <text x="9" y="14" fontSize="9" textAnchor="middle" fill="var(--color-switch)" fontWeight="700">D2</text>
          <text x="9" y="46" fontSize="9" textAnchor="middle" fill="currentColor" fontWeight="700">HIGH</text>
          <text x="9" y="60" fontSize="9" textAnchor="middle" fill="currentColor">/</text>
          <text x="9" y="74" fontSize="9" textAnchor="middle" fill="currentColor" fontWeight="700">LOW</text>
        </g>
      </g>
    </svg>
  );
}
