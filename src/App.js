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
// const handleCreateItem = (req, res) => {
//   const { name, description, price, quantity } = req.body;
//   const query =
//     "INSERT INTO products (name, description, price, quantity) VALUES (?, ?, ?, ?)";
//   db.query(query, [name, description, price, quantity], (err, results) => {
//     if (err) {
//       return res.status(500).send("Error creating product");
//     }
//     res.status(201).send(`Product created with ID: ${results.insertId}`);
//   });
// };

const handleCreateItem = (req, res) => {
  const {
    name,
    description,
    category,
    price,
    stock_level,
    eligibility_tag,
    expiration_date,
    media_url,
    measurement_unit,
    manufacturer,
    model_number,
  } = req.body;
  const query =
    "INSERT INTO Items (name, description, category, price, stock_level, eligibility_tag, expiration_date, media_url, measurement_unit, manufacturer, model_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
  db.query(
    query,
    [
      name,
      description,
      category,
      price,
      stock_level,
      eligibility_tag,
      expiration_date,
      media_url,
      measurement_unit,
      manufacturer,
      model_number,
    ],
    (err, results) => {
      if (err) {
        return res.status(500).send("Error creating item");
      }
      res.status(201).send(`Item created with ID: ${results.insertId}`);
    }
  );
};

const handleGetItems = (req, res) => {
  const query = "SELECT * FROM Items WHERE is_deleted = FALSE";
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).send("Error fetching items");
    }
    res.status(200).json(results);
  });
};

const handleGetItemById = (req, res) => {
  const { item_id } = req.params;
  const query = "SELECT * FROM Items WHERE item_id = ? AND is_deleted = FALSE";
  db.query(query, [item_id], (err, results) => {
    if (err) {
      return res.status(500).send("Error fetching item");
    }
    res.status(200).json(results[0]);
  });
};

// const handleUpdateItem = () => {
//   return 0;
// };

// const handleDeleteItem = () => {
//   return 0;
// };

// create Item
app.post("/createItem", handleCreateItem);

// retrive Item
app.get("/getItems", handleGetItems);

// // update item
// app.put("/updateItem", handleUpdateItem);

// // delete item
// app.delete("/deleteItem", handleDeleteItem);

module.exports = app;
