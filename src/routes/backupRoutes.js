// Ensure the backups directory exists
const express = require("express");
const fs = require("fs");
const path = require("path");
const { backupDatabase, scheduleBackup } = require("../services/backupService"); // Adjust the path as needed
const { Module } = require("module");
const db = require("../config/db"); // Adjust the path as needed
const router = express.Router();

const BACKUP_DIR = path.join(__dirname, "../services/backups");
if (!fs.existsSync(BACKUP_DIR)) {
  fs.mkdirSync(BACKUP_DIR, { recursive: true });
}

// Define backup settings and initialize automatic backups
const backupSettings = {
  schedule: "daily", // This can be 'daily', 'weekly', or 'monthly'
  time: "02:00", // Backup time in HH:mm format
  retention: 30, // Retention period in days
};

//
// Schedule automatic backups
scheduleBackup(backupSettings);

// Route to trigger manual backup
router.post("/backup", (req, res) => {
  backupDatabase("manual", (err, filePath) => {
    if (err) {
      return res
        .status(500)
        .json({ message: "Backup failed", error: err.message });
    }
    res.json({ message: "Backup completed", filePath });
  });
});

// Route to get list of backups
router.get("/backups", (req, res) => {
  console.log(BACKUP_DIR);
  const BACKUP_DIR_MANUAL = path.join(BACKUP_DIR, "/manual");
  console.log(BACKUP_DIR_MANUAL);
  fs.readdir(BACKUP_DIR_MANUAL, (err, files) => {
    if (err) {
      return res
        .status(500)
        .json({ message: "Failed to list backups", error: err.message });
    }
    res.json({ backups: files });
  });
});

// Route to download a specific backup file
router.get("/backups/:fileName", (req, res) => {
  const fileName = req.params.fileName;
  const filePath = path.join(BACKUP_DIR, "/manual", fileName);
  res.download(filePath);
});

// Route to get all audit logs without using promises
router.get("/auditlogs", (req, res) => {
  db.query("SELECT * FROM AuditLogs", (error, results) => {
    if (error) {
      console.error("Error fetching audit logs:", error);
      return res
        .status(500)
        .json({ message: "Failed to fetch audit logs", error: error.message });
    }
    res.json({ auditlogs: results });
  });
});

router.delete("/backups/:filename", (req, res) => {
  const { filename } = req.params;
  const filePath = path.join(BACKUP_DIR, "/manual/", filename);

  fs.unlink(filePath, (err) => {
    if (err) {
      console.error("Error deleting backup:", err);
      return res.status(500).json({ message: "Failed to delete backup" });
    }
    res.json({ message: "Backup deleted successfully" });
  });
});

module.exports = router;
