// Tidepool demo: Java
package dev.tidepool.demo;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public final class TideReport {

    private static final double MAX_HEIGHT = 4.2;

    public enum Phase { RISING, FALLING }

    public record Reading(String station, double height) {
        public Reading {
            if (Double.isNaN(height)) {
                throw new IllegalArgumentException("height is NaN for " + station);
            }
        }

        public Phase phase() {
            return height >= 0 ? Phase.RISING : Phase.FALLING;
        }
    }

    @FunctionalInterface
    interface Filter<T> {
        boolean accept(T value);
    }

    private final List<Reading> readings;

    public TideReport(List<Reading> readings) {
        this.readings = List.copyOf(readings);
    }

    public Map<Phase, List<Reading>> byPhase(Filter<Reading> filter) {
        return readings.stream()
                .filter(filter::accept)
                .collect(Collectors.groupingBy(Reading::phase));
    }

    public Optional<Reading> highest() {
        return readings.stream().max((a, b) -> Double.compare(a.height(), b.height()));
    }

    @Override
    public String toString() {
        return """
            TideReport {
              count = %d
            }
            """.formatted(readings.size());
    }

    public static void main(String[] args) {
        var report = new TideReport(List.of(
                new Reading("north", 1.5),
                new Reading("south", -0.75)));

        var grouped = report.byPhase(r -> Math.abs(r.height()) <= MAX_HEIGHT);
        grouped.forEach((phase, list) -> System.out.printf("%s: %d%n", phase, list.size()));
        report.highest().ifPresent(System.out::println); // TODO: format units
    }
}
