const app = require("./App");
require("dotenv").config;
const port = 5000;

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
