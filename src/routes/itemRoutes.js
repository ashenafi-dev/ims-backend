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
  //
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

const handleGetItemsUser = (req, res) => {
  const query = "SELECT * FROM Items WHERE category = 'Durable'";

  db.query(query, (err, results) => {
    if (err) {
      console.error("Error fetching items:", err);
      return res.status(500).send("Error fetching items");
    }
    res.status(200).json(results);
  });
};

const handleGetItemsFaculty = (req, res) => {
  const query = "SELECT * FROM Items WHERE category = 'Non-durable'";

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

// GET received items by user ID
router.get("/useritems/:user_id", (req, res) => {
  const { user_id } = req.params;
  const query = `
    SELECT 
      UserItems.user_item_id,
      UserItems.quantity,
      UserItems.acquired_date,
      Items.name AS item_name,
      Items.description AS item_description,
      Items.category AS item_category,
      Items.price AS item_price,
      Items.measurment_unit AS measurment_unit,
      Items.manufacturer AS manufacturer,
      Items.model_number AS model_number
    FROM UserItems
    JOIN Items ON UserItems.item_id = Items.item_id
    WHERE UserItems.user_id = ?;
  `;

  db.query(query, [user_id], (err, results) => {
    if (err) {
      console.error("Error fetching received items:", err);
      return res.status(500).send("Error fetching received items");
    }
    res.status(200).json(results);
  });
});

// Routes
router.post("/createItem", handleCreateItem);
router.get("/getItemsUser", handleGetItemsUser);
router.get("/getItemsFaculty", handleGetItemsFaculty);
router.get("/:item_id", handleGetItemById);

router.get("/items/getItemsUser", (req, res) => {
  db.query("SELECT * FROM Items", (err, results) => {
    if (err) {
      console.error("Error fetching items:", err);
      return res.status(500).json({ message: "Internal server error" });
    }
    res.json(results);
  });
});

router.get("/items/:id", (req, res) => {
  const itemId = req.params.id;
  db.query("SELECT * FROM Items WHERE item_id = ?", [itemId], (err, result) => {
    if (err) {
      console.error("Error fetching item:", err);
      return res.status(500).json({ message: "Internal server error" });
    }
    if (result.length === 0) {
      return res.status(404).json({ message: "Item not found" });
    }
    res.json(result[0]);
  });
});

router.post("/items", (req, res) => {
  const { name, description, category, price, stock_level, expiration_date } =
    req.body;
  db.query(
    "INSERT INTO Items (name, description, category, price, stock_level, expiration_date) VALUES (?, ?, ?, ?, ?, ?)",
    [name, description, category, price, stock_level, expiration_date],
    (err, result) => {
      if (err) {
        console.error("Error adding item:", err);
        return res.status(500).json({ message: "Internal server error" });
      }
      res.status(201).json({ message: "Item added successfully" });
    }
  );
});

router.put("/items/:id", (req, res) => {
  const itemId = req.params.id;
  const { name, description, category, price, stock_level, expiration_date } =
    req.body;
  db.query(
    "UPDATE Items SET name = ?, description = ?, category = ?, price = ?, stock_level = ? WHERE item_id = ?",
    [name, description, category, price, stock_level, itemId],
    (err, result) => {
      if (err) {
        console.error("Error updating item:", err);
        return res.status(500).json({ message: "Internal server error" });
      }
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Item not found" });
      }
      res.json({ message: "Item updated successfully" });
    }
  );
});

router.delete("/items/:id", (req, res) => {
  const itemId = req.params.id;
  db.query("DELETE FROM Items WHERE item_id = ?", [itemId], (err, result) => {
    if (err) {
      console.error("Error deleting item:", err);
      return res.status(500).json({ message: "Internal server error" });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Item not found" });
    }
    res.json({ message: "Item deleted successfully" });
  });
});

// DELETE endpoint to remove an item from the useritems table
router.delete("/:itemId", (req, res) => {
  const itemId = req.params.itemId;

  db.query(
    "DELETE FROM UserItems WHERE user_item_id = ?",
    [itemId],
    (err, result) => {
      if (err) {
        console.error("Error removing item:", err);
        return res.status(500).json({ message: "Internal server error" });
      }
      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Item not found" });
      }
      res.json({ message: "Item removed successfully" });
    }
  );
});

module.exports = router;
