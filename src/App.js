const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");
const { backupDatabase, scheduleBackup } = require("./services/backupService"); // Adjust the path as needed
const authRoutes = require("./routes/authRoutes");
const itemRoutes = require("./routes/itemRoutes");
const requestRoutes = require("./routes/requestRoutes");
const transferRoutes = require("./routes/transferRoutes");
const userRoutes = require("./routes/userRoutes");
const { Module } = require("module");

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON request bodies

// Define routes
app.use("/auth", authRoutes);
app.use("/items", itemRoutes);
app.use("/requests", requestRoutes);
app.use("/transfers", transferRoutes);
app.use("/users", userRoutes);

// Ensure the backups directory exists
const BACKUP_DIR = path.join(__dirname, "services/backups");
if (!fs.existsSync(BACKUP_DIR)) {
  fs.mkdirSync(BACKUP_DIR, { recursive: true });
}

// Define backup settings and initialize automatic backups
const backupSettings = {
  schedule: "daily", // This can be 'daily', 'weekly', or 'monthly'
  time: "02:00", // Backup time in HH:mm format
  retention: 30, // Retention period in days
};

// Schedule automatic backups
scheduleBackup(backupSettings);

// Route to trigger manual backup
app.post("/api/backup", (req, res) => {
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
app.get("/api/backups", (req, res) => {
  console.log(BACKUP_DIR);
  const BACKUP_DIR_MANUAL = path.join(BACKUP_DIR, "/manual");
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
app.get("/api/backups/:fileName", (req, res) => {
  const fileName = req.params.fileName;
  const filePath = path.join(BACKUP_DIR, "/manual", fileName);
  res.download(filePath);
});

module.exports = app;
