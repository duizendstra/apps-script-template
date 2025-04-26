# SETUP.md

# One-Time Setup for Google Apps Script Project Template

Follow these steps **once** when you first create or clone this project workspace in Project IDX.

## Prerequisites

1.  **Google Account:** You need a standard Google Account (or Google Workspace account).

2.  **Enable Apps Script API Access (User Setting):**
    - **CRITICAL:** This is an **essential** setting to allow tools like `clasp` to work with your account.
    - Go to your Apps Script User Settings page:
      [https://script.google.com/home/usersettings](https://script.google.com/home/usersettings)
    - Scroll down to the "API" section.
    - Find "Google Apps Script API".
    - **Ensure** the toggle switch is turned **"On"**.
    - **IMPORTANT:** If the switch is off, turn it on. `clasp` will not function correctly if this API is not enabled.

## 1. Verify Environment & Tools

Your Project IDX environment automatically installs `clasp`, `node`, `git`, and `task` using the `.idx/dev.nix` configuration. You do **not** need to install these manually.

- **Verify `clasp`:** Open the IDX terminal (Ctrl+` or Cmd+`) and run:
  ```bash
  clasp --version
  ```
  You should see the installed version number. If not, check the IDX environment status.

## 2. Authorize `clasp` (Global Login)

This step grants `clasp` permission to manage Apps Script projects using your Google Account. Because the browser cannot directly reach the internal `localhost` of IDX, a manual step with `curl` is needed.

- **a. Start Login:** In the **first** IDX terminal, run:

  ```bash
  clasp login
  ```

  `clasp` will display an authorization URL and indicate it's listening on `http://localhost:<port>`. Keep this terminal open.

- **b. Authorize in Browser:** Copy the long authorization URL from the terminal. Paste it into your **local computer's web browser** and grant the requested permissions to `clasp` using your Google Account.

- **c. Capture Redirect URL:** Your browser will try to redirect back to `http://localhost:<port>`, which will fail. **Copy the complete URL** from your browser's address bar after the failed redirect – it contains the required authorization code (e.g., `http://localhost:12345/?code=4/0A...&scope=...`).

- **d. Send Code via `curl`:** Open a **second** IDX terminal. Run `curl`, pasting the full URL you copied inside double quotes:

  ```bash
  curl "<PASTE_THE_FULL_URL_HERE>"
  ```

  Press Enter.

- **e. Check Success:** Switch back to the **first** terminal. You should see the `Authorization successful.` message. You can close the second (`curl`) terminal.

- **Outcome:** The global credential file (`~/.clasprc.json`, outside your project) is created/updated with your authentication tokens.

## 3. Link Local Project Directory to Google Apps Script

This creates the local `.clasp.json` file in your project root, linking your `gas/` directory to a specific script. This file does **not** contain sensitive auth tokens. Choose **one** option:

- **Option A: Create NEW Project**

  - In the terminal (project root):
    ```bash
    clasp create --title "Your Project Title Here" --rootDir ./gas
    ```
  - Replace `"Your Project Title Here"` with your desired name.
  - _Outcome:_ Creates a new script on Google Drive and the local `.clasp.json` file.

- **Option B: Link to EXISTING Project**
  - Find the Script ID from the Apps Script editor URL (`.../d/<SCRIPT_ID>/edit`).
  - In the terminal (project root):
    ```bash
    clasp pull <SCRIPT_ID> --rootDir ./gas
    ```
  - Replace `<SCRIPT_ID>` with the actual ID.
  - _Outcome:_ Creates the local `.clasp.json` and downloads existing code into `gas/`, potentially overwriting local files there.

## 4. Verify `.gitignore`

- Open the `.gitignore` file in your project root.
- **Confirm** that both `.clasp.json` and `gas/config.js` are listed to prevent committing the project link or sensitive configurations.

## 5. Create `gas/config.js` (If Needed)

- If your script needs specific configuration (API keys, IDs, emails, etc.), **manually create** the file `config.js` inside the `gas/` directory.
- Define your settings within this file, typically using a `CONFIG` object (e.g., `const CONFIG = { setting: 'value' };`).
- This file is ignored by Git and must be managed manually.

## 6. Initialize Git Repository & Push to GitHub

This section guides you through setting up version control with Git and pushing your new project to GitHub.

- **a. Initialize Git Repository:**

  - In the terminal (ensure you are in the project root directory):
    ```bash
    git init -b main
    ```
    _(This initializes Git and sets the default branch name to `main`)_

- **b. Stage All Project Files:**

  - Add all the project files (respecting `.gitignore`) to the staging area:
    ```bash
    git add .
    ```

- **c. Make Initial Commit:**

  - Commit the staged files with a message:
    ```bash
    git commit -m "Initial commit of Apps Script project from template"
    ```

- **d. Create a Repository on GitHub:**

  - Go to [GitHub.com](https://github.com) in your web browser.
  - Log in to your GitHub account.
  - Create a **new repository**. Give it a name (e.g., `my-apps-script-project`).
  - **Important:** Do **NOT** initialize the new repository with a README, .gitignore, or license file on GitHub – you already have these locally. Keep the new repository empty.
  - Copy the repository's **HTTPS or SSH URL** provided by GitHub (it usually ends in `.git`).

- **e. Link Local Repo to GitHub:**

  - In the terminal, add the GitHub repository URL as the `origin` remote. Replace `<GITHUB_REPOSITORY_URL>` with the URL you copied:
    ```bash
    git remote add origin <GITHUB_REPOSITORY_URL>
    ```

- **f. Push Initial Commit to GitHub:**

  - Push your local `main` branch commit to the `origin` remote (GitHub):
    ```bash
    git push -u origin main
    ```
  - You might be prompted to authenticate with GitHub if this is your first time pushing from this environment.

- **Outcome:** Your project code is now initialized with Git and stored in your remote GitHub repository.

## Setup Complete!

Your local environment is configured, linked to Google Apps Script, and stored in your GitHub repository.

Proceed to **`README.md`** for project overview, development workflow, and architecture details.
