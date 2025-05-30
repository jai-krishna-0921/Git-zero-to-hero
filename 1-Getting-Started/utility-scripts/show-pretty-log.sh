#!/bin/bash

# show-pretty-log.sh
# Demonstrates a common, nicely formatted 'git log' command.
# Run this script from within a Git repository.

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
    echo "Please cd into a Git repository and try again."
    exit 1
fi

echo "Displaying a common pretty log format:"
echo "Command: git log --graph --decorate --all --oneline"
echo "----------------------------------------------------"
git log --graph --decorate --all --oneline
echo "----------------------------------------------------"
echo "Tip: You can create a Git alias for this command for easier access!"
echo "Example: git config --global alias.lg \"log --graph --decorate --all --oneline\""
echo "Then you can just type: git lg"