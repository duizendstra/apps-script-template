# SETUP.md

# One-Time Setup for Google Apps Script Project Template

Follow these steps **once** when you first create or clone this project workspace in Project IDX.

## 1. Verify Environment & Tools

- **`clasp` is Pre-Installed:** Your Project IDX environment automatically installs `clasp` (and other tools like `node`, `git`, `task`) based on the `.idx/dev.nix` file. **You do NOT need to install `clasp` manually.**
- **Verify Installation:** Open the IDX terminal (Ctrl+` or Cmd+`) and run:
  ```bash
  clasp --version
  ```
  You should see the installed version number (e.g., `2.4.2`). If not, there might be an issue with the IDX environment build.

## 2. Authorize `clasp` (Global Login)

- This step grants `clasp` permission to manage Apps Script projects using **your** Google Account credentials.
- In the terminal, run:
  ```bash
  clasp login
  ```
- Follow the instructions: Open the provided URL in a browser, choose your Google Account, and grant the requested permissions.
- **Outcome:** This creates or updates the **global** credential file at `~/.clasprc.json` (inside the IDX environment's home directory). This file contains sensitive authentication tokens and is **NOT** part of your project directory. This login is typically only needed once per workspace.

## 3. Link Local Project Directory to Google Apps Script

- This step creates the **local `.clasp.json` file** in your project root. This file tells `clasp` which specific Apps Script project your `gas/` directory corresponds to. It contains the `scriptId` and `rootDir`. **This file does NOT contain your sensitive auth tokens.**
- Choose **ONE** of the following options (A or B):

- **Option A: Create a NEW Apps Script Project**

  - Use this if you are starting a new project from scratch based on this template.
  - In the terminal (at the project root), run:
    ```bash
    clasp create --title "Your Project Title Here" --rootDir ./gas
    ```
  - Replace `"Your Project Title Here"` with your desired project name.
  - **Outcome:** Creates a new script file on Google Drive AND creates the local `.clasp.json` linking your workspace to it.

- **Option B: Link to an EXISTING Apps Script Project**
  - Use this if you want your local `gas/` directory to reflect an existing online project.
  - Find the **Script ID** of your existing project from its URL in the Apps Script editor (`.../d/<SCRIPT_ID>/edit`).
  - In the terminal (at the project root), run:
    ```bash
    clasp pull <SCRIPT_ID> --rootDir ./gas
    ```
  - Replace `<SCRIPT_ID>` with the actual ID.
  - **Outcome:** Creates the local `.clasp.json` linking your workspace AND downloads the code from the online project into `gas/`, **overwriting** existing files in `gas/`.

## 4. Verify `.gitignore`

- Open the `.gitignore` file in your project root.
- **Confirm** that both `.clasp.json` and `gas/config.js` are listed. This is critical to prevent committing the project link file or sensitive configurations.

## 5. Create `gas/config.js` (If Needed)

- Many projects require configuration (API keys, sheet IDs, email lists, etc.).
- If needed, **manually create** the file `config.js` inside the `gas/` directory.
- Add your configuration variables inside this file (e.g., `const CONFIG = { setting: 'value' };`).
- This file is **intentionally ignored by Git** (as specified in `.gitignore`) and must be managed manually.

## Setup Complete!

Your local environment is now configured and linked to your Google Apps Script project.

➡️ Proceed to **`README.md`** for project overview, development workflow (editing, pushing, testing), and architecture details.
