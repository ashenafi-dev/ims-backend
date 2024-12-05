const express = require("express");
const cors = require("cors");
const db = require("./config/db");
const app = express();
app.use(cors());
app.use(express.json());

const authRoutes = require("./routes/authRoutes");
const itemRoutes = require("./routes/itemRoutes");
const requestRoutes = require("./routes/requestRoutes");
const transferRoutes = require("./routes/transferRoutes");
const userRoutes = require("./routes/userRoutes");

app.use("/auth", authRoutes);
app.use("/items", itemRoutes);
app.use("/requests", requestRoutes);
app.use("/transfers", transferRoutes);
app.use("/users", userRoutes);

module.exports = app;
