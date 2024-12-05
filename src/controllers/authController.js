const { v4: uuidv4 } = require("uuid");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const db = require("../config/db");
const User = require("../models/userModel"); // Adjust path as needed
require("dotenv").config();

const login = async (req, res) => {
  const { username, password } = req.body;
  console.log("Login attempt for username:", username);

  User.findByUsername(username, async (err, user) => {
    if (err) {
      console.error("Error finding user by username:", err);
      return res.status(500).send("Error logging in");
    }
    if (!user) {
      console.warn("User not found:", username);
      return res.status(404).send("User not found");
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      console.warn("Invalid credentials for username:", username);
      return res.status(401).send("Invalid credentials");
    }

    console.log(`user password: ${password}`);
    console.log(`stored password: ${user.password}`);
    console.log("Password match successful for username:", username);

    const token = jwt.sign(
      {
        userId: user.user_id,
        username: user.username,
        role: user.role_name,
        department_id: user.department_id,
      },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    console.log("JWT token generated:", token);

    const refreshToken = uuidv4();
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 30); // Set expiration date for 30 days

    console.log("Generated refresh token:", refreshToken);

    // Store refresh token in the database
    try {
      await db
        .promise()
        .query(
          "INSERT INTO RefreshTokens (token, userId, expiresAt) VALUES (?, ?, ?)",
          [refreshToken, user.user_id, expiresAt]
        );
      console.log("Refresh token stored in database");
    } catch (err) {
      console.error("Error storing refresh token:", err);
      return res
        .status(500)
        .send(`Error storing refresh token: ${err.message}`);
    }

    res.json({ token, refreshToken });
  });
};

const refreshToken = async (req, res) => {
  const { refreshToken } = req.body;
  console.log("Refresh token request received:", refreshToken);

  try {
    const [rows] = await db
      .promise()
      .query("SELECT * FROM RefreshTokens WHERE token = ?", [refreshToken]);
    const tokenEntry = rows[0];

    if (!tokenEntry) {
      console.warn("Refresh token not found:", refreshToken);
      return res.status(403).send("Refresh token invalid or expired");
    }

    if (new Date() > new Date(tokenEntry.expiresAt)) {
      console.warn("Refresh token expired:", refreshToken);
      return res.status(403).send("Refresh token invalid or expired");
    }

    console.log("Refresh token valid:", refreshToken);

    const userId = tokenEntry.userId;
    const [userRows] = await db
      .promise()
      .query("SELECT * FROM Users WHERE user_id = ?", [userId]);
    const user = userRows[0];

    if (!user) {
      console.warn("User not found for refresh token:", refreshToken);
      return res.status(403).send("User not found");
    }

    console.log("User found for refresh token:", user);

    const newToken = jwt.sign(
      { id: user.user_id, username: user.username, role: user.role_name },
      process.env.JWT_SECRET,
      { expiresIn: "30d" }
    );

    console.log("New JWT token generated:", newToken);

    res.json({ token: newToken });
  } catch (err) {
    console.error("Error refreshing token:", err);
    res.status(500).send(`Error refreshing token: ${err.message}`);
  }
};

module.exports = { login, refreshToken };
