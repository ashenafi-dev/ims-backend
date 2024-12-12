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
      ApprovedBy.username AS approved_by_username,
      ApprovedBy.email AS approved_by_email,
      FromUser.username AS from_user_username,
      FromUser.email AS from_user_email,
      FromUser.first_name AS from_user_first_name,
      FromUser.last_name AS from_user_last_name,
      ToUser.username AS to_user_username,
      ToUser.email AS to_user_email,
      ToUser.first_name AS to_user_first_name,
      ToUser.last_name AS to_user_last_name
    FROM Transfers
    JOIN Items ON Transfers.item_id = Items.item_id
    LEFT JOIN Users AS ApprovedBy ON Transfers.approved_by = ApprovedBy.user_id
    LEFT JOIN Users AS FromUser ON Transfers.from_user_id = FromUser.user_id
    LEFT JOIN Users AS ToUser ON Transfers.to_user_id = ToUser.user_id
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

router.post("/api/transfers/record", (req, res) => {
  const { transferId, senderId, receiverId, itemId } = req.body;

  // Perform the transfer: remove item from sender and add to receiver
  UserItem.findOneAndRemove({ userId: senderId, itemId })
    .then(() => UserItem.create({ userId: receiverId, itemId }))
    .then(() => Transfer.findByIdAndDelete(transferId))
    .then(() => res.json({ success: true }))
    .catch((err) => res.status(500).json({ error: err.message }));
});

router.post("/api/transfers", (req, res) => {
  const { userId, targetUserId, itemId } = req.body;
  // Create a new transfer record
  const newTransfer = new Transfer({
    userId,
    targetUserId,
    itemId,
    status: "Pending Acceptance",
  });

  newTransfer
    .save()
    .then((transfer) => res.json(transfer))
    .catch((err) => res.status(500).json({ error: err.message }));
});

router.delete("/api/transfers/:transferId", (req, res) => {
  const { transferId } = req.params;
  // Remove the transfer record
  Transfer.findByIdAndDelete(transferId)
    .then(() => res.json({ success: true }))
    .catch((err) => res.status(500).json({ error: err.message }));
});

router.put("/api/transfers/accept/:transferId", (req, res) => {
  const { transferId } = req.params;
  // Update transfer status to pending approval
  Transfer.findByIdAndUpdate(
    transferId,
    { status: "Pending Approval" },
    { new: true }
  )
    .then((transfer) => res.json(transfer))
    .catch((err) => res.status(500).json({ error: err.message }));
});

router.get("/useritems/:userId", (req, res) => {
  const userId = req.params.userId;
  const query = `
    SELECT UserItems.item_id AS user_item_id, Items.name AS name
    FROM UserItems
    JOIN Items ON UserItems.item_id = Items.item_id
    WHERE UserItems.user_id   = ?
  `;
  db.query(query, [userId], (error, results) => {
    if (error) {
      console.error("Error fetching user items:", error);
      return res.status(500).json({ message: "Internal server error" });
    }
    res.json(results);
  });
});

router.get("/users", (req, res) => {
  const query = "SELECT user_id, first_name, last_name FROM Users";
  db.query(query, (error, results) => {
    if (error) {
      console.error("Error fetching users:", error);
      return res.status(500).json({ message: "Internal server error" });
    }
    res.json(results);
  });
});

// POST request to create a new transfer
router.post("/handletransfers", (req, res) => {
  const { userId, targetUserId, itemId, quantity } = req.body;

  const query = `
    INSERT INTO Transfers (from_user_id, to_user_id, item_id, quantity, requested_at, transfer_status) 
    VALUES (?, ?, ?, '1', NOW(), 'Pending')
  `;

  db.query(query, [userId, targetUserId, itemId], (error, results) => {
    if (error) {
      console.error("Error initiating transfer:", error);
      return res.status(500).json({ message: "Internal server error" });
    }

    res.json({
      message: "Transfer initiated successfully",
      transferId: results.insertId,
    });
  });
});

// DELETE request to remove a transfer
router.delete("/remove/:id", (req, res) => {
  const transferId = req.params.id;

  const query = `
    DELETE FROM Transfers 
    WHERE transfer_id = ?
  `;

  db.query(query, [transferId], (error, results) => {
    if (error) {
      console.error("Error removing transfer:", error);
      return res.status(500).json({ message: "Internal server error" });
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ message: "Transfer not found" });
    }

    res.json({ message: "Transfer removed successfully" });
  });
});

// GET request to fetch all transfer records
router.get("/getall", (req, res) => {
  const query = "SELECT * FROM transfers";
  db.query(query, (err, results) => {
    if (err) {
      console.error("Error fetching transfers:", err);
      return res.status(500).send("Error fetching transfers");
    }
    console.log("Results:", results); // Debugging statement
    res.status(200).json(results);
  });
});

module.exports = router;
