# IDX environment configuration for Google Apps Script Development using clasp
{ pkgs, ... }: {
  channel = "stable-24.11"; # Base channel, Node.js comes from here

  # We only need Node.js (which includes npm) and Git directly from Nix.
  # clasp will be installed via npm in the onCreate hook based on user choice.
  packages = [
    pkgs.nodejs # Provides node and npm
    pkgs.gitMinimal
  ];

  # Configure environment for globally installed npm packages
  env = {
    # Define where npm should install global packages
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
    # Add the bin directory for global packages to the PATH
    PATH = "$HOME/.npm-global/bin:$PATH";
  };

  # IDX specific settings
  idx = {
    extensions = [
      "dbaeumer.vscode-eslint"
      "esbenp.prettier-vscode"
      "GitHub.vscode-pull-request-github"
    ];
    previews = { enable = false; };

    workspace = {
      # Runs once when the workspace is created
      onCreate = {
        # Conditionally install clasp based on the 'useAlphaClasp' template parameter.
        # Template parameters are available as IDX_PARAM_<paramName> env variables.
        install-clasp = ''
          echo "Setting up clasp..."
          if [ "$IDX_PARAM_USEALPHACLASP" = "true" ]; then
            echo "Installing @google/clasp@alpha..."
            npm install -g @google/clasp@alpha
          else
            echo "Installing latest stable @google/clasp..."
            npm install -g @google/clasp
          fi
          echo "clasp installation complete. Version:"
          clasp --version || echo "clasp command not found after install attempt." # Verify install
          echo "------"
          echo "Template created. Please see README.md for next steps."
          code README.md # Open README after setup
        '';
      };

      # Runs every time the workspace starts
      onStart = {
        # Optional: Verify clasp is still available on start
        # check-clasp = "clasp --version || echo 'clasp not found - run setup?'";
      };
    };
  };
}