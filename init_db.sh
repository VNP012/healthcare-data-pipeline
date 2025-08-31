#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
DB="$ROOT/healytics.db"
SCHEMA="$ROOT/java-backend/src/main/resources/schema.sql"

rm -f "$DB"
sqlite3 "$DB" < "$SCHEMA"
echo "✅ Initialized SQLite DB at $DB"
