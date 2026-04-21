export function BuzzerPinout() {
  return (
    <svg
      viewBox="0 0 320 220"
      className="w-full"
      role="img"
      aria-label="Buzzer pinout — long leg is +, short leg is −. Active buzzer uses digitalWrite; passive uses tone()."
    >
      <title>Buzzer</title>

      {/* Body */}
      <circle cx="160" cy="75" r="55" fill="var(--color-sensor)" opacity="0.15" stroke="var(--color-sensor)" strokeWidth="1.5" />
      <circle cx="160" cy="75" r="8" fill="var(--color-sensor)" opacity="0.6" />
      <text x="160" y="78" fontSize="10" textAnchor="middle" fontWeight="700" fill="currentColor">
        +
      </text>

      {/* Pins */}
      <line x1="140" y1="128" x2="140" y2="190" stroke="currentColor" strokeWidth="3" />
      <line x1="180" y1="128" x2="180" y2="170" stroke="currentColor" strokeWidth="3" />

      {/* Labels */}
      <text x="140" y="210" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">
        long leg (+)
      </text>
      <text x="180" y="190" fontSize="11" textAnchor="middle" fontWeight="600" fill="currentColor">
        short (−)
      </text>

      <text x="160" y="25" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.7">
        Active: digitalWrite · Passive: tone(pin, freq)
      </text>
    </svg>
  );
}
