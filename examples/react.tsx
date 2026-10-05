// Tidepool demo: TSX / React
import { useEffect, useMemo, useState, type ReactNode } from "react";

type Props = {
  title: string;
  stations: Station[];
  children?: ReactNode;
  onSelect?: (station: Station) => void;
};

interface Station {
  id: string;
  name: string;
  depth: number;
}

// FIXME: make the limit a prop
const DEFAULT_LIMIT = 10;

export function TideBoard({ title, stations, children, onSelect }: Props) {
  const [query, setQuery] = useState<string>("");
  const [loading, setLoading] = useState(false);

  const visible = useMemo<Station[]>(
    () =>
      stations
        .filter((s) => s.name.toLowerCase().includes(query.toLowerCase()))
        .slice(0, DEFAULT_LIMIT),
    [stations, query],
  );

  useEffect(() => {
    setLoading(true);
    const timer = setTimeout(() => setLoading(false), 300);
    return () => clearTimeout(timer);
  }, [query]);

  return (
    <section className="tide-board" aria-busy={loading}>
      <h2>{title}</h2>
      <input
        type="search"
        value={query}
        placeholder="Filter stations…"
        onChange={(e) => setQuery(e.target.value)}
      />
      {visible.length === 0 ? (
        <p className="empty">No stations match "{query}"</p>
      ) : (
        <ul>
          {visible.map((station) => (
            <li key={station.id} onClick={() => onSelect?.(station)}>
              <strong>{station.name}</strong> &mdash; {station.depth.toFixed(1)}m
            </li>
          ))}
        </ul>
      )}
      {children}
    </section>
  );
}

export default TideBoard;
