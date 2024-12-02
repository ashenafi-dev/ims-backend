const bcrypt = require("bcryptjs");
const db = require("./db"); // Adjust the path as needed

(async () => {
  try {
    // Query to get all users
    const [users] = await db
      .promise()
      .query("SELECT id, username, password FROM my_users");

    for (const user of users) {
      if (!user.password.startsWith("$2a$")) {
        // Check if the password is already hashed
        const hashedPassword = await bcrypt.hash(user.password, 10); // 10 is the salt rounds

        // Update the password in the database
        await db
          .promise()
          .query("UPDATE my_users SET password = ? WHERE id = ?", [
            hashedPassword,
            user.id,
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
