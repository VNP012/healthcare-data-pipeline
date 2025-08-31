package com.oracleprep.healytics;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.util.*;

/**
 * Java-based ingestion pipeline for healthcare data.
 * Reads CSV -> Inserts into SQLite.
 * (Step 2 Skeleton)
 */
public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.out.println("Usage: java -jar healytics.jar <csvPath> <sqliteDbPath>");
            System.exit(1);
        }

        Path csv = Paths.get(args[0]);
        Path db = Paths.get(args[1]);

        try (Connection conn = DriverManager.getConnection("jdbc:sqlite:" + db.toAbsolutePath())) {
            conn.setAutoCommit(false);

            String insertSQL = """
                INSERT OR IGNORE INTO measurements(record_id, patient_id, ts, analyte, value, unit, diagnosis)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """;

            try (PreparedStatement ps = conn.prepareStatement(insertSQL)) {
                List<String> lines = Files.readAllLines(csv);
                for (int i = 1; i < lines.size(); i++) { // skip header
                    String[] t = lines.get(i).split(",");
                    if (t.length < 7) continue;

                    ps.setString(1, t[0].trim()); // record_id
                    ps.setString(2, t[1].trim()); // patient_id
                    ps.setString(3, t[2].trim()); // timestamp
                    ps.setString(4, t[3].trim()); // analyte
                    ps.setDouble(5, Double.parseDouble(t[4].trim())); // value
                    ps.setString(6, t[5].trim()); // unit
                    ps.setString(7, t[6].trim()); // diagnosis
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
            System.out.println("✅ Ingestion complete!");
        }
    }
}
