<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fduizendstra%2Fapps-script-template">
  <img
    height="32"
    alt="Open in Firebase Studio"
    src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
</a>

# Google Apps Script Project Template

This template provides a basic structure for developing Google Apps Script projects locally using `clasp` within Google IDX / Firebase Studio.

During workspace creation, `clasp` (either the latest stable or alpha version, based on your selection) was automatically installed using `npm`.

## Prerequisites

*   A Google Account.
*   Enable the Google Apps Script API in your Google Cloud Platform project: [https://console.developers.google.com/apis/library/script.googleapis.com](https://console.developers.google.com/apis/library/script.googleapis.com)

## Getting Started

1.  **Log in to clasp:**
    *   The necessary version of `clasp` should already be installed. Open the IDX terminal (Ctrl+` or Cmd+`).
    *   Run the command: `clasp login`
    *   Follow the prompts to authorize `clasp` with your Google Account. You only need to do this once per workspace/account.

2.  **Choose Your Path:**

    *   **A) Create a NEW Standalone Apps Script Project:**
        *   Run: `clasp create --title "Your Project Title Here" --rootDir ./`
        *   *(Optional: If you provided a Project Title parameter during setup, you could use that here)*.
        *   This creates a new script project on Google Drive and links it to this local directory (creates `.clasp.json`).

    *   **B) Link to an EXISTING Apps Script Project:**
        *   Find the **Script ID** of your existing project (from the script editor URL).
        *   Run: `clasp pull <SCRIPT_ID> --rootDir ./`
        *   This pulls the existing code, potentially overwriting local files, and creates `.clasp.json`.

3.  **Develop Locally:**
    *   Edit `.gs`/`.js` files and `appsscript.json`.
    *   Refer to the [Apps Script documentation](https://developers.google.com/apps-script).

4.  **Push Changes:**
    *   Upload local changes: `clasp push`
    *   Use `clasp push -f` to force overwrite if needed (use with caution).

5.  **Test:**
    *   Open in the online editor: `clasp open`

## Included Files

*   `.idx/dev.nix`: Configures the IDX environment (installs `node`, sets up `npm` globals, installs chosen `clasp` version).
*   `appsscript.json`: The Apps Script project manifest. **Remember to set your `timeZone`!**
*   `Code.gs`: Default script file.
*   `.claspignore`: Specifies files for `clasp` to ignore.
*   `.gitignore`: Specifies files for `git` to ignore (includes `.clasp.json`).
*   `README.md`: This file.

## Next Steps

*   Customize `appsscript.json` (scopes, libraries, add-on settings).
*   Write your Apps Script code.
*   Consider adding linting/formatting (ESLint, Prettier) via `package.json` (`npm install`).