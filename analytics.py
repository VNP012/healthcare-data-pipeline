import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt

# Connect to SQLite database (relative path from this script)
engine = create_engine("sqlite:///../healytics.db")

# Load measurements into Pandas
df = pd.read_sql("SELECT * FROM measurements", engine)

print("=== Sample of ingested healthcare data ===")
print(df.head())

# Analytics: average, min, max values per analyte
summary = df.groupby("analyte")["value"].agg(["count", "mean", "min", "max"])
print("\n=== Analytics Summary (by analyte) ===")
print(summary)

# Simple histogram for most common analyte
if not df.empty:
    top_analyte = df["analyte"].value_counts().index[0]
    subset = df[df["analyte"] == top_analyte]["value"]

    plt.hist(subset, bins=10)
    plt.title(f"Distribution of {top_analyte}")
    plt.xlabel("Value")
    plt.ylabel("Count")
    plt.savefig(f"{top_analyte}_hist.png")
    print(f"\n✅ Histogram saved: {top_analyte}_hist.png")
