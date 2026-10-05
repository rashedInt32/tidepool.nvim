-- Tidepool demo: SQL
CREATE TABLE IF NOT EXISTS stations (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL UNIQUE,
    depth       NUMERIC(5, 2) DEFAULT 0.0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE readings (
    id          BIGSERIAL PRIMARY KEY,
    station_id  INTEGER REFERENCES stations (id) ON DELETE CASCADE,
    height      DOUBLE PRECISION NOT NULL,
    taken_at    TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_readings_station_time ON readings (station_id, taken_at DESC);

INSERT INTO stations (name, depth)
VALUES ('North Cove', 12.5), ('South Reef', 8.0)
ON CONFLICT (name) DO NOTHING;

-- TODO: partition readings by month
WITH latest AS (
    SELECT
        r.station_id,
        r.height,
        ROW_NUMBER() OVER (PARTITION BY r.station_id ORDER BY r.taken_at DESC) AS rn
    FROM readings AS r
    WHERE r.taken_at > now() - INTERVAL '1 day'
)
SELECT
    s.name,
    l.height,
    CASE
        WHEN l.height > 4.2 THEN 'high'
        WHEN l.height < -2.0 THEN 'low'
        ELSE 'normal'
    END AS status,
    COALESCE(AVG(l.height) OVER (), 0) AS avg_height
FROM stations AS s
LEFT JOIN latest AS l ON l.station_id = s.id AND l.rn = 1
ORDER BY s.name ASC
LIMIT 50;
