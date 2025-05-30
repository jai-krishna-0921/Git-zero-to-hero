#!/bin/bash

# install-git-macos.sh
# A script to install Git on macOS using Homebrew.
# If Homebrew is not installed, it will attempt to install it.

echo "Attempting to install Git on macOS..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Git is already installed
if command_exists git; then
    echo "Git is already installed."
    git --version
    exit 0
fi

# Check for Homebrew and install if not present
if ! command_exists brew; then
    echo "Homebrew not found. Attempting to install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! command_exists brew; then
        echo "Homebrew installation failed. Please install Homebrew manually from https://brew.sh/ and then run 'brew install git'."
        exit 1
    fi
    echo "Homebrew installed successfully."
    # For Apple Silicon Macs, Homebrew might not be in PATH immediately.
    # Adding a common Homebrew path. This might need adjustment for Intel Macs if shell isn't configured.
    if [[ "$(uname -m)" == "arm64" ]]; then
      export PATH="/opt/homebrew/bin:$PATH"
    fi
fi

# Install Git using Homebrew
echo "Installing Git using Homebrew..."
brew install git

# Verify installation
if command_exists git; then
    echo "Git installation successful!"
    git --version
    echo ""
    echo "-------------------------------------------------------------------------"
    echo "IMPORTANT: Git is installed, but you still need to configure it."
    echo "Please run the following commands, replacing with your information:"
    echo '  git config --global user.name "Your Name"'
    echo '  git config --global user.email "youremail@example.com"'
    echo ""
    echo "Optionally, set your default editor and default branch name:"
    echo '  git config --global core.editor "code --wait"  # Example for VS Code'
    echo '  git config --global init.defaultBranch main'
    echo "-------------------------------------------------------------------------"
else
    echo "Git installation failed via Homebrew. Please check for errors or try manual installation."
    exit 1
fi

exit 0