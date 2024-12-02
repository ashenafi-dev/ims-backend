const db = require("../config/db");

const User = {
  findByUsername: (username, callback) => {
    const query = "SELECT * FROM my_users WHERE username = ?";
    db.query(query, [username], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Assuming usernames are unique and return one result
    });
  },
};

module.exports = User;
