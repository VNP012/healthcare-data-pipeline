# Healytics: Healthcare Data Pipeline

An end-to-end **data engineering + analytics pipeline** built with **Java, SQL, Python, and Linux scripting**.  
This project simulates ingestion, storage, and analytics of healthcare data, and is designed to demonstrate skills in **distributed systems, databases, automation, and data science**.  

## Project Overview

Healthcare generates massive amounts of structured and unstructured data.  
This project demonstrates how to build a **miniature analytics platform** to handle such data:  

1. **Data Ingestion (Java)**  
   - Parses CSV healthcare datasets.  
   - Inserts records into a structured **SQLite database**.  
   - Uses **JDBC** for database interaction.  
   - Supports duplicate handling and indexing for performance.  

2. **Database Layer (SQL)**  
   - Schema optimized for patient records + measurements.  
   - Indexed for fast lookups by analyte and patient/time.  
   - Ensures data integrity via constraints.  

3. **Analytics (Python)**  
   - Queries the database using **SQLAlchemy + Pandas**.  
   - Generates **BI-style summaries** (count, mean, min, max per analyte).  
   - Saves **visualizations** (e.g., histogram of analyte distributions) with Matplotlib.  

4. **Automation (Bash/Linux)**  
   - Scripts provided for one-command setup and execution.  
   - Fully reproducible pipeline that runs on any Unix-like environment.
     
## Project Structure
healytics/
│
├── data/                       # Sample healthcare datasets (CSV)
│   └── sample_bionel.csv
│
├── java-backend/               # Java ingestion pipeline
│   ├── pom.xml                 # Maven build configuration
│   └── src/main/java/com/oracleprep/healytics/Main.java
│
├── python-analytics/           # Python analytics + visualization
│   ├── analytics.py
│   └── CRP_hist.png            # Example output visualization
│
├── scripts/                    # Bash scripts for automation
│   ├── init_db.sh              # Initialize SQLite schema
│   ├── run_ingest.sh           # Run Java ingestion
│   ├── run_analytics.sh        # Run Python analytics
│   └── run_all.sh              # Full pipeline (all steps)
│
├── README.md                   # Project documentation
└── .gitignore                  # Ignore build + DB files

## Tech Stack

- **Java 17**  
  - Data ingestion & JDBC connectivity  
  - Multithreaded-ready architecture  

- **SQLite (SQL Database)**  
  - Lightweight, embedded relational DB  
  - Indexed schema for performance  

- **Python 3 (Analytics Layer)**  
  - Pandas (data manipulation)  
  - SQLAlchemy (DB connection)  
  - Matplotlib (visualizations)  

- **Linux/Unix Bash Scripts**  
  - Full automation of setup + execution  

---

## Database Schema

**patients**
```sql
patient_id TEXT PRIMARY KEY

#Measurements:
id INTEGER PRIMARY KEY AUTOINCREMENT
record_id TEXT UNIQUE
patient_id TEXT NOT NULL
ts TEXT NOT NULL
analyte TEXT NOT NULL
value REAL NOT NULL
unit TEXT
diagnosis TEXT

Indexes:
CREATE INDEX idx_measurements_patient_ts ON measurements(patient_id, ts);
CREATE INDEX idx_measurements_analyte ON measurements(analyte);

Clone Repo (Run):
git clone https://github.com/VNP012/healthcare-data-pipeline.git
cd healthcare-data-pipeline

Initialize database:
bash scripts/init_db.sh

Ingest sample data (Java):
bash scripts/run_ingest.sh

Expected output:
✅ Ingestion complete!

Run Analytics (Python):
bash scripts/run_analytics.sh

Expected output:
=== Analytics Summary (by analyte) ===
         count  mean   min   max
analyte
CRP          1   4.2   4.2   4.2
Glucose      1  92.0  92.0  92.0
WBC          1   6.8   6.8   6.8

Or Else, Run entire pipeline at once:
bash scripts/run_all.sh

Example output (console Summary):
=== Sample of ingested healthcare data ===
   id record_id patient_id                   ts  analyte  value    unit     diagnosis
0   1         1       P001  2025-02-01T10:00:00      CRP    4.2    mg/L  Inflammation
1   2         2       P001  2025-02-01T10:00:00      WBC    6.8  10^9/L  Inflammation
2   3         3       P002  2025-03-11T12:30:00  Glucose   92.0   mg/dL        Normal

Key Features
	•	Resilient ingestion (duplicate handling via SQL constraints).
	•	Indexed schema → faster queries.
	•	Automation → run with a single script.
	•	Analytics → both tabular summaries and visualizations.
	•	Resume-ready → demonstrates Java, SQL, Python, Linux in one cohesive project.

Future Improvements
	•	Add support for real healthcare datasets (FHIR, HL7).
	•	Extend ingestion to handle JSON + API feeds.
	•	Implement streaming ingestion (Kafka/Flume).
	•	Enhance analytics with machine learning models (anomaly detection, predictions).
	•	Containerize with Docker for deployment.

Author
Vivaan Patel
Undergraduate Computational Nanoengineering major 
GitHub: VNP012
