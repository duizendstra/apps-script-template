<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fduizendstra%2Fapps-script-template">
  <img
    height="32"
    alt="Open in Firebase Studio"
    src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
</a>

# Google Apps Script Project Template

This template provides a structure for developing Google Apps Script projects locally using `clasp` within Project IDX. It uses a Factory Function pattern for manager modules and modern JavaScript (V8 runtime).

**➡️ For initial one-time setup instructions (logging in, linking project), please see `SETUP.md`.**

## Project Overview

- **Goal:** (Describe the main purpose of _this specific_ Apps Script project, e.g., "Automate weekly report generation", "Provide a web interface for managing user data in a Sheet", "Implement a custom function for Google Sheets").
- **Key Features:** (List major functionalities).
- **Technology:** Google Apps Script (V8), Clasp, potentially HTML/CSS/Client-JS for web apps.

## Development Workflow

_(Assumes you have completed the one-time steps in `SETUP.md`)_

1.  **Edit Code:**

    - All Apps Script server-side code resides in the `gas/` directory.
    - Modify existing `.js` files (e.g., `webapp.js`, files in `managers/`) or create new ones within `gas/`.
    - If building a web app, edit `gas/index.html` and related client-side CSS/JS.
    - Update the manifest `gas/appsscript.json` as needed (e.g., add OAuth scopes, configure web app).
    - **Configuration (`gas/config.js`):** If your project requires configuration (API keys, specific IDs, emails), create/update the **`gas/config.js`** file. This file is **gitignored** and must be managed manually. The AI assistant cannot see its contents but expects a `CONFIG` object to be available based on its structure.

2.  **Push Changes to Google:**

    - Open the IDX terminal.
    - From the project root directory, run:
      ```bash
      clasp push
      ```
    - This command uploads the contents of your local `gas/` directory (respecting `.claspignore`, if present) to the linked Apps Script project online.
    - If you encounter conflicts, use `clasp push -f` to force overwrite (use with caution).

3.  **Test Your Changes:**

    - **Run Functions:** Open the script online (`clasp open`), select a function, and click "Run". Check logs (`View > Logs` / `Executions`).
    - **Test Web App:** Deploy the web app (or use the test deployment) and access its URL. Use browser developer tools and GAS logs.
    - **Test Triggers:** Set up triggers online and monitor executions.

4.  **Version Control (Git):**
    - Regularly commit your changes (`git add .`, `git commit`, `git push`).
    - Use branches for features/fixes.

## Project Structure Overview

- **`README.md`**: (This file) Project overview, development workflow, structure details.
- **`SETUP.md`**: One-time setup instructions (login, linking).
- **`.idx/`**: IDX configuration.
  - `dev.nix`: Nix environment setup (installs `clasp`, `go-task`, etc.).
  - `airules.md`: Rules and context for the IDX AI assistant.
- **`.vscode/`**: (Optional) VS Code workspace settings.
- **`gas/`**: **Contains all code pushed to Apps Script.** (`rootDir` for clasp).
  - `appsscript.json`: The project manifest (scopes, runtime, web app settings). **Crucial.**
  - `webapp.js`: (If web app) Handles `doGet` and dispatches UI actions.
  - `index.html`: (If web app) Main UI file.
  - `managers/`: Contains modular `.js` files using Factory Functions (e.g., `gasSheetManager.js`).
  - `config.js`: **Manually created, gitignored.** Holds project-specific configuration.
  - _(Other `.js`, `.html` files as needed)_
- **`.gitignore`**: Tells Git which files to ignore (includes `.clasp.json`, `gas/config.js`).
- **`.claspignore`**: (Optional) Tells `clasp` which files within `gas/` _not_ to push.
- **`Taskfile.yaml`**: Defines automation tasks using Go Task (e.g., `task ai`).
- **`.clasp.json`**: (Created during setup) Local file linking project to `scriptId`. **Gitignored.**

## Key Concepts & Patterns

- **Global Scope:** All `.js` files in `gas/` share one global scope. No `require` or `import` needed.
- **Factory Functions:** Managers (`gas/managers/*.js`) use this pattern (no `class`). Instantiate by calling the global factory function.
- **Configuration:** Use the manually created, gitignored `gas/config.js` for runtime settings.
- **Error Handling:** Use `try...catch` and the `gasErrorManager`'s `throwError` method.
- **Time Limits:** Use the `gasTimeManager`'s `resetStartTime()` and `hasEnoughTime()` methods for long operations.

## Next Steps / Further Development

- Customize `gas/appsscript.json` with the correct `timeZone` and necessary `oauthScopes`.
- Implement the core logic of your script in the `.js` files within `gas/`.
- Populate the `gas/config.js` file with your project's specific settings.
- (Optional) Set up ESLint/Prettier via `package.json`.
