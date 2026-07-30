#!/usr/bin/env bash
set -Eeuo pipefail

FOUNDATION_REPO="${FOUNDATION_REPO:-bpstr/foundation}"
FOUNDATION_REF="${FOUNDATION_REF:-main}"
TARGET_DIR="${1:-.}"

for command_name in curl tar mktemp git; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Foundation requires '$command_name'." >&2
    exit 1
  fi
done

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"
TARGET_DIR="$(pwd -P)"

if [[ ! -e .git ]]; then
  git init >/dev/null
  echo "Initialized Git repository."
fi

TEMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

ARCHIVE_URL="https://codeload.github.com/${FOUNDATION_REPO}/tar.gz/${FOUNDATION_REF}"
echo "Downloading Foundation ${FOUNDATION_REF}..."
curl -fsSL --retry 2 "$ARCHIVE_URL" | tar -xz -C "$TEMP_DIR" --strip-components=1

TEMPLATE_DIR="$TEMP_DIR/project-template"
if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "Foundation archive does not contain project-template/." >&2
  exit 1
fi

installed=0
preserved=0

copy_managed_file() {
  local relative_path="$1"
  local source_path="$TEMPLATE_DIR/$relative_path"
  local target_path="$TARGET_DIR/$relative_path"

  mkdir -p "$(dirname "$target_path")"
  cp -p "$source_path" "$target_path"
  echo "  refreshed $relative_path"
  installed=$((installed + 1))
}

for managed_path in \
  ".foundation/AGENTS.md" \
  ".foundation/README.md" \
  ".foundation/VERSION" \
  ".foundation/profiles/saas.md"; do
  copy_managed_file "$managed_path"
done

while IFS= read -r -d '' source_path; do
  relative_path="${source_path#"$TEMPLATE_DIR/"}"

  case "$relative_path" in
    .foundation/*)
      continue
      ;;
  esac

  target_path="$TARGET_DIR/$relative_path"
  if [[ -e "$target_path" ]]; then
    echo "  kept      $relative_path"
    preserved=$((preserved + 1))
    continue
  fi

  mkdir -p "$(dirname "$target_path")"
  cp -p "$source_path" "$target_path"
  echo "  installed $relative_path"
  installed=$((installed + 1))
done < <(find "$TEMPLATE_DIR" -type f -print0)

if [[ ! -f AGENTS.md ]]; then
  cp -p "$TEMPLATE_DIR/AGENTS.md" AGENTS.md
elif ! grep -q '<!-- foundation:managed:start -->' AGENTS.md; then
  cat >> AGENTS.md <<'EOF'

<!-- foundation:managed:start -->
## Shared Foundation instructions

Before planning or changing this project, read `.foundation/AGENTS.md` and `.specs/README.md`. Keep specifications synchronized with behavioral and architectural changes, and run `./scripts/verify.sh` before considering work complete.
<!-- foundation:managed:end -->
EOF
  echo "  extended  AGENTS.md"
fi

cat > .foundation/source <<EOF
repository: ${FOUNDATION_REPO}
ref: ${FOUNDATION_REF}
installed_at: $(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF

printf '\nFoundation applied to %s\n' "$TARGET_DIR"
printf 'Installed or refreshed: %s; preserved existing files: %s.\n' "$installed" "$preserved"
printf 'Review with: git status && git diff\n'