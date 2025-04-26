# IDX environment configuration for Google Apps Script Development using clasp
{ pkgs, ... }: {
  channel = "stable-24.11"; # Base channel, Node.js comes from here

  packages = [
    pkgs.google-clasp
    pkgs.go-task

    pkgs.nodejs
    pkgs.gitMinimal
  ];

  # Configure environment
  env = { };

  # IDX specific settings
  idx = {
    extensions = [
      "dbaeumer.vscode-eslint"
      "esbenp.prettier-vscode"
      "GitHub.vscode-pull-request-github"
    ];
    previews = { enable = false; };

    workspace = {
      onCreate = {
        # Guide the user to the SETUP file first
        setup-reminder = "echo 'Workspace created. Please follow the instructions in SETUP.md first.' && code SETUP.md";
      };

      # Runs every time the workspace starts
      onStart = { };
    };
  };
}
