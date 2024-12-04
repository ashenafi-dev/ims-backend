const bcrypt = require("bcryptjs");
const db = require("../config/db"); // Adjust the path as needed

(async () => {
  try {
    // Query to get all users
    const [users] = await db
      .promise()
      .query("SELECT user_id, username, password FROM Users");

    for (const user of users) {
      if (!user.password.startsWith("$2a$")) {
        // Check if the password is already hashed
        const hashedPassword = await bcrypt.hash(user.password, 10); // 10 is the salt rounds

        // Update the password in the database
        await db
          .promise()
          .query("UPDATE Users SET password = ? WHERE user_id = ?", [
            hashedPassword,
            user.user_id,
          ]);
      }
    }
    console.log("Passwords updated successfully");
  } catch (error) {
    console.error("Error updating passwords:", error);
  } finally {
    // Close the database connection
    db.end();
  }
})();
