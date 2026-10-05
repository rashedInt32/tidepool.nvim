// Tidepool demo: JavaScript
"use strict";

const { readFile } = require("node:fs/promises");

const UNITS = Object.freeze({ METERS: "m", FEET: "ft" });
const pattern = /^(?<station>[a-z-]+):(?<height>\d+(\.\d+)?)$/i;

/**
 * Parse a "station:height" line.
 * @param {string} line
 * @returns {{ station: string, height: number } | null}
 */
function parseLine(line) {
  const match = pattern.exec(line.trim());
  if (!match) return null;
  const { station, height } = match.groups;
  return { station, height: parseFloat(height) };
}

class TideLog {
  #entries = [];
  static instances = 0;

  constructor(unit = UNITS.METERS) {
    this.unit = unit;
    TideLog.instances++;
  }

  add(entry) {
    this.#entries.push({ ...entry, at: new Date() });
    return this;
  }

  *[Symbol.iterator]() {
    yield* this.#entries;
  }

  get max() {
    return Math.max(...this.#entries.map((e) => e.height), -Infinity);
  }
}

async function main(path) {
  try {
    const text = await readFile(path, "utf8");
    const log = new TideLog();
    text.split("\n").map(parseLine).filter(Boolean).forEach((e) => log.add(e));
    console.log(`max: ${log.max}${log.unit}`, [...log].length);
  } catch (err) {
    console.error(err?.message ?? err); // FIXME: exit code
  } finally {
    process.exitCode ??= 0;
  }
}

main(process.argv[2] ?? "tides.txt");
