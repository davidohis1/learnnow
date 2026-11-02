#!/usr/bin/env sh
# Development-only supervised loop. Use cron/your service manager in production.
set -eu
cd "$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
trap 'exit 0' INT TERM
while :; do
  php bin/scheduled-jobs.php || printf '%s\n' 'Worker failed; inspect storage/logs/jobs.log.' >&2
  sleep 300 &
  wait "$!" || exit 0
done
