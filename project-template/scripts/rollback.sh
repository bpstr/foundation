#!/usr/bin/env bash
set -Eeuo pipefail

cat >&2 <<'EOF'
scripts/rollback.sh is a project contract and has not been configured yet.
Implement release rollback explicitly and document whether database changes are reversible. Never report success for an unsupported rollback.
EOF
exit 1
