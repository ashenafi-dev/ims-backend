const { LocalStorage } = require("node-localstorage");
const localStorage = new LocalStorage("./scratch");

// Function to delete token
const deleteToken = (tokenKey) => {
  localStorage.removeItem(tokenKey);
  console.log(`${tokenKey} has been deleted from local storage`);
};

// Example usage
const tokenKey = "token";
deleteToken(tokenKey);
