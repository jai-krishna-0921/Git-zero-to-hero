# 0.6: Automated Git Installation (Scripts)

While the previous section detailed manual Git installation, you might prefer using a script for a quicker setup, especially on Linux and macOS. Below are scripts that attempt to automate the installation process.

**Important Considerations Before Using Scripts:**

*   **Review the Script:** Always review any script from the internet before running it, especially if it uses `sudo` or makes system changes. Understand what it does.
*   **Permissions:** Scripts for Linux and macOS often require `sudo` (administrator) privileges to install software. You'll be prompted for your password.
*   **Configuration Still Needed:** These scripts primarily handle the *installation* of Git. You will still need to perform the **First-Time Git Configuration** (setting `user.name`, `user.email`, etc.) as described in [Section 0.5](./05-setting-up-your-environment.md#first-time-git-configuration) after the script completes.
*   **Windows Script:** The Windows PowerShell script will download and *start* the GUI installer. You will still need to click through the installer options.
*   **Best Effort:** These scripts try to cover common scenarios but might not work on every single system configuration. If a script fails, please refer back to the manual installation instructions.

## Using the Scripts

1.  **Download the appropriate script** for your operating system:
    *   Linux: [`install-git-linux.sh`](./scripts/install-git-linux.sh) 
    *   macOS: [`install-git-macos.sh`](./scripts/install-git-macos.sh)
    *   Windows: [`install-git-windows.ps1`](./scripts/install-git-windows.ps1)

2.  **Make it executable (Linux/macOS):**
    Open your terminal, navigate to the directory where you saved the script, and run:
    ```bash
    chmod +x install-git-linux.sh
    # or
    chmod +x install-git-macos.sh
    ```

3.  **Run the script:**
    *   **Linux:**
        ```bash
        ./install-git-linux.sh
        ```
    *   **macOS:**
        ```bash
        ./install-git-macos.sh
        ```
    *   **Windows (PowerShell):**
        Open PowerShell (you might need to run it as Administrator if you have execution policy restrictions).
        Navigate to the directory where you saved `install-git-windows.ps1`.
        You may first need to set the execution policy for the current session if it's restricted:
        ```powershell
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
        ```
        Then run the script:
        ```powershell
        .\install-git-windows.ps1
        ```

4.  **Follow On-Screen Prompts:** The scripts will provide output, and the Windows script will launch the GUI installer.

5.  **Configure Git:** Once the script is done and Git is installed, **DO NOT FORGET** to configure your `user.name` and `user.email` as detailed in the [First-Time Git Configuration section of the manual setup guide](./04-setting-up-your-environment.md#first-time-git-configuration).
