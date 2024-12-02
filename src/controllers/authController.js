const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const User = require("../models/userModel");
const JWT_SECRET =
  "2c5e4503b73296538aade352b8130db1550fa9be63937069d272236daa4f743fd6717a280654a464e3f8dd0f01b4b27fb5e8e16fb0c02474b5e7e92a8894eada";
const login = (req, res) => {
  const { username, password } = req.body;

  User.findByUsername(username, async (err, user) => {
    if (err) return res.status(500).send("Error logging in");
    if (!user) return res.status(404).send("User not found");

    console.log("User-provided password:", password);
    console.log("Stored hashed password:", user.password);
    console.log("user-stored username:", user.username);
    console.log("user-stored role:", user.role);

    try {
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) return res.status(401).send("Invalid credentials");
      console.log(isMatch);

      const token = jwt.sign(
        { id: user.id, username: user.username, role: user.role },
        JWT_SECRET,
        {
          expiresIn: "1h",
        }
      );
      console.log(token);
      res.json({ token });
    } catch (error) {
      console.error("Error comparing passwords:", error);
      res.status(500).send("Error logging in");
    }
  });
};

module.exports = { login };
