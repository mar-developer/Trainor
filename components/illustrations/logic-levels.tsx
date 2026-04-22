export function LogicLevels() {
  return (
    <svg
      viewBox="0 0 560 240"
      className="w-full"
      role="img"
      aria-label="5V vs 3.3V logic: connecting a 5V output to a 3.3V input damages the 3.3V board"
    >
      {/* 5V side */}
      <g>
        <rect x="20" y="50" width="220" height="140" rx="10" fill="var(--color-led)" opacity="0.12" stroke="var(--color-led)" strokeWidth="1.5" />
        <text x="130" y="80" fontSize="13" textAnchor="middle" fontWeight="700" fill="var(--color-led)">5V logic</text>
        <text x="130" y="100" fontSize="11" textAnchor="middle" fill="currentColor" opacity="0.7">Uno, Nano, Mega</text>

        <rect x="60" y="120" width="140" height="30" rx="4" fill="currentColor" opacity="0.08" />
        <line x1="60" y1="140" x2="200" y2="140" stroke="var(--color-led)" strokeWidth="2" />
        <line x1="60" y1="160" x2="200" y2="160" stroke="currentColor" strokeWidth="1.5" opacity="0.4" strokeDasharray="3 3" />

        <text x="210" y="142" fontSize="9" fill="var(--color-led)" fontWeight="600">HIGH = 5V</text>
        <text x="210" y="164" fontSize="9" fill="currentColor" opacity="0.55">LOW = 0V</text>
      </g>

      {/* 3.3V side */}
      <g transform="translate(320, 0)">
        <rect x="20" y="50" width="220" height="140" rx="10" fill="var(--color-info)" opacity="0.12" stroke="var(--color-info)" strokeWidth="1.5" />
        <text x="130" y="80" fontSize="13" textAnchor="middle" fontWeight="700" fill="var(--color-info)">3.3V logic</text>
        <text x="130" y="100" fontSize="11" textAnchor="middle" fill="currentColor" opacity="0.7">ESP32, Pi Pico</text>

        <rect x="60" y="120" width="140" height="30" rx="4" fill="currentColor" opacity="0.08" />
        <line x1="60" y1="145" x2="200" y2="145" stroke="var(--color-info)" strokeWidth="2" />
        <line x1="60" y1="160" x2="200" y2="160" stroke="currentColor" strokeWidth="1.5" opacity="0.4" strokeDasharray="3 3" />

        <text x="210" y="148" fontSize="9" fill="var(--color-info)" fontWeight="600">HIGH = 3.3V</text>
        <text x="210" y="164" fontSize="9" fill="currentColor" opacity="0.55">LOW = 0V</text>
      </g>

      {/* Danger wire */}
      <defs>
        <marker id="arrow2" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="6" markerHeight="6" orient="auto">
          <path d="M 0 0 L 10 5 L 0 10 z" fill="var(--color-danger)" />
        </marker>
      </defs>
      <line x1="240" y1="140" x2="340" y2="145" stroke="var(--color-danger)" strokeWidth="2.5" markerEnd="url(#arrow2)">
        <animate attributeName="stroke-dasharray" values="0 180;180 0" dur="1.5s" repeatCount="indefinite" />
      </line>

      <g transform="translate(280, 30)">
        <rect x="-60" y="-18" width="120" height="24" rx="12" fill="var(--color-danger)" opacity="0.15" stroke="var(--color-danger)" strokeWidth="1" />
        <text x="0" y="-2" fontSize="10" textAnchor="middle" fill="var(--color-danger)" fontWeight="700">⚠ DAMAGES THE 3.3V INPUT</text>
      </g>

      <text x="280" y="215" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.6">
        Solution: a logic level converter module between the two boards.
      </text>
    </svg>
  );
}
