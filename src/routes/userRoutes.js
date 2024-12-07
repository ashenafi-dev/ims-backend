const express = require("express");
const db = require("../config/db");
const bcrypt = require("bcryptjs");

const router = express.Router();

// Get User by ID
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

// Get Users by Department
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

// Update User Information (only non-role fields)
const selfUpdateUser = async (req, res) => {
  const { userId } = req.params;
  const { first_name, last_name, email, username, phone, password } = req.body;

  try {
    const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

    const query = `
      UPDATE Users
      SET first_name = ?, last_name = ?, email = ?, username = ?, phone = ?, ${
        password ? "password = ?" : ""
      }
      WHERE user_id = ?;
    `;

    const values = [
      first_name,
      last_name,
      email,
      username,
      phone,
      ...(password ? [hashedPassword] : []),
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

// Get All Users with All Attributes
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

// Delete User
const handleDeleteUser = (req, res) => {
  const { userId } = req.params;
  const query = "DELETE FROM Users WHERE user_id = ?";

  db.query(query, [userId], (err, results) => {
    if (err) {
      console.error("Error deleting user:", err);
      return res.status(500).send("Error deleting user");
    }
    res.status(200).send(`User with ID ${userId} deleted successfully`);
  });
};

// Create User
const handleCreateUser = async (req, res) => {
  const {
    username,
    password,
    email,
    phone,
    profile_image,
    department_id,
    first_name,
    last_name,
    role_id,
  } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const query = `
      INSERT INTO Users (username, password, email, phone, profile_image, department_id, first_name, last_name)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(
      query,
      [
        username,
        hashedPassword,
        email,
        phone,
        profile_image,
        department_id,
        first_name,
        last_name,
      ],
      (err, results) => {
        if (err) {
          console.error("Error creating user:", err);
          return res.status(500).send("Error creating user");
        }
        const userId = results.insertId;

        const userRoleQuery = `
          INSERT INTO UserRoles (user_id, role_id)
          VALUES (?, ?)
        `;

        db.query(userRoleQuery, [userId, role_id], (err, roleResults) => {
          if (err) {
            console.error("Error assigning role to user:", err);
            return res.status(500).send("Error assigning role to user");
          }
          res.status(201).send(`User created with ID: ${userId}`);
        });
      }
    );
  } catch (err) {
    console.error("Error during user creation process:", err);
    res.status(500).send("Error creating user");
  }
};

// Update User Information Including Role
const adminUpdateUser = async (req, res) => {
  const { userId } = req.params;
  const {
    username,
    password,
    email,
    phone,
    profile_image,
    department_id,
    first_name,
    last_name,
    role_id,
  } = req.body;

  try {
    const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

    const query = `
      UPDATE Users
      SET username = ?, 
          ${password ? "password = ?," : ""}
          email = ?, 
          phone = ?, 
          profile_image = ?, 
          department_id = ?, 
          first_name = ?, 
          last_name = ?
      WHERE user_id = ?
    `;

    const values = [
      username,
      ...(password ? [hashedPassword] : []),
      email,
      phone,
      profile_image,
      department_id,
      first_name,
      last_name,
      userId,
    ];

    db.query(query, values, (err, results) => {
      if (err) {
        console.error("Error updating user information:", err);
        return res.status(500).send("Error updating user information");
      }

      const userRoleQuery = `
        UPDATE UserRoles 
        SET role_id = ?
        WHERE user_id = ?
      `;

      db.query(userRoleQuery, [role_id, userId], (err, roleResults) => {
        if (err) {
          console.error("Error updating user role:", err);
          return res.status(500).send("Error updating user role");
        }
        res.status(200).send("User information updated successfully");
      });
    });
  } catch (err) {
    console.error("Error during update process:", err);
    res.status(500).send("Error updating user information");
  }
};

// Routes
router.put("/:userId", adminUpdateUser); // Route to update user information including role
router.get("/:user_id", handleGetUserAccountById);
router.put("/self/:userId", selfUpdateUser);
router.get("/department/:department_id/users", handleGetUsersByDepartment);
router.get("/", handleGetAllUsers); // Route to get all users
router.delete("/:userId", handleDeleteUser);
router.post("/", handleCreateUser); // Route to create user

module.exports = router;
