"""Tidepool demo: Python."""

from __future__ import annotations

import asyncio
from dataclasses import dataclass, field
from enum import Enum, auto
from typing import Iterator, Protocol

MAX_DEPTH: float = 12.5
STATIONS = ("north", "south", "east")


class Phase(Enum):
    RISING = auto()
    FALLING = auto()


class Source(Protocol):
    async def read(self, station: str) -> float: ...


@dataclass(frozen=True)
class Reading:
    station: str
    height: float
    tags: list[str] = field(default_factory=list)

    @property
    def phase(self) -> Phase:
        return Phase.RISING if self.height > 0 else Phase.FALLING

    def __str__(self) -> str:
        return f"{self.station:<8} {self.height:>6.2f}m {self.phase.name}"


def window(values: list[float], size: int = 3) -> Iterator[float]:
    """Yield a rolling mean over `values`."""
    for i in range(len(values) - size + 1):
        chunk = values[i : i + size]
        yield sum(chunk) / size


async def collect(source: Source) -> list[Reading]:
    # TODO: retry on timeout
    heights = await asyncio.gather(*(source.read(s) for s in STATIONS))
    return [Reading(s, h) for s, h in zip(STATIONS, heights) if h <= MAX_DEPTH]


class FakeSource:
    async def read(self, station: str) -> float:
        await asyncio.sleep(0.01)
        return len(station) * 1.25 - 4


if __name__ == "__main__":
    readings = asyncio.run(collect(FakeSource()))
    for r in sorted(readings, key=lambda r: r.height, reverse=True):
        print(r)
    print(list(window([r.height for r in readings], size=2)))
    assert all(isinstance(r, Reading) for r in readings), "bad reading"
