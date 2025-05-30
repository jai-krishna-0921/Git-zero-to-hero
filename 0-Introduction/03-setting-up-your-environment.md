# 0.5: Setting Up Your Environment

Before you can start using Git, you need to install it on your computer and perform some initial configuration. This guide will walk you through the process for Windows, macOS, and Linux.

## Installing Git

Choose the instructions relevant to your operating system.

### Windows

1.  **Download the Git for Windows installer:**
    *   Go to the official Git website: [https://git-scm.com/download/win](https://git-scm.com/download/win)
    *   The download should start automatically. If not, click the download link for the latest version.

2.  **Run the installer:**
    *   Once downloaded, run the `.exe` file.
    *   You'll be presented with a series of screens. For most users, the default options are fine. Here are a few key screens:
        *   **Select Components:** The defaults are usually good. "Git Bash Here" and "Git GUI Here" are useful additions to the Windows Explorer context menu.
        *   **Choosing the default editor used by Git:** Vim is the default. If you're not comfortable with Vim, you can choose a more familiar editor like Nano, Notepad++, VS Code, Sublime Text, or Atom from the dropdown if they are installed. VS Code is a popular choice.
        *   **Adjusting your PATH environment:** The recommended option is usually "Git from the command line and also from 3rd-party software." This makes Git accessible from Git Bash, Command Prompt, and PowerShell.
        *   **Choosing HTTPS transport backend:** The default "Use the OpenSSL library" is generally fine.
        *   **Configuring line ending conversions:**
            *   "Checkout Windows-style, commit Unix-style line endings" (CRLF -> LF) is the recommended default for Windows users to ensure compatibility with macOS/Linux collaborators.
        *   **Configuring the terminal emulator to use with Git Bash:** MinTTY is the default and works well.
        *   **Choose the default behavior of `git pull`:** The default "Default (fast-forward or merge)" is fine for beginners.
        *   **Choose a credential helper:** "Git Credential Manager Core" is recommended as it simplifies authentication with remote repositories like GitHub.
        *   **Configuring extra options:** Enable file system caching if offered.
        *   **Configuring experimental options:** Usually, you can skip these unless you know you need them.
    *   Click "Install."

3.  **Verify installation:**
    *   Once installed, open **Git Bash** (which should be in your Start Menu) or Command Prompt/PowerShell.
    *   Type the following command and press Enter:
        ```bash
        git --version
        ```
    *   You should see output like `git version X.Y.Z.windows.A` (e.g., `git version 2.39.1.windows.1`).

### macOS

1.  **Using Homebrew (Recommended):**
    *   If you don't have Homebrew, install it first. Open Terminal (Applications > Utilities > Terminal) and paste:
        ```bash
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ```
    *   Follow the on-screen instructions.
    *   Once Homebrew is installed, install Git:
        ```bash
        brew install git
        ```

2.  **Using the official installer:**
    *   Go to [https://git-scm.com/download/mac](https://git-scm.com/download/mac).
    *   Download the installer and run it. Follow the prompts.

3.  **Using Xcode Command Line Tools:**
    *   Git might already be installed if you have Xcode or its Command Line Tools.
    *   Open Terminal and type:
        ```bash
        git --version
        ```
    *   If it's not installed, you might be prompted to install the Command Line Tools, which include Git. If so, agree to the installation.
    *   Alternatively, you can trigger the installation by running:
        ```bash
        xcode-select --install
        ```

4.  **Verify installation:**
    *   Open Terminal.
    *   Type the following command and press Enter:
        ```bash
        git --version
        ```
    *   You should see output like `git version X.Y.Z` (e.g., `git version 2.38.0`).

### Linux

Git is often pre-installed on many Linux distributions. If not, you can install it using your distribution's package manager.

1.  **Debian/Ubuntu-based distributions (e.g., Ubuntu, Mint, Debian):**
    *   Open a terminal.
    *   Update your package list:
        ```bash
        sudo apt update
        ```
    *   Install Git:
        ```bash
        sudo apt install git
        ```

2.  **Fedora/CentOS/RHEL-based distributions:**
    *   Open a terminal.
    *   For Fedora (or newer RHEL/CentOS):
        ```bash
        sudo dnf install git
        ```
    *   For older CentOS/RHEL:
        ```bash
        sudo yum install git
        ```

3.  **Arch Linux:**
    *   Open a terminal:
        ```bash
        sudo pacman -S git
        ```

4.  **Verify installation:**
    *   Open a terminal.
    *   Type the following command and press Enter:
        ```bash
        git --version
        ```
    *   You should see output like `git version X.Y.Z` (e.g., `git version 2.37.2`).

## First-Time Git Configuration

After installing Git, there are a few essential configuration settings you should set. Git uses these to identify who is making each commit. You only need to do this once per computer.

Open your terminal (Git Bash on Windows, Terminal on macOS/Linux).

1.  **Set Your User Name:**
    This name will be associated with your commits.
    ```bash
    git config --global user.name "Your Name"
    ```
    Replace `"Your Name"` with your actual name (e.g., `"John Doe"`).

2.  **Set Your Email Address:**
    This email will be associated with your commits. Use the email address you plan to use for services like GitHub.
    ```bash
    git config --global user.email "youremail@example.com"
    ```
    Replace `"youremail@example.com"` with your email address.

3.  **Set Your Default Text Editor (Optional but Recommended):**
    Git will use this editor for tasks like writing commit messages when you don't provide one on the command line. If you don't set this, Git will use your system's default editor (often Vim, which can be challenging for new users).

    *   **For VS Code:**
        ```bash
        git config --global core.editor "code --wait"
        ```
    *   **For Nano (a simple terminal editor, often pre-installed on Linux/macOS):**
        ```bash
        git config --global core.editor "nano -w"
        ```
    *   **For Sublime Text (macOS):**
        ```bash
        git config --global core.editor "subl -n -w"
        ```
    *   **For Sublime Text (Windows, assuming `subl.exe` is in your PATH):**
        ```bash
        git config --global core.editor "subl.exe -n -w"
        ```
    *   **For Notepad++ (Windows):**
        ```bash
        git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
        ```
        (Adjust the path if your Notepad++ is installed elsewhere.)

    The `--global` flag means these settings will apply to all Git repositories on your system for your user account.

4.  **Set the Default Branch Name (Recommended for modern workflows):**
    Historically, the default branch name in Git was `master`. Many projects and platforms (like GitHub) now use `main` as the default. It's good practice to configure Git to use `main` for new repositories you create locally.
    *(Requires Git version 2.28 or newer)*
    ```bash
    git config --global init.defaultBranch main
    ```

5.  **Check Your Settings:**
    To verify your configuration, you can list all global settings:
    ```bash
    git config --list --global
    ```
    Or check specific settings:
    ```bash
    git config user.name
    git config user.email
    git config core.editor
    git config init.defaultBranch
    ```
    You should see the values you just set.

## Summary / Key Takeaways

*   Git must be **installed** on your system before you can use it. Installation methods vary by OS (Windows, macOS, Linux).
*   After installation, **verify** it by running `git --version`.
*   Perform **first-time configuration** using `git config --global` to set your `user.name` and `user.email`. These are essential for identifying your commits.
*   Optionally, configure your preferred `core.editor` and `init.defaultBranch` for a better experience.

You are now ready to start using Git!

---