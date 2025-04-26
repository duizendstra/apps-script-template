# SETUP.md

# One-Time Setup for Google Apps Script Project Template

Follow these steps **once** when you first create or clone this project workspace.

## Prerequisites

- A **Google Account**.
- Enable the **Google Apps Script API** in your Google Cloud Platform project:
  - Go to: [https://console.developers.google.com/apis/library/script.googleapis.com](https://console.developers.google.com/apis/library/script.googleapis.com)
  - Select your Cloud project (or create one).
  - Click "Enable".

## Initial Clasp Setup

1.  **Log in to clasp:**

    - The `clasp` command-line tool should already be installed in your IDX environment (via `.idx/dev.nix`).
    - Open the IDX terminal (Ctrl+` or Cmd+`).
    - Run the command:
      ```bash
      clasp login
      ```
    - This will open a browser window/tab. Follow the prompts to choose your Google Account and authorize `clasp` to manage your Apps Script projects.
    - Return to the terminal. You should see "Authorization successful." This creates a global configuration file (`~/.clasprc.json`) containing your credentials. **You only need to do this once per IDX workspace (or wherever clasp is installed).**

2.  **Link Your Local Project to Google Apps Script:**

    - Decide if you are creating a **new** script or linking to an **existing** one.

    - **A) Create a NEW Standalone Apps Script Project:**

      - In the terminal (ensure you are in the project's root directory), run:
        ```bash
        clasp create --title "Your Project Title Here" --rootDir ./gas
        ```
      - Replace `"Your Project Title Here"` with a suitable name for your script.
      - The `--rootDir ./gas` tells `clasp` that your Apps Script source code resides in the `gas/` subdirectory.
      - This command does two things:
        1.  Creates a new, blank Apps Script project file in your Google Drive.
        2.  Creates a `.clasp.json` file in your local project root directory. This file contains the `scriptId` of the newly created project and the `rootDir`. **Do NOT commit `.clasp.json` to Git (it's ignored by `.gitignore`).**

    - **B) Link to an EXISTING Apps Script Project:**
      - Open your existing Apps Script project in the online editor.
      - Find its **Script ID** in the URL: `https://script.google.com/d/<SCRIPT_ID>/edit`. Copy the `<SCRIPT_ID>` part.
      - In the terminal (in the project root directory), run:
        ```bash
        clasp pull <SCRIPT_ID> --rootDir ./gas
        ```
      - Replace `<SCRIPT_ID>` with the actual ID you copied.
      - The `--rootDir ./gas` specifies the local source directory.
      - This command does two things:
        1.  Creates the `.clasp.json` file locally, linking this directory to the existing script via its ID.
        2.  **Downloads (pulls)** the code and manifest (`appsscript.json`) from the existing online project into your local `gas/` directory, potentially **overwriting** any files you already have there (like the template's `Code.gs` or `appsscript.json`).

## Next Steps

Once you have completed these steps, you have successfully linked your local project environment to a Google Apps Script project.

Refer to the main **`README.md`** file for information about the project structure, the development workflow (editing, pushing, testing), and other project details.
