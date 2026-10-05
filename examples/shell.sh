#!/usr/bin/env bash
# Tidepool demo: Bash
set -euo pipefail

readonly MAX_HEIGHT=42
STATIONS=("north" "south" "east")
declare -A heights=()

log() {
  local level="$1"; shift
  printf '[%s] %s: %s\n' "$(date +%H:%M:%S)" "${level^^}" "$*" >&2
}

read_station() {
  local station="$1"
  # TODO: fetch from the real API
  echo $(( ${#station} * 7 ))
}

cleanup() {
  log info "cleaning up ${TMPDIR:-/tmp}/tides.$$"
  rm -f "${TMPDIR:-/tmp}/tides.$$"
}
trap cleanup EXIT

for station in "${STATIONS[@]}"; do
  h=$(read_station "$station")
  if (( h > MAX_HEIGHT )); then
    log warn "$station out of range ($h)"
    continue
  fi
  heights["$station"]=$h
done

case "${1:-}" in
  -j|--json)
    printf '{'
    for k in "${!heights[@]}"; do printf '"%s":%d,' "$k" "${heights[$k]}"; done
    printf '}\n'
    ;;
  *)
    for k in "${!heights[@]}"; do echo "$k -> ${heights[$k]}"; done | sort
    ;;
esac

[[ ${#heights[@]} -gt 0 ]] && log info "done" || exit 1
