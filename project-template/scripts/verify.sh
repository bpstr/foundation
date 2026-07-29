#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

required_files=(
  "AGENTS.md"
  ".foundation/AGENTS.md"
  ".specs/README.md"
  ".specs/architecture/overview.md"
  "foundation.yml"
)

for file_path in "${required_files[@]}"; do
  [[ -f "$file_path" ]] || { echo "Missing required file: $file_path" >&2; exit 1; }
done

bash -n scripts/*.sh

if [[ -f package.json ]] && command -v npm >/dev/null 2>&1; then
  npm run lint --if-present
  npm run typecheck --if-present
  npm run test --if-present
fi

if [[ -f composer.json ]] && command -v composer >/dev/null 2>&1; then
  composer validate --no-interaction --no-check-publish
fi

echo "Project verification completed. Extend scripts/verify.sh with framework-specific checks."
