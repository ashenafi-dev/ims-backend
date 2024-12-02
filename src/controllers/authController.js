const { v4: uuidv4 } = require("uuid");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const db = require("../config/db");
const User = require("../models/userModel"); // Adjust path as needed
require("dotenv").config();

const login = async (req, res) => {
  const { username, password } = req.body;

  User.findByUsername(username, async (err, user) => {
    if (err) return res.status(500).send("Error logging in");
    if (!user) return res.status(404).send("User not found");

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(401).send("Invalid credentials");

    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "5s" }
    );

    const refreshToken = uuidv4();
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 30); // Set expiration date for 30 days

    // Store refresh token in the database
    try {
      await db
        .promise()
        .query(
          "INSERT INTO RefreshTokens (token, userId, expiresAt) VALUES (?, ?, ?)",
          [refreshToken, user.id, expiresAt]
        );
    } catch (err) {
      console.error("Error storing refresh token:", err);
      return res.status(500).send("Error storing refresh token");
    }

    res.json({ token, refreshToken });
  });
};

const refreshToken = async (req, res) => {
  const { refreshToken } = req.body;

  try {
    const [rows] = await db
      .promise()
      .query("SELECT * FROM RefreshTokens WHERE token = ?", [refreshToken]);
    const tokenEntry = rows[0];

    if (!tokenEntry || new Date() > new Date(tokenEntry.expiresAt)) {
      return res.status(403).send("Refresh token invalid or expired");
    }

    const userId = tokenEntry.userId;
    const newToken = jwt.sign(
      { id: userId, role: "user" },
      process.env.JWT_SECRET,
      { expiresIn: "5s" }
    );

    res.json({ token: newToken });
  } catch (err) {
    console.error("Error refreshing token:", err);
    res.status(500).send("Error refreshing token");
  }
};

module.exports = { login, refreshToken };
