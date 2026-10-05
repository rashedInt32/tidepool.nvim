//! Tidepool demo: Rust

use std::collections::HashMap;
use std::fmt;

const MAX_HEIGHT: f64 = 4.2;
static STATIONS: [&str; 3] = ["north", "south", "east"];

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Phase {
    Rising,
    Falling,
}

#[derive(Debug, Clone)]
pub struct Reading<'a> {
    pub station: &'a str,
    pub height: f64,
}

#[derive(Debug)]
pub enum TideError {
    OutOfRange(f64),
    Unknown { station: String },
}

impl fmt::Display for TideError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::OutOfRange(h) => write!(f, "height {h:.2} out of range"),
            Self::Unknown { station } => write!(f, "unknown station: {station}"),
        }
    }
}

pub trait Classify {
    fn phase(&self) -> Phase;
}

impl Classify for Reading<'_> {
    fn phase(&self) -> Phase {
        if self.height >= 0.0 { Phase::Rising } else { Phase::Falling }
    }
}

fn validate<'a>(station: &'a str, height: f64) -> Result<Reading<'a>, TideError> {
    if !STATIONS.contains(&station) {
        return Err(TideError::Unknown { station: station.to_owned() });
    }
    match height {
        h if h.abs() > MAX_HEIGHT => Err(TideError::OutOfRange(h)),
        h => Ok(Reading { station, height: h }),
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let raw = vec![("north", 1.5), ("south", -0.75), ("west", 2.0)];
    let mut by_phase: HashMap<Phase, Vec<Reading>> = HashMap::new();

    for (station, height) in raw {
        match validate(station, height) {
            Ok(r) => by_phase.entry(r.phase()).or_default().push(r),
            Err(e) => eprintln!("skip: {e}"), // TODO: collect errors
        }
    }

    let total: usize = by_phase.values().map(Vec::len).sum();
    println!("{total} readings, {:?}", by_phase.keys().collect::<Vec<_>>());
    Ok(())
}
