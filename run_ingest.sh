#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
CSV="$ROOT/data/sample_bionel.csv"
DB="$ROOT/healytics.db"
JAR="$ROOT/java-backend/target/healytics-1.0.0-jar-with-dependencies.jar"

java -jar "$JAR" "$CSV" "$DB"
