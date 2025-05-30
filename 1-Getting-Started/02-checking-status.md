# 1.2: Checking Status (`git status`)

## Introduction

After initializing a Git repository with `git init`, or at any point while working on your project, you'll want to know the current state of your files. Are there new files Git isn't tracking? Have you modified existing files? Are there changes ready to be committed?

The `git status` command is your primary tool for answering these questions. It shows you the status of the **working directory** and the **staging area (index)**.

## Why `git status`?

*   **Provides Clarity:** Tells you which files have been modified, which are new (untracked), and which are staged for the next commit.
*   **Guides Your Next Steps:** The output often suggests the next Git commands you might want to use (e.g., `git add`, `git commit`, `git restore`).
*   **Prevents Mistakes:** Helps you ensure you're committing only the changes you intend to.
*   **Essential for Workflow:** You'll likely run `git status` more frequently than almost any other Git command.

## Syntax

The basic syntax is very simple:

```bash
git status
```

There are various options to modify the output, but the basic command is usually sufficient. A common and useful option for a more concise output is:

```bash
git status -s
```

Or:

```bash
git status -sb
```

These short forms also show branch tracking information, which we'll cover later.

## Understanding the Output

The output of `git status` can vary depending on the state of your repository. Let's explore common scenarios.

**Scenario 1: A Clean Working Directory**

After you've just initialized a repository or just made a commit and haven't changed anything:

1.  **Setup:**
    Ensure you are in your `git-learning-space` directory (or any initialized Git repository).
    If you just ran `git init`, your directory is clean but has no commits yet.

2.  **Command:**
    ```bash
    git status
    ```

3.  **Expected Output (No Commits Yet):**
    ```bash
    On branch main

    No commits yet

    nothing to commit (create/copy files and use "git add" to track)
    ```

4.  **Expected Output (After at least one commit, and no changes):**
    If you had already made a commit and then made no further changes:
    ```bash
    On branch main
    Your branch is up to date with 'origin/main'.

    nothing to commit, working tree clean
    ```

    *   **`On branch <branch-name>`:** Tells you which branch you are currently on (e.g., `main` or `master`).
    *   **`Your branch is up to date with 'origin/<branch-name>'.`:** (If you have a remote and are synced) Indicates your local branch is synchronized with the remote tracking branch. We'll cover remotes later. If no remote is configured, this line might be absent or different.
    *   **`nothing to commit, working tree clean`:** This is the key message. It means there are no modified tracked files and no new untracked files in your working directory, and the staging area is empty.

**Scenario 2: Untracked Files**

When you add new files to your project directory that Git doesn't yet know about:

1.  **Setup:**
    In your `git-learning-space` directory, create a new file.
    For example, on Linux/macOS:
    ```bash
    touch newfile.txt
    ```
    On Windows (Command Prompt):
    ```bash
    echo. > newfile.txt
    ```
    Or Windows (PowerShell):
    ```bash
    New-Item -ItemType File -Name newfile.txt
    ```

2.  **Command:**
    ```bash
    git status
    ```

3.  **Expected Output:**
    ```
    On branch main
    No commits yet

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            newfile.txt

    nothing added to commit but untracked files present (use "git add" to track)
    ```

    *   **`Untracked files:`:** This section lists files that are in your working directory but have not yet been added to Git's tracking (i.e., never been `git add`ed or committed).
    *   **`(use "git add <file>..." to include in what will be committed)`:** Git helpfully suggests the next command to start tracking these files.

**Scenario 3: Changes Not Staged for Commit (Modified Tracked Files)**

When you modify a file that Git is already tracking (i.e., a file that has been committed before):

1.  **Setup:**
    *   First, let's create a file, add it, and commit it so Git tracks it.
        ```bash
        # Assuming you are in git-learning-space
        echo "Initial content" > myfile.txt
        git add myfile.txt
        git commit -m "Add myfile.txt"
        ```
    *   Now, modify `myfile.txt`. For example, add a new line:
        ```bash
        echo "Some new content" >> myfile.txt
        ```
        *(On Windows Command Prompt, you might use `echo Some new content >> myfile.txt`)*

2.  **Command:**
    ```bash
    git status
    ```

3.  **Expected Output:**
    ```bash
    On branch main
    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   myfile.txt

    no changes added to commit (use "git add" and/or "git commit -a")
    ```

    *   **`Changes not staged for commit:`:** This section lists tracked files that have been modified in your working directory but whose changes have not yet been put into the staging area.
    *   **`(use "git add <file>..." to update what will be committed)`:** Suggests using `git add` to stage these modifications.
    *   **`(use "git restore <file>..." to discard changes in working directory)`:** Suggests how to revert the file back to its last committed state. (Be careful with `git restore` as it can discard work!)
    *   **`no changes added to commit (use "git add" and/or "git commit -a")`:** Reinforces that nothing is currently in the staging area.

**Scenario 4: Changes Staged for Commit**

When you've used `git add` to put changes into the staging area:

1.  **Setup:**
    *   Continuing from Scenario 3, `myfile.txt` is modified. Now, let's stage it.
        ```bash
        git add myfile.txt
        ```

2.  **Command:**
    ```bash
    git status
    ```

3.  **Expected Output:**
    ```bash
    On branch main
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            modified:   myfile.txt
    ```

    *   **`Changes to be committed:`:** This is the crucial section. It lists all changes that are currently in the staging area and will be included in the next commit.
    *   **`(use "git restore --staged <file>..." to unstage)`:** Git tells you how to remove a file from the staging area if you added it by mistake (without losing the changes in your working directory).

**Scenario 5: Mixed State (Staged, Modified but not Staged, Untracked)**

A more complex but common scenario:

1.  **Setup:**
    *   Ensure `myfile.txt` is staged (from Scenario 4).
    *   Modify `myfile.txt` *again* after staging it.
        ```bash
        echo "Even more content" >> myfile.txt
        ```
    *   Create a new untracked file:
        ```bash
        echo "This is another file" > anotherfile.log
        ```

2.  **Command:**
    ```bash
    git status
    ```

3.  **Expected Output:**
    ```bash
    On branch main
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            modified:   myfile.txt

    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   myfile.txt

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            anotherfile.log
    ```

    This output clearly distinguishes:
    *   Changes already staged for commit (`modified: myfile.txt`).
    *   Changes made to tracked files *after* they were staged (`modified: myfile.txt` under "Changes not staged for commit"). This means `myfile.txt` has one version in the staging area and a newer version in the working directory.
    *   New untracked files (`anotherfile.log`).

## "Try It Yourself"

In your `git-learning-space` repository:
1.  Run `git status`.
2.  Create a new file named `README.md`.
3.  Run `git status` again. Note the "Untracked files" section.
4.  Add some text to `README.md`.
5.  Run `git status` again. (It will still be untracked, just to reinforce).
6.  Now, stage `README.md` using `git add README.md`.
7.  Run `git status`. Note the "Changes to be committed" section.
8.  Modify `README.md` again by adding more text.
9.  Run `git status`. Observe how `README.md` now appears in *both* "Changes to be committed" (for the previously staged version) AND "Changes not staged for commit" (for the newest modifications).

Experiment by creating, modifying, and staging files to get a feel for how `git status` reflects these actions.

## Summary / Key Takeaways

*   `git status` is your go-to command to understand the current state of your working directory and staging area.
*   It shows untracked files, modified tracked files (not yet staged), and changes staged for commit.
*   The output is very informative and often suggests the next commands to use.
*   Get into the habit of running `git status` frequently!

---
