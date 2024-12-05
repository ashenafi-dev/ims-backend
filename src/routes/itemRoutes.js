const express = require("express");
const { body, validationResult } = require("express-validator");
const db = require("../config/db");

const router = express.Router();

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
        console.error("Error creating item:", err);
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
      console.error("Error fetching items:", err);
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
      console.error("Error fetching item:", err);
      return res.status(500).send("Error fetching item");
    }
    res.status(200).json(results[0]);
  });
};

// Routes
router.post("/createItem", handleCreateItem);
router.get("/getItems", handleGetItems);
router.get("/:item_id", handleGetItemById);

module.exports = router;
