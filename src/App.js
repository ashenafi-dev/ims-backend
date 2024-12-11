const express = require("express");
const cors = require("cors");
const authRoutes = require("./routes/authRoutes");
const itemRoutes = require("./routes/itemRoutes");
const requestRoutes = require("./routes/requestRoutes");
const transferRoutes = require("./routes/transferRoutes");
const userRoutes = require("./routes/userRoutes");
const backupRoutes = require("./routes/backupRoutes");

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON request bodies

// Define routes
app.use("/auth", authRoutes);
app.use("/items", itemRoutes);
app.use("/requests", requestRoutes);
app.use("/transfers", transferRoutes);
app.use("/api", backupRoutes);
app.use("/users", userRoutes);

module.exports = app;
