export function RelayPinout() {
  return (
    <svg
      viewBox="0 0 360 240"
      className="w-full"
      role="img"
      aria-label="5V Relay module pinout. Low side: VCC / GND / IN. High side: COM / NO / NC — isolated up to 220V."
    >
      <title>5V Relay Module</title>

      {/* Module body */}
      <rect
        x="20"
        y="40"
        width="320"
        height="140"
        rx="8"
        fill="var(--color-ic)"
        opacity="0.12"
        stroke="var(--color-ic)"
        strokeWidth="1.5"
      />

      {/* Isolation barrier */}
      <line x1="180" y1="40" x2="180" y2="180" stroke="var(--color-danger)" strokeWidth="1.5" strokeDasharray="4 3" />
      <text x="180" y="30" fontSize="10" textAnchor="middle" fill="var(--color-danger)" fontWeight="600">
        electrical isolation
      </text>

      {/* Low side: Arduino */}
      <text x="100" y="60" fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">
        Arduino side (5V)
      </text>

      {/* Low side pins */}
      <g>
        <line x1="60" y1="120" x2="60" y2="180" stroke="currentColor" strokeWidth="3" />
        <line x1="100" y1="120" x2="100" y2="180" stroke="currentColor" strokeWidth="3" />
        <line x1="140" y1="120" x2="140" y2="180" stroke="currentColor" strokeWidth="3" />
        <text x="60" y="205" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">VCC</text>
        <text x="100" y="205" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">GND</text>
        <text x="140" y="205" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">IN</text>
        <text x="60" y="225" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">5V</text>
        <text x="100" y="225" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">0V</text>
        <text x="140" y="225" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">signal</text>
      </g>

      {/* High side: load */}
      <text x="270" y="60" fontSize="11" textAnchor="middle" fill="var(--color-danger)" fontWeight="600">
        Load side — up to 220V
      </text>

      {/* Screw terminals */}
      <g>
        <rect x="210" y="110" width="30" height="30" rx="4" fill="var(--color-danger)" opacity="0.18" stroke="var(--color-danger)" strokeWidth="1" />
        <rect x="255" y="110" width="30" height="30" rx="4" fill="var(--color-danger)" opacity="0.18" stroke="var(--color-danger)" strokeWidth="1" />
        <rect x="300" y="110" width="30" height="30" rx="4" fill="var(--color-danger)" opacity="0.18" stroke="var(--color-danger)" strokeWidth="1" />
        <text x="225" y="130" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">NC</text>
        <text x="270" y="130" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">COM</text>
        <text x="315" y="130" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">NO</text>
        <text x="225" y="160" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">default on</text>
        <text x="315" y="160" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">default off</text>
      </g>
    </svg>
  );
}
