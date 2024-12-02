const express = require("express");
const cors = require("cors");
const db = require("./config/db");
const authRoutes = require("./routes/authRoutes");
const app = express();
app.use(cors()); // Enable CORS for all routes
app.use(express.json()); // Middleware to parse JSON bodies

// Test route to check database connection
app.get("/test-db", (req, res) => {
  db.query("SELECT 1 + 1 AS solution", (err, results) => {
    if (err) {
      return res.status(500).send("Error executing query");
    }
    res.send(`Database connection successful: ${results[0].solution}`);
  });
});

// Create a new product
app.post("/products", (req, res) => {
  const { name, description, price, quantity } = req.body;
  const query =
    "INSERT INTO products (name, description, price, quantity) VALUES (?, ?, ?, ?)";
  db.query(query, [name, description, price, quantity], (err, results) => {
    if (err) {
      return res.status(500).send("Error creating product");
    }
    res.status(201).send(`Product created with ID: ${results.insertId}`);
  });
});

// Handle GET request for /products
app.get("/products", (req, res) => {
  res.send("This is the products route.");
});

// Use authentication routes
app.use("/auth", authRoutes);

module.exports = app;
