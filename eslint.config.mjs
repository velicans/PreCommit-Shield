// ESLint Flat Config - Google JavaScript Style Guide
// https://google.github.io/styleguide/jsguide.html
import googleConfig from "eslint-config-google";

export default [
  {
    ...googleConfig,
    files: ["**/*.js", "**/*.mjs", "**/*.cjs"],
    rules: {
      ...googleConfig.rules,
      // Google Style enforcements
      "indent": ["error", 2],                    // 2-space indentation
      "max-len": ["error", {                     // 80 char line length
        "code": 80,
        "tabWidth": 2,
        "ignoreUrls": true,
        "ignoreStrings": true,
        "ignoreTemplateLiterals": true,
        "ignoreRegExpLiterals": true,
      }],
      "semi": ["error", "always"],               // Always use semicolons
      "quotes": ["error", "single", {            // Single quotes
        "allowTemplateLiterals": true,
      }],
      "comma-dangle": ["error", "always-multiline"],  // Trailing commas
      "no-tabs": "error",                        // No tabs
      "eol-last": "error",                       // Newline at end of file
      "no-trailing-spaces": "error",             // No trailing whitespace
      "camelcase": ["error", {                   // camelCase naming
        "properties": "never",
      }],
      "new-cap": ["error", {                     // PascalCase for constructors
        "capIsNew": false,
      }],
      "no-var": "error",                         // Use const/let, not var
      "prefer-const": "error",                   // Prefer const
      "arrow-parens": ["error", "always"],       // Always use parens in arrows
      "object-curly-spacing": ["error", "never"],// No spaces in braces
      "require-jsdoc": "off",                    // JSDoc optional (toggle on if needed)
      "valid-jsdoc": "off",                      // Deprecated rule
    },
  },
  {
    ignores: ["node_modules/**", "dist/**", "build/**"],
  },
];
