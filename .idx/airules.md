# .idx/airules.md

# Configuration file for Project IDX AI assistance.

# Provides context and rules for this Google Apps Script (GAS) / Clasp project.

# Based on: https://developers.google.com/idx/guides/airules

# --- GENERATE: Define files included in codebase context ---

GENERATE:
include: # Core application code - gas/**/\*.js - gas/**/_.html - gas/appsscript.json # Project documentation and config - README.md # Include root README (THE PRIMARY DOC) # Scripts and development environment - .idx/dev.nix # Include Nix config for env context - .vscode/settings.json # Include VSCode settings for editor context # Root level configuration if any - .gitignore - .claspignore # If using this file - Taskfile.yaml # Include Taskfile # - package.json # Uncomment if using npm for local dev dependencies # - tsconfig.json # Uncomment if using TypeScript locally before transpiling
exclude: - .git/** - node_modules/** # Exclude build dependencies - .clasp.json # CRITICAL: Contains sensitive auth tokens # gas/config.js # CRITICAL: Excluded via .gitignore, ensure it's listed there if not here - .idx/** # Exclude AI rules itself and other IDX dynamic config # - .vscode/** # Decide if you want to exclude all VSCode or just specific state - _.log # gas/scratchpad.js # Exclude scratchpad unless needed for context - ai_context.txt # Exclude the generated context file itself

# --- CONTEXT: High-level information about the project ---

CONTEXT:

- project_description: |
  A Google Apps Script (GAS) web application developed using modern JavaScript (V8 runtime) and managed locally with the Clasp CLI tool. The project, with code primarily located in `gas/`, implements a Lunch Ordering system. It interacts with Google Workspace services (Calendar, Sheets, Groups, Email) via dedicated manager modules created using a Factory Function pattern. A simple user interface (`gas/index.html`) allows manual triggering of core processes for testing. Development primarily occurs in Project IDX, utilizing Nix for environment setup.
- tech_stack: |
  - Google Apps Script (Server-side JavaScript, V8 Runtime, Global Scope)
  - Client-side HTML, CSS, JavaScript (`gas/index.html`)
  - Google Workspace APIs: CalendarApp, SpreadsheetApp, GroupsApp, MailApp, AdminDirectory (via Advanced Service), Utilities, PropertiesService, CacheService, etc.
  - Clasp (Command Line Tool for GAS development)
  - Git (Version Control)
  - Project IDX (Development Environment)
  - Nix (Optional, for defining dev environment tools like clasp, go-task via `.idx/dev.nix`)
  - JSON (GAS Manifest `appsscript.json`, data transfer)
  - Taskfile (Task Runner, currently for `ai` context generation)
- architecture_overview: |
  - **Root Directory:**
    - `README.md`: **Primary source for setup, configuration, development workflow, project overview, features/goals, and manual testing procedures.**
    - `.gitignore`: Specifies files/directories for Git to ignore (e.g., `.clasp.json`, `gas/config.js`).
    - `.claspignore`: (Optional) Specifies files/directories for Clasp to ignore during push (should be present in root).
    - `Taskfile.yaml`: Defines automated tasks (e.g., `ai` context generation, `dev:branch`).
    - `.idx/`: IDX specific configuration.
      - `airules.md`: This file, guiding AI interaction.
      - `dev.nix`: Nix configuration for the development environment (installs clasp, go-task).
    - `.vscode/`: (Optional) VS Code editor settings.
  - **`gas/`:** Contains all source code pushed to Google Apps Script (this is the `rootDir` for clasp). All `.js` files within this directory share a single global scope.
    - `appsscript.json`: The GAS project manifest. Defines permissions (OAuth scopes), libraries, web app settings, runtime version, etc. **Crucial configuration file.**
    - `index.html`: The primary HTML file for the web application's user interface/test harness.
    - `webapp.js`: Main server-side script handling web app requests (`doGet`, `handleUIAction`).
    - `config.js`: **(Manual Creation Required in `gas/`, Gitignored)** Contains crucial runtime configuration (group emails, folder IDs, timings, API keys if any). **AI will not see the content of this file.**
    - `scratchpad.js`: (Optional/Ignored) Temporary file for testing snippets.
    - `cleanup.js`: (If present) Utility script, likely for cleanup tasks.
    - **`managers/`:** Directory containing modular server-side JavaScript (`.js`) files, each responsible for interacting with a specific Google service or domain (e.g., `gasCalendarManager.js`, `gasEmailManager.js`, `gasEventManager.js`, `gasGroupManager.js`, `gasProcesmanager.js`, `gasSheetManager.js`). These use a Factory Function pattern and are globally available.
    - **`emailTemplates/`**: Directory containing HTML templates for emails (e.g., `reminderEmail.html`).
- key_patterns: |
  - **Client-Server Communication:** Client-side JS in `gas/index.html` calls server-side functions (in `gas/webapp.js` or managers, exposed globally) using `google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).serverFunctionName(args);`.
  - **Server-Side Logic:** Functions written in `.js` files (within `gas/`) run on Google's servers (V8 Runtime). Uses global Google service objects like `SpreadsheetApp`, `CalendarApp`, `Utilities`, `PropertiesService`, `CacheService`, `AdminDirectory`. **Code in all `.js` files shares a single global scope. No `require` or `import` is needed or used.**
  - **Modularity:** Factory Function pattern (`const managerFactory = (config) => { return { method }; };`) used for manager modules (`gas/managers/*.js`) to isolate interactions with specific Google APIs or concerns. These factory functions are globally available. **No `class` syntax is used.** Managers are instantiated by calling their globally available factory function.
  - **UI:** `gas/index.html` defines the structure for the test harness. Client-side JS handles user interactions and dynamic updates via `google.script.run`.
  - **Configuration & Manifest:** `gas/appsscript.json` is central for GAS settings. Runtime configuration (group IDs, folder IDs, specific text, etc.) is expected to be in `gas/config.js` (which is gitignored and manually created). AI must assume variables defined there (like `CONFIG.groupEmail`) are available to the managers, even though AI cannot see the file content. Refer to `README.md` for expected config values.
  - **Data Handling:** JSON is preferred for passing complex data between client and server (`JSON.stringify` on client, `JSON.parse` on server if needed) and for structuring data internally. `handleUIAction` in `webapp.js` expects a JSON string argument.
  - **Error Handling:** Server-side uses `try...catch` blocks. Client-side uses `.withFailureHandler()` in `google.script.run` calls. `console.log` and `console.error` (or `Logger.log`) used for debugging on both client and server (viewable in GAS editor logs or browser console). Admin email notifications configured in `gas/config.js` might be used. `gasErrorManager` provides standardized error throwing via its `throwError` method.
  - **Coding Standards:** Modern JavaScript (`const`/`let`, arrow functions, template literals), **No `class` syntax, no `require()`, no `module.exports`, no `import`/`export` statements.** Descriptive names, JSDoc comments (for functions, params, returns), modular factory functions.
  - **Deployment:** Uses `clasp push` to sync local code (`gas/` directory) with the online GAS editor/project. Versioning/deployments managed via GAS editor UI or `clasp deploy`.
  - **Documentation:** `README.md` is the main entry point, covering setup, features, goals, workflow, and testing procedures.
- security_notes: |
  - **`.clasp.json`:** This file is created by `clasp login` and contains sensitive OAuth credentials. It **MUST** be included in `.gitignore` and never committed. It should reside in the project root, _not_ in `gas/`.
  - **`gas/config.js`:** This file is manually created inside `gas/` and gitignored. It likely contains sensitive or environment-specific configuration (like specific group emails, folder IDs). AI should not suggest hardcoding these values elsewhere and should assume they come from this `CONFIG` object.
  - **OAuth Scopes:** Defined in `gas/appsscript.json`. Follow the principle of least privilege – only request scopes absolutely necessary for the script's functionality. Users will be prompted to authorize these scopes. Adding new scopes requires re-authorization.
  - **Secrets/API Keys:** Avoid hardcoding sensitive information (API keys, passwords, specific IDs) directly in the code (`.js`, `.html`). Use Script Properties (`PropertiesService.getScriptProperties()`) or the gitignored `gas/config.js` for storing configuration or secrets needed by the script.
  - **Web App Deployment Settings:** (`executeAs`, `access` in `gas/appsscript.json` or deployment UI): Understand the implications. `executeAs: USER_DEPLOYING` runs as the developer; `executeAs: USER_ACCESSING` runs as the user visiting the app. `access` controls who can visit (`MYSELF`, `DOMAIN`, `ANYONE`). Choose settings appropriate for the application's purpose and security requirements.
  - **Data Exposure:** Be careful not to expose sensitive data to the client-side (`gas/index.html`) unless necessary. Avoid logging sensitive information with `console.log` if logs might be accessible inappropriately.
- deployment_workflow_summary: |
  **Refer to `README.md` for detailed setup and deployment instructions.** The general workflow involves:
  1. Local Development: Edit `.js`, `.html` files within `gas/`. Create/update `gas/config.js` manually inside `gas/`.
  2. Authentication (One-time): Run `clasp login` to authorize Clasp with Google.
  3. Push Changes: Run `clasp push` (from the project root) to upload local code changes from `gas/` to the linked Google Apps Script project online, respecting `.claspignore`.
  4. Manifest Changes: If `gas/appsscript.json` is modified, `clasp push` handles it. Re-authorization by users might be needed.
  5. Testing: Test the web app via its deployment URL (see the "Manual Testing via Web App UI" section in `README.md`) or run functions directly in the GAS editor. Check logs in the GAS editor (`View > Logs` or `Executions`).
  6. Deployment/Versioning: Create new deployments or manage versions using the GAS web editor interface (`Deploy > Manage deployments`) or potentially `clasp deploy` / `clasp version`.
  7. Version Control: Use Git (`git add`, `git commit`, `git push`) to manage code history and collaborate.

# --- RULE: Define specific instructions or constraints for the AI ---

RULE:

- "**General:**"

  - " - Explain the _purpose_ and _reasoning_ behind suggested code changes (GAS JavaScript or HTML/CSS/Client JS)."
  - " - When adding/modifying core functionality or service interactions, suggest updating relevant documentation (`README.md` as appropriate)."
  - " - Focus comments in code on the _why_ (design decisions, non-obvious GAS quirks, complex logic) rather than the _what_ (unless complex) or _history_."
  - " - Acknowledge that changes pushed via `clasp push` might require refreshing the web app or creating a new deployment to take effect."
  - " - Refer to `README.md` for setup, configuration, general workflow, functional requirements, overall application goals, and manual testing procedures (see the 'Manual Testing via Web App UI' section)."

- "**Apps Script / JavaScript Specific:**"

  - " - **CRITICAL: Execution Environment:** Google Apps Script runs server-side JavaScript (V8). It does **NOT** use Node.js modules. All `.js` files within the `gas/` directory share the **same global scope**. Functions defined globally in one file are directly accessible from others without any import mechanism."
  - " - **CRITICAL: Module Pattern:** Do **NOT** use Node.js module patterns like `require()` or `module.exports`. Do **NOT** use ES6 Modules (`import`/`export`) as GAS doesn't support them directly in server-side `.js` files. There is **NO** need for any kind of import statement to access functions defined in other `.js` files within the `gas/` directory."
  - " - **CRITICAL: Object Creation (Factory Functions):** Do **NOT** use ES6 `class` syntax, `this`, or `new` keywords for creating modules or service objects. Use the **Factory Function pattern (Crockford style)**. Example: Define `const myManagerFactory = (config) => { /* setup */ return { method1(){...}, method2(){...} }; };` in one file. Instantiate it in another file by **directly calling the globally available factory function**: `const managerInstance = myManagerFactory({ dependency1: ..., logManager: Logger });`."
  - " - **CRITICAL: Accessing Managers/Functions:** Factory functions (like `gasTimeManager`, `gasErrorManager`, `gasDriveManager`) defined globally in one `.js` file (e.g., in the `gas/managers/` directory) are **already available globally** in all other `.js` files. Call them directly (e.g., `const timeMgr = gasTimeManager({logManager: Logger});`) without using `require`, `import`, or any similar mechanism."
  - " - **CRITICAL: Manager Usage (Instantiation & Method Calls):** 1. **Instantiate** managers by calling their globally available factory function, passing necessary configuration/dependencies. Example:
    \`\`\`javascript
    // At top level or inside a function needing the managers:
    const errorMgr = gasErrorManager({ logManager: Logger, logErrors: true });
    const timeMgr = gasTimeManager({ logManager: Logger, availableTime: 290000 });
    // If another manager needs these, pass the INSTANCES:
    // const driveMgr = gasDriveManager({ errorManager: errorMgr, timeManager: timeMgr });
    \`\`\` 2. **Call ONLY the specific methods defined** in the manager's source file on the created INSTANCE. Example:
    \`\`\`javascript
    timeMgr.resetStartTime(); // Correct - method exists
    if (!timeMgr.hasEnoughTime(5000)) { // Correct - method exists
    errorMgr.throwError({ message: 'Time limit exceeded', errorCode: 'TIMEOUT_01' }); // Correct - method exists
    }
    // INCORRECT - These methods DO NOT EXIST on the managers:
    // timeMgr.startTimer(); // WRONG
    // timeMgr.stopTimer(); // WRONG
    // errorMgr.logError(err); // WRONG (use throwError)
    \`\`\`"
  - " - **Global GAS Services:** Utilize the appropriate global GAS services (`DriveApp`, `SpreadsheetApp`, `CalendarApp`, `MailApp`, `Utilities`, `PropertiesService`, `CacheService`, `AdminDirectory`, etc.) directly. They are always available globally and do **NOT** need to be imported or required."
  - " - Generate idiomatic Google Apps Script code using the V8 runtime (modern JavaScript features like `const`, `let`, arrow functions, template literals, destructuring, etc., BUT AVOIDING `class`, `require`, `import`/`export`)."
  - " - Adhere to the project's Coding Standards (Modern JS, Descriptive Naming, JSDoc, Error Handling, Logging, Modularity via Factory Functions, JSON preference)."
  - " - Use `google.script.run` correctly for client-server communication, always including `.withSuccessHandler()` and `.withFailureHandler()` for robust UI feedback."
  - " - Implement `try...catch` blocks for server-side operations that might fail (especially API calls, file access). Use the instantiated error manager's `throwError` method within `catch` blocks."
  - " - Use `console.log` or `Logger.log` for server-side debugging, and `console.log`/`console.error` for client-side debugging. Can pass `Logger` as `logManager` to managers."
  - " - Respect the modular structure (`gas/webapp.js` for UI dispatch, `gas/managers/*.js` for specific service interactions, `gas/gasProcesmanager.js` for orchestration). Place new factory functions or utility functions in the appropriate file."
  - " - Assume necessary configuration variables (e.g., `CONFIG.groupEmail`, `CONFIG.maxAttendees`, `CONFIG.reportFolderId`) are defined in the manually created, gitignored `gas/config.js` file (inside `gas/`) and available globally or passed to relevant managers/functions. Do not hardcode these values."
  - " - When dealing with data transfer, use `JSON.stringify()` on the client before sending complex objects and `JSON.parse()` on the server if receiving JSON strings (though GAS often handles object passing automatically). Remember `handleUIAction` receives a JSON string."
  - " - Be mindful of GAS quotas and limitations (execution time, API calls per day, etc.). Suggest efficient patterns where applicable (e.g., batch operations for Sheets/Docs, using `timeManager`)."
  - " - Clearly distinguish between server-side code (`.js` files in `gas/`) and client-side code (within `<script>` tags or included scripts in `gas/index.html`)."
  - " - If changes might affect permissions, mention the need to check/update OAuth scopes in `gas/appsscript.json`."

- "**HTML / UI Specific:**"

  - " - Generate standard HTML5 and CSS for `gas/index.html`."
  - " - Ensure client-side JavaScript interacts correctly with the HTML DOM and uses `google.script.run` to call `handleUIAction` in `gas/webapp.js` with a JSON string payload."
  - " - If using templated HTML (`<? ... ?>`), ensure server-side data is correctly embedded in the `doGet` function in `gas/webapp.js`."

- "**Security:**"

  - " - Adhere strictly to security best practices: NEVER suggest hardcoding secrets (API keys, passwords)."
  - " - Recommend using `PropertiesService.getScriptProperties()` or the gitignored `gas/config.js` for storing configuration or secrets needed by the script. Explain their scope (per script project)."
  - " - Do NOT suggest reading or writing to `.clasp.json`."
  - " - When suggesting changes involving permissions or user data access, emphasize checking OAuth scopes in `gas/appsscript.json` and the web app's execution/access settings."
  - " - Avoid suggesting patterns that unnecessarily expose sensitive data to the client-side (`gas/index.html`)."

- "**Collaboration & Workflow:**"
  - " - Describe the goal of requested changes clearly."
  - " - If suggesting significant code changes spanning multiple files, provide the full updated files or very clear snippets for each, clearly indicating the file path (e.g., `gas/managers/gasEventManager.js`)."
  - " - If suggesting small, localized changes, provide the relevant snippet and clearly state the filename and function/context."
  - " - After suggesting code changes, recommend running `clasp push` to sync with the online project and then testing the changes (referencing the 'Manual Testing via Web App UI' section in `README.md` or the web app URL)."
  - " - Reference the documentation appropriately: `README.md` for setup/workflow, features/goals, and UI testing steps."
  - " - Reference the specific manager files (`gas/managers/gasCalendarManager.js`, etc.) when discussing interactions with those services."
