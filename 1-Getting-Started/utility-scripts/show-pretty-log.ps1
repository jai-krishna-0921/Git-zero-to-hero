# show-pretty-log.ps1
# Demonstrates a common, nicely formatted 'git log' command.
# Run this script from within a Git repository.

# Check if inside a Git repository
try {
    $null = git rev-parse --is-inside-work-tree
    if (!$?) { throw } # if the command failed
}
catch {
    Write-Error "Error: Not inside a Git repository."
    Write-Host "Please cd into a Git repository and try again."
    exit 1
}

Write-Host "Displaying a common pretty log format:"
Write-Host "Command: git log --graph --decorate --all --oneline"
Write-Host "----------------------------------------------------"
git log --graph --decorate --all --oneline
Write-Host "----------------------------------------------------"
Write-Host "Tip: You can create a Git alias for this command for easier access!"
Write-Host "Example: git config --global alias.lg 'log --graph --decorate --all --oneline'"
Write-Host "Then you can just type: git lg"