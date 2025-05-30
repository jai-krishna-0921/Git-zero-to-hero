#!/bin/bash

# install-git-linux.sh
# A script to attempt installation of Git on common Linux distributions.
# This script requires sudo privileges to install packages.

echo "Attempting to install Git..."

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

# Detect Linux Distribution
if command_exists apt-get; then # Debian/Ubuntu based
    echo "Detected Debian/Ubuntu based system."
    sudo apt-get update
    sudo apt-get install -y git
elif command_exists dnf; then # Fedora and newer RHEL/CentOS
    echo "Detected Fedora or RHEL/CentOS (using dnf)."
    sudo dnf install -y git
elif command_exists yum; then # Older RHEL/CentOS
    echo "Detected RHEL/CentOS (using yum)."
    sudo yum install -y git
elif command_exists pacman; then # Arch Linux
    echo "Detected Arch Linux."
    sudo pacman -S --noconfirm git
elif command_exists zypper; then # openSUSE
    echo "Detected openSUSE (using zypper)."
    sudo zypper install -y git
else
    echo "Could not detect your Linux distribution's package manager."
    echo "Please install Git manually using instructions from: https://git-scm.com/download/linux"
    exit 1
fi

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
    echo "Git installation failed. Please check for errors and try manual installation."
    exit 1
fi

exit 0