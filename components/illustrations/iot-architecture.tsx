// Classic IoT topology: devices publish → broker → subscribers (dashboard / phone).
export function IotArchitecture() {
  return (
    <svg
      viewBox="0 0 720 280"
      className="w-full"
      role="img"
      aria-label="ESP32 devices publish to an MQTT broker; the broker fans messages out to dashboards and phones"
    >
      <defs>
        <marker id="iot-arrow" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="8" markerHeight="8" orient="auto">
          <path d="M 0 0 L 10 5 L 0 10 z" fill="currentColor" />
        </marker>
      </defs>

      {/* Publishers (left) */}
      <g>
        <text x="80" y="28" fontSize="11" textAnchor="middle" fontWeight="700" fill="var(--color-sensor)">PUBLISHERS</text>
        {[
          { y: 50, label: "ESP32 · DHT11", topic: "home/livingroom/temp" },
          { y: 120, label: "ESP32 · door", topic: "home/door/state" },
          { y: 190, label: "ESP32 · lights", topic: "home/lights/+" },
        ].map((p) => (
          <g key={p.label}>
            <rect x="20" y={p.y} width="130" height="48" rx="8" fill="var(--color-sensor)" opacity="0.14" stroke="var(--color-sensor)" strokeWidth="1.5" />
            <text x="85" y={p.y + 20} fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">{p.label}</text>
            <text x="85" y={p.y + 36} fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7" fontFamily="monospace">{p.topic}</text>
          </g>
        ))}
      </g>

      {/* Broker (center) */}
      <g>
        <text x="360" y="28" fontSize="11" textAnchor="middle" fontWeight="700" fill="var(--color-info)">MQTT BROKER</text>
        <rect x="280" y="60" width="160" height="150" rx="12" fill="var(--color-info)" opacity="0.12" stroke="var(--color-info)" strokeWidth="1.5" />
        <text x="360" y="100" fontSize="12" textAnchor="middle" fontWeight="700" fill="currentColor">Mosquitto</text>
        <text x="360" y="118" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.65">(or HiveMQ, EMQX…)</text>

        {/* Ring of topics */}
        <circle cx="360" cy="160" r="30" fill="none" stroke="var(--color-info)" strokeWidth="1" strokeDasharray="3 3" />
        <text x="360" y="156" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">routes by topic</text>
        <text x="360" y="170" fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7">1883 / 8883</text>
      </g>

      {/* Subscribers (right) */}
      <g>
        <text x="620" y="28" fontSize="11" textAnchor="middle" fontWeight="700" fill="var(--color-led)">SUBSCRIBERS</text>
        {[
          { y: 50, label: "Web dashboard", topic: "home/#" },
          { y: 120, label: "Phone app", topic: "home/door/#" },
          { y: 190, label: "Another ESP32", topic: "home/lights/cmd" },
        ].map((s) => (
          <g key={s.label}>
            <rect x="555" y={s.y} width="130" height="48" rx="8" fill="var(--color-led)" opacity="0.14" stroke="var(--color-led)" strokeWidth="1.5" />
            <text x="620" y={s.y + 20} fontSize="11" textAnchor="middle" fill="currentColor" fontWeight="600">{s.label}</text>
            <text x="620" y={s.y + 36} fontSize="9" textAnchor="middle" fill="currentColor" opacity="0.7" fontFamily="monospace">{s.topic}</text>
          </g>
        ))}
      </g>

      {/* Pub arrows (left → broker) */}
      {[74, 144, 214].map((y) => (
        <line key={`p-${y}`} x1="155" y1={y} x2="275" y2="140" stroke="currentColor" strokeWidth="1.5" markerEnd="url(#iot-arrow)" />
      ))}

      {/* Sub arrows (broker → right) */}
      {[74, 144, 214].map((y) => (
        <line key={`s-${y}`} x1="445" y1="140" x2="550" y2={y} stroke="currentColor" strokeWidth="1.5" markerEnd="url(#iot-arrow)" />
      ))}

      {/* Publish label */}
      <text x="215" y="250" fontSize="10" textAnchor="middle" fill="var(--color-sensor)" fontWeight="600">
        publish(topic, payload)
      </text>
      <text x="500" y="250" fontSize="10" textAnchor="middle" fill="var(--color-led)" fontWeight="600">
        subscribe(topic_with_wildcards)
      </text>

      <text x="360" y="270" fontSize="10" textAnchor="middle" fill="currentColor" opacity="0.55">
        The broker holds no state — it just fans messages out by topic pattern.
      </text>
    </svg>
  );
}
