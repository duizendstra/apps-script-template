# IDX environment configuration for Google Apps Script Development using clasp
{ pkgs, ... }: {
  channel = "stable-24.11"; # Base channel, Node.js comes from here

  packages = [
    pkgs.google-clasp
    pkgs.go-task
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
        # Guide the user on the next step
        setup-reminder = "echo 'Workspace created. Remember to run \"clasp login\". See README.md for details.' && code README.md";
      };

      # Runs every time the workspace starts
      onStart = { };
    };
  };
}
