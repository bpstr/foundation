#!/usr/bin/env bash
set -Eeuo pipefail

if [[ -n "${HEALTHCHECK_URL:-}" ]]; then
  curl -fsS --retry 3 --max-time 15 "$HEALTHCHECK_URL" >/dev/null
  echo "Health check passed: $HEALTHCHECK_URL"
  exit 0
fi

cat >&2 <<'EOF'
scripts/healthcheck.sh has not been configured.
Set HEALTHCHECK_URL or replace this script with application-specific HTTP, process, database and worker checks.
EOF
exit 1
