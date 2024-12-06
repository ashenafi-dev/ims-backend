const express = require("express");
const db = require("../config/db");
const bcrypt = require("bcryptjs");

const router = express.Router();

const handleGetUserAccountById = (req, res) => {
  const { user_id } = req.params;
  const query = `
    SELECT 
      Users.user_id,
      Users.username,
      Users.email,
      Users.phone,
      Users.password,
      Users.profile_image,
      Users.created_at,
      Users.updated_at,
      Users.department_id,
      Departments.department_name,
      Users.first_name,
      Users.last_name,
      Users.is_deleted,
      Roles.role_name
    FROM Users
    LEFT JOIN Departments ON Users.department_id = Departments.department_id
    LEFT JOIN UserRoles ON Users.user_id = UserRoles.user_id
    LEFT JOIN Roles ON UserRoles.role_id = Roles.role_id
    WHERE Users.user_id = ?;
  `;
  db.query(query, [user_id], (err, results) => {
    if (err) {
      console.error("Error fetching user account information:", err);
      return res.status(500).send("Error fetching user account information");
    }
    res.status(200).json(results[0]);
  });
};

const handleGetUsersByDepartment = (req, res) => {
  const { department_id } = req.params;
  const query = `
    SELECT 
      Users.user_id,
      Users.username,
      Users.email,
      Users.phone,
      Users.profile_image,
      Users.created_at,
      Users.updated_at,
      Users.department_id,
      Users.first_name,
      Users.last_name,
      Users.is_deleted
    FROM Users
    WHERE Users.department_id = ?;
  `;
  db.query(query, [department_id], (err, results) => {
    if (err) {
      console.error("Error fetching users by department:", err);
      return res.status(500).send("Error fetching users by department");
    }
    res.status(200).json(results);
  });
};

const updateUser = async (req, res) => {
  const { userId } = req.params;
  const { first_name, last_name, email, username, phone, password } = req.body;

  try {
    const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

    const query = `
      UPDATE Users
      SET first_name = ?, last_name = ?, email = ?, username = ?, phone = ?, password = ?
      WHERE user_id = ?;
    `;

    const values = [
      first_name,
      last_name,
      email,
      username,
      phone,
      hashedPassword || undefined,
      userId,
    ];

    db.query(query, values, (err, results) => {
      if (err) {
        console.error("Error updating user information:", err);
        return res.status(500).send("Error updating user information");
      }
      res.status(200).send("User information updated successfully");
    });
  } catch (err) {
    console.error("Error during update process:", err);
    res.status(500).send("Error updating user information");
  }
};

// New Route: Get All Users with All Attributes
const handleGetAllUsers = (req, res) => {
  const query = `
    SELECT 
      Users.user_id,
      Users.username,
      Users.email,
      Users.phone,
      Users.profile_image,
      Users.created_at,
      Users.updated_at,
      Users.department_id,
      Departments.department_name,
      Users.first_name,
      Users.last_name,
      Users.is_deleted,
      GROUP_CONCAT(Roles.role_name SEPARATOR ', ') AS roles
    FROM Users
    LEFT JOIN Departments ON Users.department_id = Departments.department_id
    LEFT JOIN UserRoles ON Users.user_id = UserRoles.user_id
    LEFT JOIN Roles ON UserRoles.role_id = Roles.role_id
    GROUP BY Users.user_id
  `;
  db.query(query, (err, results) => {
    if (err) {
      console.error("Error fetching all users:", err);
      return res.status(500).send("Error fetching all users");
    }
    res.status(200).json(results);
  });
};

// Routes
router.get("/:user_id", handleGetUserAccountById);
router.get("/department/:department_id/users", handleGetUsersByDepartment);
router.put("/:userId", updateUser);
router.get("/", handleGetAllUsers); // New Route

module.exports = router;
