<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fduizendstra%2Fapps-script-template">
  <img
    height="32"
    alt="Open in Firebase Studio"
    src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
</a>

# Google Apps Script Project Template

This template provides a basic structure for developing Google Apps Script projects locally using `clasp` within Google IDX / Firebase Studio.

## Prerequisites

*   A Google Account.
*   Enable the Google Apps Script API in your Google Cloud Platform project: [https://console.developers.google.com/apis/library/script.googleapis.com](https://console.developers.google.com/apis/library/script.googleapis.com)

## Getting Started

1.  **Log in to clasp:**
    *   Open the IDX terminal (Ctrl+` or Cmd+`).
    *   Run the command: `clasp login`
    *   Follow the prompts to authorize `clasp` with your Google Account.

2.  **Choose Your Path:**

    *   **A) Create a NEW Standalone Apps Script Project:**
        *   Run: `clasp create --title "Your Project Title Here" --rootDir ./`
        *   Replace `"Your Project Title Here"` with a suitable name.
        *   This creates a new script project on Google Drive and links it to this local directory (creates a `.clasp.json` file - **do not commit this file!**).

    *   **B) Link to an EXISTING Apps Script Project:**
        *   Find the **Script ID** of your existing project. Open the script in the Apps Script editor; the ID is in the URL: `https://script.google.com/d/<SCRIPT_ID>/edit`.
        *   Run: `clasp pull <SCRIPT_ID> --rootDir ./`
        *   Replace `<SCRIPT_ID>` with your actual Script ID.
        *   This will pull the existing code from the cloud, potentially overwriting local files like `Code.gs` and `appsscript.json`. It also creates the `.clasp.json` file.

3.  **Develop Locally:**
    *   Edit the `.gs` or `.js` files (for V8 runtime) and the `appsscript.json` manifest.
    *   Refer to the [Apps Script documentation](https://developers.google.com/apps-script).

4.  **Push Changes:**
    *   When ready to upload your local changes to Google: `clasp push`
    *   Check the output for any errors. Use `clasp push -f` to force overwrite if necessary, but use with caution.

5.  **Test:**
    *   Open the script in the online Apps Script editor (`clasp open`) to run functions, set triggers, or test it within its bound Google Workspace application (Sheets, Docs, etc.).

## Included Files

*   `.idx/dev.nix`: Configures the IDX environment (installs `node`, `clasp`).
*   `appsscript.json`: The Apps Script project manifest. **Remember to set your `timeZone`!**
*   `Code.gs`: Default script file. Add your code here or create more `.gs`/`.js` files.
*   `.claspignore`: Specifies files/directories for `clasp` to ignore when pushing.
*   `.gitignore`: Specifies files/directories for `git` to ignore. Includes `.clasp.json` by default to prevent committing credentials.
*   `README.md`: This file.

## Next Steps

*   Customize `appsscript.json` (scopes, libraries, add-on settings).
*   Write your Apps Script code in `Code.gs` or other `.gs`/`.js` files.
*   Consider adding linting/formatting tools (ESLint, Prettier) using a `package.json` and `npm install`.
