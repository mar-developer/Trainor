// A complete LED + resistor circuit from 5V to GND, with an animated
// current trail to reinforce direction. Works in both light and dark modes.
export function LedCircuit() {
  return (
    <svg
      viewBox="0 0 520 220"
      className="w-full"
      role="img"
      aria-label="5V to 220 ohm resistor to red LED to GND, with animated current flow"
    >
      {/* Rails */}
      <line x1="40" y1="40" x2="480" y2="40" stroke="var(--color-led)" strokeWidth="2" />
      <line x1="40" y1="180" x2="480" y2="180" stroke="currentColor" strokeWidth="2" opacity="0.4" />
      <text x="20" y="45" fontSize="11" textAnchor="end" fill="var(--color-led)" fontWeight="600">5V</text>
      <text x="20" y="185" fontSize="11" textAnchor="end" fill="currentColor" opacity="0.6">GND</text>

      {/* Wire down */}
      <line x1="140" y1="40" x2="140" y2="80" stroke="currentColor" strokeWidth="2" />

      {/* Resistor zig-zag */}
      <path
        d="M 140 80 L 155 90 L 125 100 L 155 110 L 125 120 L 155 130 L 140 140"
        fill="none"
        stroke="var(--color-resistor)"
        strokeWidth="2.5"
      />
      <text x="200" y="115" fontSize="11" fill="currentColor" opacity="0.75">220 Ω</text>

      {/* Wire into LED */}
      <line x1="140" y1="140" x2="140" y2="155" stroke="currentColor" strokeWidth="2" />

      {/* LED symbol */}
      <g>
        <polygon points="125,155 155,155 140,180" fill="var(--color-led)" opacity="0.8">
          <animate attributeName="opacity" values="0.4;1;0.4" dur="1.4s" repeatCount="indefinite" />
        </polygon>
        <line x1="125" y1="180" x2="155" y2="180" stroke="var(--color-led)" strokeWidth="2" />
        <line x1="160" y1="152" x2="170" y2="142" stroke="var(--color-led)" strokeWidth="1.5" />
        <line x1="170" y1="152" x2="180" y2="142" stroke="var(--color-led)" strokeWidth="1.5" />
        <polygon points="174,142 180,142 177,136" fill="var(--color-led)" />
      </g>

      {/* Flowing current dots along the loop */}
      <g className="[&_circle]:animate-[flow_1.6s_linear_infinite]">
        <circle cx="90" cy="40" r="3" fill="var(--color-led)" />
        <circle cx="130" cy="40" r="3" fill="var(--color-led)" style={{ animationDelay: "-0.2s" }} />
        <circle cx="140" cy="110" r="3" fill="var(--color-led)" style={{ animationDelay: "-0.6s" }} />
        <circle cx="90" cy="180" r="3" fill="currentColor" opacity="0.6" style={{ animationDelay: "-1.0s" }} />
      </g>

      {/* Measured current label */}
      <g transform="translate(270, 80)">
        <rect x="0" y="0" width="180" height="72" rx="8" fill="var(--color-sensor)" opacity="0.12" stroke="var(--color-sensor)" strokeWidth="1" strokeDasharray="4 3" />
        <text x="10" y="20" fontSize="10" fill="var(--color-sensor)" fontWeight="700">MEASURED (in series)</text>
        <text x="10" y="40" fontSize="14" fill="currentColor" fontWeight="600">I ≈ 10–11 mA</text>
        <text x="10" y="58" fontSize="10" fill="currentColor" opacity="0.7">(5.05V − 2.0V) / 220Ω ≈ 13.9 mA</text>
      </g>
    </svg>
  );
}
