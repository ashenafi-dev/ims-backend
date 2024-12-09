const fs = require("fs");
const { spawn } = require("child_process");
const schedule = require("node-schedule");
const path = require("path");
const db = require("../config/db"); // Adjust the path as needed

const BACKUP_DIR = path.join(__dirname, "../services/backups");

// Ensure backup directories exist
const ensureDirExists = (dir) => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
};

["daily", "weekly", "monthly", "manual"].forEach((category) => {
  ensureDirExists(path.join(BACKUP_DIR, category));
});

// Use mysqldump without specifying the full path
const MYSQLDUMP_PATH = "mysqldump";

// Backup database and save to the appropriate directory
const backupDatabase = (category, callback) => {
  ensureDirExists(path.join(BACKUP_DIR, category)); // Ensure the category directory exists

  const timestamp = new Date().toISOString().replace(/[-:.]/g, "");
  const dumpFileName = `backup_${timestamp}.sql`;
  const filePath = path.join(BACKUP_DIR, category, dumpFileName);

  const command = MYSQLDUMP_PATH;
  const args = [
    "-h",
    db.config.host,
    "-u",
    db.config.user,
    `-p${db.config.password}`,
    db.config.database,
  ];

  const writeStream = fs.createWriteStream(filePath);
  const dump = spawn(command, args);

  // Log stdout and stderr for debugging
  dump.stdout.on("data", (data) => {
    console.log(`mysqldump stdout: ${data}`);
  });

  dump.stderr.on("data", (data) => {
    console.error(`mysqldump stderr: ${data}`);
  });

  dump.stdout
    .pipe(writeStream)
    .on("finish", () => {
      console.log(`${category} backup completed`);
      callback(null, filePath);
    })
    .on("error", (err) => {
      console.error(`${category} backup failed:`, err);
      callback(err);
    });

  dump.on("error", (err) => {
    console.error(`Failed to start mysqldump process:`, err);
    callback(err);
  });
};

// Rotate old backups
const rotateBackups = (category, retentionDays) => {
  const categoryDir = path.join(BACKUP_DIR, category);
  fs.readdir(categoryDir, (err, files) => {
    if (err) {
      console.error(`Failed to read ${category} backups:`, err);
      return;
    }
    files.forEach((file) => {
      const filePath = path.join(categoryDir, file);
      fs.stat(filePath, (err, stats) => {
        if (err) {
          console.error(`Failed to get stats for ${file}:`, err);
          return;
        }
        const age = (Date.now() - stats.mtimeMs) / (1000 * 60 * 60 * 24); // Age in days
        if (age > retentionDays) {
          fs.unlink(filePath, (err) => {
            if (err) {
              console.error(
                `Failed to delete old ${category} backup ${file}:`,
                err
              );
            } else {
              console.log(`Deleted old ${category} backup ${file}`);
            }
          });
        }
      });
    });
  });
};

// Schedule the backup based on settings
const scheduleBackup = (settings) => {
  const { schedule: scheduleType, time, retention } = settings;
  const [hour, minute] = time.split(":");
  let cronExpression;
  let category;

  if (scheduleType === "daily") {
    cronExpression = `${minute} ${hour} * * *`;
    category = "daily";
  } else if (scheduleType === "weekly") {
    cronExpression = `${minute} ${hour} * * 0`; // Every Sunday
    category = "weekly";
  } else if (scheduleType === "monthly") {
    cronExpression = `${minute} ${hour} 1 * *`; // First day of every month
    category = "monthly";
  }

  schedule.gracefulShutdown().then(() => {
    console.log("Cleared previous job schedules.");
    schedule.scheduleJob(cronExpression, () => {
      backupDatabase(category, (err, filePath) => {
        if (err) {
          console.error("Scheduled backup failed:", err);
        } else {
          console.log("Scheduled backup completed:", filePath);
          rotateBackups(category, retention); // Rotate old backups
        }
      });
    });
  });
};

module.exports = { backupDatabase, scheduleBackup, rotateBackups };
