const express = require("express");
const cors = require("cors");
const db = require("./config/db");
const authRoutes = require("./routes/authRoutes");
const app = express();
app.use(cors()); // Enable CORS for all routes
app.use(express.json()); // Middleware to parse JSON bodies

// Use authentication routes
app.use("/auth", authRoutes);

// CRUD on Item Table
const handleCreateItem = (req, res) => {
  const { name, description, price, quantity } = req.body;
  const query =
    "INSERT INTO products (name, description, price, quantity) VALUES (?, ?, ?, ?)";
  db.query(query, [name, description, price, quantity], (err, results) => {
    if (err) {
      return res.status(500).send("Error creating product");
    }
    res.status(201).send(`Product created with ID: ${results.insertId}`);
  });
};

// const handleRetriveItem = () => {
//   return 0;
// };

// const handleUpdateItem = () => {
//   return 0;
// };

// const handleDeleteItem = () => {
//   return 0;
// };

// create Item
app.post("/createItem", handleCreateItem);

// retrive Item
// app.get("/retriveItem", handleRetriveItem);

// // update item
// app.put("/updateItem", handleUpdateItem);

// // delete item
// app.delete("/deleteItem", handleDeleteItem);

module.exports = app;
