#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"

echo "=== Initializing database ==="
bash "$ROOT/scripts/init_db.sh"

echo "=== Running ingestion (Java) ==="
bash "$ROOT/scripts/run_ingest.sh"

echo "=== Running analytics (Python) ==="
bash "$ROOT/scripts/run_analytics.sh"

echo "✅ Pipeline complete! Data ingested + analytics generated."
