#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="${1:-.}"
cd "$ROOT"

required_files=(
  "AGENTS.md"
  "foundation.yml"
  ".foundation/AGENTS.md"
  ".foundation/VERSION"
  ".specs/README.md"
  ".specs/architecture/overview.md"
  ".specs/decisions/README.md"
  ".specs/features/README.md"
  ".specs/operations/deployment.md"
  "scripts/install.sh"
  "scripts/update.sh"
  "scripts/verify.sh"
  "scripts/healthcheck.sh"
  "scripts/rollback.sh"
)

failed=0
for file_path in "${required_files[@]}"; do
  if [[ ! -f "$file_path" ]]; then
    echo "Missing required file: $file_path" >&2
    failed=1
  fi
done

if [[ -f AGENTS.md ]] && ! grep -q '<!-- foundation:managed:start -->' AGENTS.md; then
  echo "AGENTS.md does not contain the Foundation managed block." >&2
  failed=1
fi

for script_path in scripts/*.sh; do
  [[ -e "$script_path" ]] || continue
  if [[ ! -x "$script_path" ]]; then
    echo "Script is not executable: $script_path" >&2
    failed=1
  fi
  if ! bash -n "$script_path"; then
    failed=1
  fi
done

if [[ "$failed" -ne 0 ]]; then
  echo "Foundation check failed." >&2
  exit 1
fi

echo "Foundation structure is valid."
