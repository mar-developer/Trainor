export function DebounceIllustration() {
  return (
    <svg
      viewBox="0 0 560 200"
      className="w-full"
      role="img"
      aria-label="Button press bouncing: raw signal flickers, software debouncing yields a clean edge"
    >
      {/* Raw */}
      <g>
        <text x="10" y="30" fontSize="10" fill="currentColor" opacity="0.7">RAW signal</text>
        <line x1="10" y1="70" x2="550" y2="70" stroke="currentColor" strokeWidth="0.5" opacity="0.2" />
        <line x1="10" y1="50" x2="140" y2="50" stroke="var(--color-switch)" strokeWidth="2" />
        {/* Bounces */}
        <line x1="140" y1="50" x2="150" y2="40" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="150" y1="40" x2="160" y2="52" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="160" y1="52" x2="170" y2="40" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="170" y1="40" x2="180" y2="52" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="180" y1="52" x2="195" y2="40" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="195" y1="40" x2="210" y2="40" stroke="var(--color-switch)" strokeWidth="2" />
        <line x1="210" y1="40" x2="550" y2="40" stroke="var(--color-switch)" strokeWidth="2" />

        <text x="150" y="18" fontSize="10" fill="var(--color-switch)" fontWeight="600">bounces (5–20 ms)</text>

        <text x="550" y="65" fontSize="8" fill="currentColor" textAnchor="end" opacity="0.5">time →</text>
      </g>

      {/* Debounced */}
      <g transform="translate(0, 110)">
        <text x="10" y="30" fontSize="10" fill="currentColor" opacity="0.7">DEBOUNCED signal</text>
        <line x1="10" y1="70" x2="550" y2="70" stroke="currentColor" strokeWidth="0.5" opacity="0.2" />
        <line x1="10" y1="50" x2="210" y2="50" stroke="var(--color-sensor)" strokeWidth="2.5" />
        <line x1="210" y1="50" x2="210" y2="40" stroke="var(--color-sensor)" strokeWidth="2.5" />
        <line x1="210" y1="40" x2="550" y2="40" stroke="var(--color-sensor)" strokeWidth="2.5" />
        <text x="220" y="32" fontSize="10" fill="var(--color-sensor)" fontWeight="600">clean single edge after ~50 ms filter</text>
      </g>
    </svg>
  );
}
