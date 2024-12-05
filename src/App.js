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

const handleGetRequestsByUserId = (req, res) => {
  const { user_id } = req.params;
  const query = `
    SELECT 
      Requests.request_id,
      Requests.request_date,
      Requests.quantity,
      Requests.request_status,
      Requests.approval_date,
      Items.name AS item_name,
      Items.description AS item_description,
      Items.category AS item_category,
      Items.price AS item_price,
      Items.stock_level AS item_stock_level,
      Items.eligibility_tag AS item_eligibility_tag,
      Items.stock_date AS item_stock_date,
      Items.expiration_date AS item_expiration_date,
      Items.media_url AS item_media_url,
      Items.measurment_unit AS item_measurment_unit,
      Items.manufacturer AS item_manufacturer,
      Items.model_number AS item_model_number,
      Users.username AS approved_by_username,
      Users.email AS approved_by_email
    FROM Requests
    JOIN Items ON Requests.item_id = Items.item_id
    LEFT JOIN Users ON Requests.approved_by = Users.user_id
    WHERE Requests.user_id = ?;
  `;
  db.query(query, [user_id], (err, results) => {
    if (err) {
      return res.status(500).send("Error fetching requests");
    }
    res.status(200).json(results);
  });
};

// Endpoint to get all requests by user ID
app.get("/requests/:user_id", handleGetRequestsByUserId);

const handleGetTransfersByUserId = (req, res) => {
  const { user_id } = req.params;
  const query = `
    SELECT 
      Transfers.transfer_id,
      Transfers.requested_at,
      Transfers.quantity,
      Transfers.transfer_status,
      Transfers.approval_date,
      Items.name AS item_name,
      Items.description AS item_description,
      Items.category AS item_category,
      Items.price AS item_price,
      Items.stock_level AS item_stock_level,
      Items.eligibility_tag AS item_eligibility_tag,
      Items.stock_date AS item_stock_date,
      Items.expiration_date AS item_expiration_date,
      Items.media_url AS item_media_url,
      Items.measurment_unit AS item_measurment_unit,
      Items.manufacturer AS item_manufacturer,
      Items.model_number AS item_model_number,
      Users.username AS approved_by_username,
      Users.email AS approved_by_email
    FROM Transfers
    JOIN Items ON Transfers.item_id = Items.item_id
    LEFT JOIN Users ON Transfers.approved_by = Users.user_id
    WHERE Transfers.from_user_id = ? OR Transfers.to_user_id = ?;
  `;
  db.query(query, [user_id, user_id], (err, results) => {
    if (err) {
      return res.status(500).send("Error fetching transfers");
    }
    res.status(200).json(results);
  });
};

// Endpoint to get all transfers by user ID
app.get("/transfers/:user_id", handleGetTransfersByUserId);

module.exports = app;
