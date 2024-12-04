const db = require("../config/db");

const User = {
  findByUsername: (username, callback) => {
    const query = `
      SELECT u.*, r.role_name 
      FROM Users u 
      LEFT JOIN UserRoles ur ON u.user_id = ur.user_id 
      LEFT JOIN Roles r ON ur.role_id = r.role_id 
      WHERE u.username = ? AND u.is_deleted = FALSE
    `;
    db.query(query, [username], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Assuming usernames are unique and return one result
    });
  },
};

module.exports = User;
