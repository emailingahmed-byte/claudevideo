#!/bin/bash
set -euo pipefail

# Only run on Claude Code on the web. Local sessions already have a working env.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

echo "[session-start] installing system packages..."
if ! command -v ffmpeg >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  # Best-effort: some containers have broken third-party repos. Don't block the
  # session on this — ffmpeg is only required for a subset of tools.
  if apt-get update -qq -o Dir::Etc::sourcelist="sources.list" \
        -o Dir::Etc::sourceparts="-" 2>/dev/null \
     && apt-get install -y -qq --no-install-recommends ffmpeg 2>/dev/null; then
    echo "  - ffmpeg installed"
  else
    echo "  - ffmpeg install skipped (apt unavailable); some tools may be unavailable"
  fi
fi

echo "[session-start] installing Python dependencies..."
pip install --quiet --disable-pip-version-check -r tools/requirements.txt

echo "[session-start] installing Node dependencies for key projects..."
# Idempotent: skip if node_modules already exists. Avoids npm install mutating
# committed package-lock.json on every session resume.
for dir in playwright examples/hello-world templates/sprint-review; do
  if [ -f "$dir/package.json" ] && [ ! -d "$dir/node_modules" ]; then
    echo "  - $dir (installing)"
    (cd "$dir" && npm install --no-audit --no-fund --silent)
  elif [ -d "$dir/node_modules" ]; then
    echo "  - $dir (cached, skipping)"
  fi
done

echo "[session-start] done"
