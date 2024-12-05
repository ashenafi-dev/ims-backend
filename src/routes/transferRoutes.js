const express = require("express");
const db = require("../config/db");

const router = express.Router();

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
      console.error("Error fetching transfers:", err);
      return res.status(500).send("Error fetching transfers");
    }
    res.status(200).json(results);
  });
};

// Endpoint to get all transfers by user ID
router.get("/:user_id", handleGetTransfersByUserId);

module.exports = router;
