// Tidepool demo: TypeScript
import { Context, Data, Effect, Layer } from "effect";
import type { Readable } from "node:stream";

// NOTE: type slots below use @type.reference from queries/typescript

export enum Phase {
  Rising = "rising",
  Falling = "falling",
  Slack = "slack",
}

export interface Reading {
  readonly id: number;
  station: string;
  height: number;
  phase: Phase;
  tags?: string[];
}

type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E };

class StationNotFound extends Data.TaggedError("StationNotFound")<{
  station: string;
}> {}

class TideApi extends Context.Tag("TideApi")<
  TideApi,
  { readonly fetch: (station: string) => Effect.Effect<Reading, StationNotFound> }
>() {}

const THRESHOLD = 2.75 as const;

export abstract class Sensor<T extends Reading> {
  protected readings: Array<T> = [];
  constructor(private readonly name: string) {}

  abstract sample(): Promise<T>;

  get latest(): T | undefined {
    return this.readings.at(-1);
  }
}

export function classify(reading: Reading): Result<Phase> {
  if (Number.isNaN(reading.height)) {
    return { ok: false, error: new TypeError(`bad height for ${reading.station}`) };
  }
  return { ok: true, value: reading.height > THRESHOLD ? Phase.Rising : Phase.Falling };
}

// Effect.gen opens a program scope, highlighted by the EffectGen group
export const program = Effect.gen(function* () {
  const api = yield* TideApi;
  const reading = yield* api.fetch("north-cove");
  yield* Effect.log(`height=${reading.height.toFixed(2)}`);
  return classify(reading);
});

export const TideApiLive = Layer.succeed(TideApi, {
  fetch: (station) =>
    station === "north-cove"
      ? Effect.succeed({ id: 1, station, height: 3.1, phase: Phase.Slack })
      : Effect.fail(new StationNotFound({ station })),
});

export async function drain(stream: Readable): Promise<string> {
  const chunks: Buffer[] = [];
  for await (const chunk of stream) chunks.push(Buffer.from(chunk));
  return Buffer.concat(chunks).toString("utf8"); // TODO: stream decode
}
