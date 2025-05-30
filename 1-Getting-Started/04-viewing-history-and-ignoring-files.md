# 1.4: Viewing History (`git log`) & Ignoring Files (`.gitignore`)

## Introduction

So far, we've learned how to initialize a repository, check its status, stage changes, and commit them. As you make more commits, your project's history grows. It's crucial to be able to view this history to understand what changed, when, and by whom. The `git log` command is your window into this history.

Additionally, most projects have files or directories that you *don't* want Git to track. These could be compiled code, log files, editor configuration files, or operating system files. The `.gitignore` file tells Git which files and directories to intentionally ignore.

In this section, we'll explore both `git log` and `.gitignore`.

## Viewing Commit History with `git log`

The `git log` command displays committed snapshots. It lists commits in reverse chronological order (most recent first). Each commit entry typically shows:
*   The commit hash (a unique SHA-1 identifier).
*   The author's name and email.
*   The date the commit was made.
*   The commit message.

### Basic `git log`

1.  **Setup:**
    Ensure you are in your `git-learning-space` directory and have made a few commits (as per the previous section's "Try It Yourself" or examples). If not, quickly create some:
    ```bash
    echo "File 1 content" > file1.txt
    git add file1.txt
    git commit -m "Add file1.txt"
    echo "File 2 content" > file2.txt
    git add file2.txt
    git commit -m "Add file2.txt"
    echo "Updated file 1" >> file1.txt
    git add file1.txt
    git commit -m "Update file1.txt with more data"
    ```

2.  **Command:**
    ```bash
    git log
    ```

3.  **Expected Output (Example):**
    ```bash
    commit <full_hash_of_last_commit_eg_fedcba9876543210fedcba9876543210fedcba98> (HEAD -> main)
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:03:00 2024 +0000

        Update file1.txt with more data

    commit <full_hash_of_second_commit_eg_abc123def456...>
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:02:00 2024 +0000

        Add file2.txt

    commit <full_hash_of_first_commit_eg_123abc456def...>
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:01:00 2024 +0000

        Add file1.txt
    ```
    *(The commit hashes, author, and dates will be specific to your system and actions.)*
    *   You can scroll through the log using your terminal's scrolling mechanism (often arrow keys, `PageUp`/`PageDown`).
    *   Press `q` to quit the log viewer and return to the command prompt.

### Common `git log` Options

`git log` has many options to customize its output. Here are some of the most useful ones:

*   **`--oneline`**: Displays each commit on a single line, showing just the commit hash (abbreviated) and the commit message subject. Very useful for a quick overview.
    ```bash
    git log --oneline
    ```
    **Expected Output (Example):**
    ```bash
    fedcba9 (HEAD -> main) Update file1.txt with more data
    abc123d Add file2.txt
    123abc4 Add file1.txt
    ```

*   **`-p` or `--patch`**: Shows the "patch" or the actual changes (diffs) introduced by each commit.
    ```bash
    git log -p
    ```
    **Expected Output (Example - showing diff for the last commit):**
    ```bash
    commit fedcba9876543210fedcba9876543210fedcba98 (HEAD -> main)
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:03:00 2024 +0000

        Update file1.txt with more data

    diff --git a/file1.txt b/file1.txt
    index <hash_before>..<hash_after> 100644
    --- a/file1.txt
    +++ b/file1.txt
    @@ -1 +1,2 @@
    File 1 content
    +Updated file 1

    commit abc123def456...
    ... (previous commits follow) ...
    ```
    *(Press `q` to quit.)*

*   **`--stat`**: Shows some summary statistics for each commit, like which files were changed and how many lines were added/removed.
    ```bash
    git log --stat
    ```
    **Expected Output (Example):**
    ```bash
    commit fedcba9876543210fedcba9876543210fedcba98 (HEAD -> main)
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:03:00 2024 +0000

        Update file1.txt with more data

    file1.txt | 1 +
    1 file changed, 1 insertion(+)

    commit abc123def456...
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:02:00 2024 +0000

        Add file2.txt

    file2.txt | 1 +
    1 file changed, 1 insertion(+)

    ... (and so on) ...
    ```

*   **`--graph`**: Displays an ASCII art graph showing the branch and merge history alongside the commit log. Extremely useful when working with branches.
    ```bash
    git log --graph
    ```
    **Expected Output (Example - more interesting with branches):**
    ```bash
    * commit fedcba9876543210fedcba9876543210fedcba98 (HEAD -> main)
    | Author: Your Name <youremail@example.com>
    | Date:   Mon Jan 1 12:03:00 2024 +0000
    |
    |     Update file1.txt with more data
    |
    * commit abc123def456...
    | Author: Your Name <youremail@example.com>
    | Date:   Mon Jan 1 12:02:00 2024 +0000
    |
    |     Add file2.txt
    |
    * commit 123abc456def...
    Author: Your Name <youremail@example.com>
    Date:   Mon Jan 1 12:01:00 2024 +0000

        Add file1.txt
    ```

*   **Combining Options:** You can combine options for powerful views. A very popular combination is:
    ```bash
    git log --graph --decorate --all --oneline
    ```
    This gives a compact, graphical, one-line view with branch/tag names. Consider making this a Git alias! (We'll cover aliases later).

*   **Filtering History:**
    *   **`-<n>`**: Show only the last `n` commits (e.g., `git log -3`).
        ```bash
        git log -2
        ```
    *   **`--since` and `--until` (or `--after` and `--before`)**: Show commits within a specific time range.
        ```bash
        git log --since="2 days ago"
        git log --until="2023-12-25"
        git log --since="2024-01-01T00:00:00" --until="2024-01-01T12:00:00"
        ```
    *   **`--author="<pattern>"`**: Show commits by a specific author.
        ```bash
        git log --author="Your Name"
        ```
    *   **`--grep="<pattern>"`**: Show commits where the commit message matches a pattern.
        ```bash
        git log --grep="Add file"
        ```
    *   **`[<file-path>]`**: Show commits that affected a specific file or directory.
        ```bash
        git log file1.txt
        git log --oneline my_directory/
        ```

## Ignoring Files with `.gitignore`

As your project grows, you'll inevitably have files that you don't want Git to track or even show in `git status` as "Untracked files." These often include:
*   Compiled code (e.g., `.o`, `.class`, `.exe` files)
*   Build artifacts (e.g., `dist/`, `build/` directories)
*   Log files (e.g., `*.log`)
*   Dependencies downloaded by package managers (e.g., `node_modules/`, `vendor/`)
*   IDE or editor-specific configuration files (e.g., `.idea/`, `.vscode/`, `*.swp`)
*   Operating system files (e.g., `.DS_Store`, `Thumbs.db`)

A `.gitignore` file is a plain text file where each line specifies a pattern for files or directories that Git should ignore.

### How `.gitignore` Works

*   It's a plain text file named exactly `.gitignore` (note the leading dot).
*   You typically place it in the root directory of your repository. You can also have `.gitignore` files in subdirectories, which apply to that directory and its children.
*   Patterns are matched relative to the location of the `.gitignore` file.
*   Blank lines or lines starting with `#` are ignored (used for comments).
*   **Important:** `.gitignore` only prevents *untracked* files from being tracked. If a file is already tracked by Git (i.e., it has been `git add`ed and `git commit`ted), adding it to `.gitignore` will **not** make Git ignore changes to it. You would need to first remove it from Git's tracking (using `git rm --cached <file>`) and then commit this removal.

### `.gitignore` Syntax (Common Patterns)

*   **Specific file name:**
    `debug.log` (ignores `debug.log` in the same directory as `.gitignore`)

*   **Directory:**
    `build/` (ignores the `build` directory and everything in it)

*   **Wildcards:**
    *   `*` matches zero or more characters (except `/`).
    *   `?` matches any single character (except `/`).
    *   `[abc]` matches any one character in the set (a, b, or c).
    *   `[0-9]` matches any digit.
    *   Example: `*.log` (ignores all files ending with `.log`)
    *   Example: `temp*` (ignores all files starting with `temp`)

*   **Negation:**
    An optional prefix `!` which negates the pattern; any matching file excluded by a previous pattern will become included again.
    Example:
    ```
    *.log
    !important.log
    ```
    (This ignores all `.log` files *except* `important.log`)

*   **Leading Slash for Root:**
    If a pattern starts with `/`, it only matches files/directories in the root of the repository (if `.gitignore` is in the root) or relative to the `.gitignore` file's location.
    Example: `/TODO.txt` (ignores `TODO.txt` only at the root level, not in subdirectories)

*   **Trailing Slash for Directories:**
    A trailing `/` specifies that the pattern is for a directory.
    Example: `logs/` (Git will treat this as matching a directory named `logs` and its contents)

### Example: Creating and Using a `.gitignore` File

1.  **Check Status (Before):**
    In your `git-learning-space` repository, create some files you might want to ignore:
    ```bash
    echo "Some sensitive data or temporary log" > app.log
    mkdir temp_files
    echo "A temporary file" > temp_files/temp.tmp
    ```
    Now check the status:
    ```bash
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            app.log
            temp_files/

    nothing added to commit but untracked files present (use "git add" to track)
    ```
    *(You'll see `app.log` and the `temp_files/` directory listed as untracked.)*

2.  **Create `.gitignore`:**
    In the root of your `git-learning-space` repository, create a file named `.gitignore` with the following content:
    ```bash
    # Log files
    *.log

    # Temporary files directory
    temp_files/

    # OS generated files
    .DS_Store
    Thumbs.db

    # IDE specific files
    .vscode/
    .idea/
    ```

3.  **Check Status (After):**
    ```bash
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            .gitignore

    nothing added to commit but untracked files present (use "git add" to track)
    ```
    *   Notice that `app.log` and `temp_files/` are no longer listed as untracked!
    *   The `.gitignore` file itself is now listed as an untracked file. This is expected, as you *should* commit your `.gitignore` file so that these ignore rules are shared with collaborators and apply to everyone working on the project.

4.  **Add and Commit `.gitignore`:**
    ```bash
    git add .gitignore
    git commit -m "Add .gitignore to exclude logs and temp files"
    ```

### Global `.gitignore`

You can also create a global `.gitignore` file for your user account that applies to all your Git repositories. This is useful for ignoring editor-specific files (like `.swp` for Vim or `.DS_Store` for macOS) that you never want to commit in any project.

1.  Create a file, e.g., `~/.gitignore_global` (on Linux/macOS) or in your user directory on Windows.
2.  Add patterns to this file.
3.  Tell Git where to find this global ignore file:
    ```bash
    git config --global core.excludesfile ~/.gitignore_global
    ```

GitHub maintains a comprehensive collection of useful `.gitignore` templates for various languages and frameworks: [https://github.com/github/gitignore](https://github.com/github/gitignore). This is a great resource!

### Bonus: Utility Script for Pretty Log

To make viewing a nicely formatted log easier, especially before you set up aliases, we've provided a couple of simple utility scripts. These scripts simply execute the `git log --graph --decorate --all --oneline` command for you.

*   **For Linux/macOS users:** [`show-pretty-log.sh`](./../1-Getting-Started/utility-scripts/show-pretty-log.sh)
*   **For Windows PowerShell users:** [`show-pretty-log.ps1`](./../../utility-scripts/show-pretty-log.ps1)

**How to use them:**
1.  Download the appropriate script into a `utility-scripts` directory at the root of your `learn-git-complete` tutorial project.
2.  Make it executable (for `.sh`):
    ```bash
    chmod +x path/to/your/learn-git-complete/utility-scripts/show-pretty-log.sh
    ```
3.  Navigate your terminal into any Git repository (like your `git-learning-space`).
4.  Run the script:
    *   Linux/macOS:
        ```bash
        ./show-pretty-log.sh
        ```
        *(Adjust path if your script is elsewhere relative to your repo)*
    *   Windows PowerShell:
        (You might need to adjust PowerShell's execution policy: `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force`)
        ```bash
        .\show-pretty-log.ps1
        ```
        *(Adjust path if your script is elsewhere relative to your repo)*

This is just a demonstration. The real power comes when you create a Git alias for such a command, which we'll cover in a later module.

## "Try It Yourself"

1.  **Explore `git log`:**
    *   In your `git-learning-space`, run `git log` and explore its output.
    *   Try `git log --oneline --graph --decorate --all`.
    *   Pick a specific file you've committed (e.g., `file1.txt`) and run `git log file1.txt`.
    *   Try `git log -p -1` to see the patch for the very last commit.

2.  **Practice with `.gitignore`:**
    *   Create a directory named `dist/` in your `git-learning-space`.
    *   Create a file inside it: `dist/bundle.js`.
    *   Run `git status`. You'll see `dist/` as untracked.
    *   Add `dist/` to your `.gitignore` file.
    *   Run `git status` again. `dist/` should now be ignored.
    *   Remember to `git add .gitignore` and `git commit -m "Update .gitignore to exclude dist directory"`.

## Summary / Key Takeaways

*   `git log` is used to view the commit history of your repository.
*   Common options like `--oneline`, `--graph`, `-p`, and `--stat` help customize the log output.
*   You can filter `git log` output by number of commits, date, author, message content, or file path.
*   A `.gitignore` file specifies intentionally untracked files that Git should ignore.
*   Patterns in `.gitignore` can include specific filenames, directories, wildcards, and negations.
*   The `.gitignore` file itself should be committed to the repository.
*   A global `.gitignore` can be configured for user-specific ignores across all repositories.
