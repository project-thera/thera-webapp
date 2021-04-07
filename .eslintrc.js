module.exports = {
  env: {
    browser: true,
    node: true // needed for the require()
  },
  // https://eslint.vuejs.org/user-guide/#how-to-use-a-custom-parser
  parser: "vue-eslint-parser",
  parserOptions: {
    parser: "@babel/eslint-parser" // Needed for static properties in resources
  },
  extends: [
    "eslint:recommended",
    "plugin:prettier/recommended",
    "plugin:vue/recommended", // Use this if you are using Vue.js 2.x.
    "prettier"
  ]
};
