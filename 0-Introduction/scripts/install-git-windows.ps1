# install-git-windows.ps1
# PowerShell script to download the latest Git for Windows installer and start it.
# Manual steps will still be required in the GUI installer.

Write-Host "Attempting to download and run the Git for Windows installer..."

# Check if Git is already installed by looking for git.exe in common paths
$gitPath = Get-Command git.exe -ErrorAction SilentlyContinue
if ($gitPath) {
    Write-Host "Git seems to be already installed at: $($gitPath.Source)"
    git --version
    Write-Host "If this is not the correct version, please uninstall it first or install manually."
    exit 0
}

$installerUrl = "https://github.com/git-for-windows/git/releases/latest" # This redirects to the latest release page
Write-Host "Finding the latest Git for Windows installer..."

try {
    # Get the latest release page content
    $latestReleasePage = Invoke-WebRequest -Uri $installerUrl -UseBasicParsing
    # Find the link to the 64-bit installer. Adjust if you need 32-bit.
    # This regex might need updates if GitHub changes their page structure.
    if ($latestReleasePage.Links.Href -match '/git-for-windows/git/releases/download/v[0-9\.]+/Git-[0-9\.]+-64-bit\.exe') {
        $downloadUrl = "https://github.com" + $Matches[0]
    } else {
        Write-Error "Could not automatically find the 64-bit Git installer EXE link on the GitHub release page."
        Write-Host "Please visit https://git-scm.com/download/win manually."
        exit 1
    }
} catch {
    Write-Error "Failed to fetch the latest release information. Error: $($_.Exception.Message)"
    Write-Host "Please visit https://git-scm.com/download/win manually."
    exit 1
}


$installerName = "Git-latest-64-bit.exe"
$downloadPath = Join-Path $env:TEMP $installerName

Write-Host "Downloading Git installer from: $downloadUrl"
Write-Host "Saving to: $downloadPath"

try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -UseBasicParsing
    Write-Host "Download complete."
} catch {
    Write-Error "Download failed. Error: $($_.Exception.Message)"
    Write-Host "Please try downloading manually from https://git-scm.com/download/win"
    exit 1
}

Write-Host "Starting Git installer... Please follow the on-screen instructions."
Start-Process -FilePath $downloadPath -Wait

# Check again if Git is installed (this time more generically)
$gitPathAfter = Get-Command git.exe -ErrorAction SilentlyContinue
if ($gitPathAfter) {
    Write-Host "Git installation process finished."
    Write-Host "Please open a new Git Bash, Command Prompt, or PowerShell window to use Git."
    Write-Host ""
    Write-Host "-------------------------------------------------------------------------"
    Write-Host "IMPORTANT: Git should now be installed. You still need to configure it."
    Write-Host "Open a new terminal (Git Bash is recommended) and run:"
    Write-Host '  git config --global user.name "Your Name"'
    Write-Host '  git config --global user.email "youremail@example.com"'
    Write-Host ""
    Write-Host "Optionally, set your default editor and default branch name:"
    Write-Host '  git config --global core.editor "code --wait"  # Example for VS Code'
    Write-Host '  git config --global init.defaultBranch main'
    Write-Host "-------------------------------------------------------------------------"
} else {
    Write-Warning "Git executable not found in PATH after installation attempt."
    Write-Warning "You might need to restart your terminal or computer, or there was an issue with the installation."
}

# Clean up the installer
Remove-Item $downloadPath -ErrorAction SilentlyContinue