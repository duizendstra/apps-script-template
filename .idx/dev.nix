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
    # DO NOT MANUALLY SET PATH HERE - This caused the conflict.
    # The shell environment should pick up $HOME/.npm-global/bin if NPM_CONFIG_PREFIX is set.
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
        install-clasp = ''
          echo "Setting up clasp..."
          # Ensure the target directory exists before installing
          mkdir -p "$HOME/.npm-global/bin"
          # Temporarily add the target bin to the PATH for this script's execution context
          export PATH="$HOME/.npm-global/bin:$PATH"

          if [ "$IDX_PARAM_USEALPHACLASP" = "true" ]; then
            echo "Installing @google/clasp@alpha..."
            # Use --prefix for clarity, although NPM_CONFIG_PREFIX should handle it
            npm install -g --prefix "$HOME/.npm-global" @google/clasp@alpha
          else
            echo "Installing latest stable @google/clasp..."
            npm install -g --prefix "$HOME/.npm-global" @google/clasp
          fi

          echo "clasp installation complete. Verifying..."
          # Check if the binary exists where expected
          if [ -f "$HOME/.npm-global/bin/clasp" ]; then
            echo "clasp executable found at $HOME/.npm-global/bin/clasp"
            # Attempt to run clasp using the temporarily modified PATH
            clasp --version
          else
            echo "ERROR: clasp executable not found in $HOME/.npm-global/bin after install."
            echo "Check npm output above for errors."
          fi

          echo "------"
          echo "Template created. Please see README.md for next steps."
          code README.md # Open README after setup
        '';
      };

      # Runs every time the workspace starts
      onStart = {
        # You could add path verification here if needed for debugging later:
        # verify-clasp = "echo 'Checking for clasp in onStart:' && which clasp && clasp --version || echo 'clasp not found in onStart PATH'"
      };
    };
  };
}