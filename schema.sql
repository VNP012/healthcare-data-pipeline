PRAGMA journal_mode = WAL;

CREATE TABLE IF NOT EXISTS patients(
  patient_id TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS measurements(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  record_id TEXT NOT NULL,
  patient_id TEXT NOT NULL,
  ts TEXT NOT NULL,
  analyte TEXT NOT NULL,
  value REAL NOT NULL,
  unit TEXT,
  diagnosis TEXT,
  UNIQUE(record_id) ON CONFLICT IGNORE,
  FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
);

CREATE INDEX IF NOT EXISTS idx_measurements_patient_ts ON measurements(patient_id, ts);
CREATE INDEX IF NOT EXISTS idx_measurements_analyte ON measurements(analyte);
