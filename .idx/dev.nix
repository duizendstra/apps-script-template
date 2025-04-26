# IDX environment configuration for Google Apps Script Development using clasp
{ pkgs, ... }: {
  # Use a stable channel. Consider "unstable" or pinning if clasp version is too old.
  channel = "stable-24.11";

  # Packages needed for clasp and general development
  packages = [
    # Node.js (LTS recommended) is required for clasp
    pkgs.nodejs

    # clasp CLI - using nodePackages for potentially newer versions
    pkgs.nodePackages."@google/clasp"

    # Git is usually included, but good practice to ensure it's available
    pkgs.gitMinimal
  ];

  # Environment variables (usually none needed specifically for clasp)
  env = {};

  # IDX specific settings
  idx = {
    # Recommended VS Code extensions
    extensions = [
      "dbaeumer.vscode-eslint" # If you plan to use ESLint
      "esbenp.prettier-vscode" # If you plan to use Prettier
      "GitHub.vscode-pull-request-github"
    ];

    # Previews are typically not used for Apps Script itself
    previews = { enable = false; };

    # Workspace lifecycle commands
    workspace = {
      # Runs once when the workspace is created
      onCreate = {
         # Recommend opening the README first
         open-readme = "echo 'Template created. Please see README.md for next steps.' && code README.md";
         # No 'npm install' needed here as clasp is installed via Nix
      };
      # Runs every time the workspace starts
      onStart = {
         # Optional: Display clasp version on start
         # check-clasp = "clasp --version";
      };
    };
  };
}
