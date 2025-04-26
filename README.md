<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fduizendstra%2Fapps-script-template">
  <img
    height="32"
    alt="Open in Firebase Studio"
    src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
</a>

# Google Apps Script Project Template

This template provides a basic structure for developing Google Apps Script projects locally using `clasp` within Google IDX / Firebase Studio. It uses a Factory Function pattern for manager modules and modern JavaScript (V8 runtime).

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
    - **Crucially:** If your project requires configuration (API keys, specific IDs, emails), create/update the **`gas/config.js`** file (which is **gitignored**). This file is manually managed. _The AI assistant cannot see the contents of `config.js`._

2.  **Push Changes to Google:**

    - Open the IDX terminal.
    - From the project root directory, run:
      ```bash
      clasp push
      ```
    - This command uploads the contents of your local `gas/` directory (respecting `.claspignore`) to the linked Apps Script project online.
    - If you encounter conflicts (e.g., changes made directly in the online editor), `clasp` might prompt you. Use `clasp push -f` to force overwrite the online version with your local version (use with caution).

3.  **Test Your Changes:**

    - **Run Functions:** Open the script in the online editor (`clasp open`), select a function from the dropdown, and click "Run". Check `View > Logs` or `View > Executions` for output and errors.
    - **Test Web App (if applicable):** Deploy your web app (or use the test deployment URL). Access the URL in your browser. Use browser developer tools (Console, Network tabs) and GAS logs for debugging. The `gas/index.html` in this template often serves as a test harness.
    - **Test Triggers:** Set up time-driven or event-driven triggers in the online editor (`Triggers` section) and monitor their executions.

4.  **Version Control (Git):**
    - Regularly commit your changes:
      ```bash
      git add .
      git commit -m "Your descriptive commit message"
      git push
      ```
    - Use branches (`git checkout -b feature/new-thing`) for new features or fixes.

## Project Structure Overview

- **`README.md`**: (This file) Project overview, development workflow, structure.
- **`SETUP.md`**: One-time setup instructions.
- **`.idx/`**: IDX configuration.
  - `dev.nix`: Nix environment setup (installs `clasp`, `go-task`, etc.).
  - `airules.md`: Rules and context for the IDX AI assistant.
- **`.vscode/`**: (Optional) VS Code settings for the workspace.
- **`gas/`**: **Contains all code pushed to Apps Script.**
  - `appsscript.json`: The project manifest (scopes, runtime, web app settings). **Crucial.**
  - `webapp.js`: (If web app) Handles `doGet` and dispatches UI actions.
  - `index.html`: (If web app) Main UI file.
  - `managers/`: Contains modular `.js` files using Factory Functions for specific tasks (e.g., `gasSheetManager.js`, `gasErrorManager.js`).
  - `config.js`: **Manually created, gitignored.** Holds project-specific configuration.
  - _(Other `.js`, `.html` files as needed)_
- **`.gitignore`**: Tells Git which files to ignore (includes `.clasp.json`, `gas/config.js`).
- **`.claspignore`**: (Optional) Tells `clasp` which files within `gas/` _not_ to push.
- **`Taskfile.yaml`**: Defines automation tasks using Go Task (e.g., `task ai`, `task dev:branch`).

## Next Steps / Further Development

- Customize `gas/appsscript.json` with the correct `timeZone` and necessary `oauthScopes`.
- Implement the core logic of your script in the `.js` files within `gas/`.
- Flesh out the `gas/config.js` file with your project's specific settings.
- (Optional) Set up linters/formatters like ESLint and Prettier (requires adding `package.json` and running `npm install`).
