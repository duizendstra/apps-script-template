# IDX environment configuration for Google Apps Script Development using clasp
{ pkgs, ... }: {
  channel = "stable-24.11"; # Base channel, Node.js comes from here

  packages = [
    pkgs.google-clasp
  ];

  # Configure environment for globally installed npm packages
  env = { };

  # IDX specific settings
  idx = {
    extensions = [
      # "dbaeumer.vscode-eslint"
      # "esbenp.prettier-vscode"
      "GitHub.vscode-pull-request-github"
    ];
    previews = { enable = false; };

    workspace = {
      # Runs once when the workspace is created
      onCreate = { };

      # Runs every time the workspace starts
      onStart = {};
    };
  };
}
