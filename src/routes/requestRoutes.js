const express = require("express");
const db = require("../config/db");

const router = express.Router();

// GET requests by user ID with status 'Pending' or 'Denied'
router.get("/:user_id/status", (req, res) => {
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
    WHERE Requests.user_id = ? AND Requests.request_status IN ('Pending', 'Denied');
  `;

  db.query(query, [user_id], (err, results) => {
    if (err) {
      console.error("Error fetching requests:", err);
      return res.status(500).send("Error fetching requests");
    }
    res.status(200).json(results);
  });
});
// PUT request to update request status
router.put("/requests/:id", (req, res) => {
  const requestId = req.params.id;
  const { request_status } = req.body;

  if (request_status === "Received") {
    // Fetch the request details
    db.query(
      `
      SELECT 
        Requests.*,
        Items.name AS item_name, 
        Items.description AS item_description, 
        Users.username AS requester_username, 
        Users.first_name AS requester_first_name, 
        Users.last_name AS requester_last_name 
      FROM Requests
      JOIN Items ON Requests.item_id = Items.item_id
      JOIN Users ON Requests.user_id = Users.user_id
      WHERE Requests.request_id = ?
      `,
      [requestId],
      (err, requestResult) => {
        if (err) {
          console.error("Error fetching request:", err);
          return res.status(500).json({ message: "Internal server error" });
        }

        if (requestResult.length === 0) {
          return res.status(404).json({ message: "Request not found" });
        }

        const request = requestResult[0];
        const { user_id, item_id, quantity } = request;

        // Insert into UserItems
        db.query(
          "INSERT INTO UserItems (user_id, item_id, quantity, acquired_date) VALUES (?, ?, ?, CURDATE())",
          [user_id, item_id, quantity],
          (insertErr) => {
            if (insertErr) {
              console.error("Error inserting into UserItems:", insertErr);
              return res.status(500).json({ message: "Internal server error" });
            }

            // Delete from Requests
            db.query(
              "DELETE FROM Requests WHERE request_id = ?",
              [requestId],
              (deleteErr) => {
                if (deleteErr) {
                  console.error("Error deleting request:", deleteErr);
                  return res
                    .status(500)
                    .json({ message: "Internal server error" });
                }

                res.json({
                  message: "Request processed and moved to UserItems",
                  request: {
                    item_name: request.item_name,
                    item_description: request.item_description,
                    requester_username: request.requester_username,
                    requester_first_name: request.requester_first_name,
                    requester_last_name: request.requester_last_name,
                  },
                });
              }
            );
          }
        );
      }
    );
  } else {
    db.query(
      "UPDATE Requests SET request_status = ? WHERE request_id = ?",
      [request_status, requestId],
      (error, results) => {
        if (error) {
          console.error("Error updating request status:", error);
          return res.status(500).json({ message: "Internal server error" });
        }

        if (results.affectedRows === 0) {
          return res.status(404).json({ message: "Request not found" });
        }

        res.json({ message: "Request status updated successfully" });
      }
    );
  }
});

// PUT request to update request status
router.put("/:id", (req, res) => {
  const requestId = req.params.id;
  const { request_status } = req.body;

  db.query(
    "UPDATE Requests SET request_status = ? WHERE request_id = ?",
    [request_status, requestId],
    (error, results) => {
      if (error) {
        console.error("Error updating request status:", error);
        return res.status(500).json({ message: "Internal server error" });
      }

      if (results.affectedRows === 0) {
        return res.status(404).json({ message: "Request not found" });
      }

      res.json({ message: "Request status updated successfully" });
    }
  );
});

// GET requests with status 'Pending'
router.get("/pending", (req, res) => {
  const query = `
    SELECT 
      Requests.request_id,
      Requests.request_date,
      Requests.quantity,
      Requests.request_status,
      Requests.approved_by,
      Requests.approval_date,
      Items.name AS item_name,
      Items.description AS item_description,
      Items.category AS item_category,
      Items.price AS item_price,
      Items.stock_level AS item_stock_level,
      Requester.username AS requester_name,
      Requester.first_name AS requester_first_name,
      Requester.last_name AS requester_last_name,
      Requestee.username AS requestee_name,
      Requestee.first_name AS requestee_first_name,
      Requestee.last_name AS requestee_last_name
    FROM Requests
    JOIN Items ON Requests.item_id = Items.item_id
    JOIN Users AS Requester ON Requests.user_id = Requester.user_id
    LEFT JOIN Users AS Requestee ON Requests.approved_by = Requestee.user_id
    WHERE Requests.request_status = 'Pending'
  `;

  db.query(query, (error, results) => {
    if (error) {
      console.error("Error fetching pending requests:", error);
      return res.status(500).json({ message: "Internal server error" });
    }

    if (results.length === 0) {
      console.log("No pending requests found."); // Debug log
      return res.status(404).json({ message: "No pending requests found" });
    }

    console.log("Fetched pending requests:", results); // Debug log
    res.json(results);
  });
});

// DELETE request by ID
router.delete("/:id", (req, res) => {
  const requestId = req.params.id;

  // Check if requestId is valid
  if (!requestId) {
    return res.status(400).json({ message: "Invalid request ID" });
  }

  db.query(
    "DELETE FROM requests WHERE request_id = ?",
    [requestId],
    (error, results) => {
      if (error) {
        console.error("Error deleting request:", error);
        return res.status(500).json({ message: "Internal server error" });
      }

      if (results.affectedRows === 0) {
        return res.status(404).json({ message: "Request not found" });
      }

      res.json({ message: "Request deleted successfully" });
    }
  );
});

// Route to submit a request
router.post("/submit", (req, res) => {
  const { user_id, item_id, quantity, request_status } = req.body;
  const query =
    "INSERT INTO Requests (user_id, item_id, quantity, request_status, request_date) VALUES (?, ?, ?, ?, NOW())";

  db.query(
    query,
    [user_id, item_id, quantity, request_status],
    (error, results) => {
      if (error) {
        console.error("Error submitting request:", error);
        return res
          .status(500)
          .json({ message: "Failed to submit request", error: error.message });
      }
      res.json({
        message: "Request submitted successfully",
        requestId: results.insertId,
      });
    }
  );
});

// GET approved requests with joined user and item details
router.get("/staff/approved", (req, res) => {
  const query = `
    SELECT 
      Requests.request_id,
      Requests.request_date,
      Requests.quantity,
      Requests.request_status,
      Items.name AS item_name,
      Items.description AS item_description,
      Items.category AS item_category,
      Items.price AS item_price,
      Items.stock_level AS item_stock_level,
      Users.username AS requester_username,
      Users.first_name AS requester_first_name,
      Users.last_name AS requester_last_name
    FROM Requests
    JOIN Items ON Requests.item_id = Items.item_id
    JOIN Users ON Requests.user_id = Users.user_id
    WHERE Requests.request_status = 'Approved'
  `;

  db.query(query, (error, results) => {
    if (error) {
      console.error("Error fetching approved requests:", error);
      return res.status(500).json({ message: "Internal server error" });
    }

    if (results.length === 0) {
      console.log("No approved requests at the moment."); // Debug log
      return res
        .status(404)
        .json({ message: "No approved requests at the moment" });
    }

    console.log("Fetched approved requests:", results); // Debug log
    res.json(results);
  });
});

// GET requests with status 'Approved'
router.get("/staff/approved", (req, res) => {
  db.query(
    "SELECT * FROM Requests WHERE request_status = 'Approved'",
    (error, results) => {
      if (error) {
        console.error("Error fetching approved requests:", error);
        return res.status(500).json({ message: "Internal server error" });
      }

      res.json(results);
    }
  );
});

module.exports = router;
