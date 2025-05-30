# 1.3: Staging (`git add`) and Committing (`git commit`) Changes

## Introduction

In the previous sections, we learned how to initialize a Git repository (`git init`) and check its status (`git status`). Now, we'll cover two of the most fundamental operations in Git:
1.  **Staging Changes (`git add`):** Selecting which modifications you want to include in your next "snapshot" or version of the project.
2.  **Committing Changes (`git commit`):** Saving those staged changes permanently into the repository's history.

These two commands work hand-in-hand to record the evolution of your project.

## The Three States Revisited

Remember Git's three main states for files?
1.  **Working Directory:** Your project folder where you actively modify files.
2.  **Staging Area (Index):** An intermediate area where you gather changes you want to include in your next commit. Think of it like a draft or a "cart" for your next save point.
3.  **Repository (`.git` directory):** Where Git permanently stores your committed snapshots and project history.

```
[ Working Directory ] --- git add ---> [ Staging Area (Index) ] --- git commit ---> [ .git Directory (Repository) ]
(Your project files) (Changes to be committed) (Your project's history)
```


The `git add` command moves changes from your Working Directory to the Staging Area.
The `git commit` command takes what's in the Staging Area and saves it as a new snapshot in the Repository.

## Staging Changes with `git add`

The `git add` command is used to tell Git that you want to include updates to a particular file (or set of files) in your next commit. It doesn't *commit* the changes yet; it just marks them as "ready to be committed."

### Why `git add` (The Staging Area)?

The staging area is a powerful feature because it allows you to:
*   **Craft your commits:** You can selectively stage only parts of the changes you've made. For example, if you made changes to three files but only want the changes from two of them to be part of the current logical "save point," you can `add` just those two.
*   **Review before committing:** It gives you a chance to review exactly what will go into the next commit (`git status` will show "Changes to be committed").
*   **Break down large changes:** If you've made many changes, you can stage and commit them in smaller, logical chunks, making your history easier to understand.

### `git add` Syntax

*   **Add a specific file:**
    ```bash
    git add <filename>
    ```

*   **Add multiple specific files:**
    ```bash
    git add <file1> <file2> <directory1/file3>
    ```

*   **Add all changes in the current directory and its subdirectories (for new and modified files):**
    This is a very common usage.
    ```bash
    git add .
    ```
    *(Note: `.` refers to the current directory.)*

*   **Add all changes in the entire working tree (from the root of the repository):**
    This is similar to `git add .` if you are at the root, but `git add -A` or `git add --all` will find changes everywhere.
    ```bash
    git add -A
    # or
    git add --all
    ```

*   **Add only modified and deleted files (not new untracked files):**
    ```bash
    git add -u
    # or
    git add --update
    ```
    *(This is less commonly used by beginners than `git add .` or `git add -A`)*

*   **Interactive Staging (Advanced):**
    To stage only specific parts of a file.
    ```bash
    git add -p
    # or
    git add --patch
    ```
    *(We'll cover this in more detail in an advanced section.)*

## Committing Changes with `git commit`

Once you've staged the changes you want to save using `git add`, the `git commit` command records those staged changes as a new version (a "snapshot" or "commit") in your local repository's history.

Each commit has:
*   A unique **SHA-1 hash** (identifier).
*   Information about the **author** and **committer** (name and email, taken from your Git configuration).
*   The **date and time** of the commit.
*   A **commit message** explaining the changes made.

**Writing Good Commit Messages is CRUCIAL!** A commit message should be clear, concise, and explain *why* the changes were made, not just *what* changed (the code itself shows what changed).

### `git commit` Syntax

*   **Commit with a short message directly on the command line:**
    The `-m` flag allows you to provide a message.
    ```bash
    git commit -m "Your concise commit message here"
    ```

*   **Commit and open your configured text editor to write a more detailed message:**
    If you omit `-m`, Git will open the text editor you configured (e.g., Vim, Nano, VS Code) for you to write the commit message. This is recommended for more significant changes.
    ```bash
    git commit
    ```
    In the editor:
    1.  The first line is the **subject line** (try to keep it under 50 characters).
    2.  Leave a blank line after the subject.
    3.  Then, write a more detailed **body** explaining the changes if necessary.
    4.  Lines starting with `#` are comments and will be ignored.
    5.  Save and close the editor to finalize the commit.

*   **Stage all tracked, modified files AND commit (Shortcut):**
    The `-a` flag (or `-all` but typically just `-a`) tells Git to automatically stage all files that are already tracked by Git (i.e., files that have been committed before and are now modified) and then commit them.
    **Important:** `git commit -a` will **NOT** add *new* (untracked) files. You still need to `git add` new files first.
    ```bash
    git commit -am "Your message for staged and committed tracked files"
    # or commonly seen with -m combined:
    git commit -a -m "Your message for staged and committed tracked files"
    ```

## Example Workflow: Staging and Committing

Let's walk through a typical sequence in your `git-learning-space` repository.

1.  **Check Initial Status:**
    Ensure you're in your `git-learning-space` directory.
    ```bash
    git status
    ```
    **Expected Output (if clean or just initialized):**
    ```bash
    On branch main
    No commits yet
    nothing to commit (create/copy files and use "git add" to track)
    ```

2.  **Create and Modify Files:**
    *   Create a new file `README.md`:
        ```bash
        echo "# My Project" > README.md
        ```
    *   Create another new file `app.js`:
        ```bash
        echo "console.log('Hello Git!');" > app.js
        ```
    *   Let's also assume you have an existing `myfile.txt` from previous examples. Modify it:
        ```bash
        # First ensure myfile.txt exists and is tracked (e.g., from a previous step)
        # If not, create and commit it first:
        # echo "Original line" > myfile.txt
        # git add myfile.txt
        # git commit -m "Add initial myfile.txt"

        # Now modify it:
        echo "This is a new line in myfile.txt" >> myfile.txt
        ```

3.  **Check Status Again:**
    ```status
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   myfile.txt  # Assuming myfile.txt was tracked

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            README.md
            app.js

    no changes added to commit (use "git add" and/or "git commit -a")
    ```
    *(You'll see `README.md` and `app.js` as untracked, and `myfile.txt` as modified but not staged, assuming `myfile.txt` was tracked before.)*

4.  **Stage Specific Files:**
    Let's say we want to commit the `README.md` and the changes to `myfile.txt` first, but not `app.js` yet.
    ```bash
    git add README.md myfile.txt
    ```

5.  **Check Status Before Committing:**
    It's good practice to check `git status` one last time before committing to see exactly what will be included.
    ```bash
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            new file:   README.md
            modified:   myfile.txt

    Untracked files:
    (use "git add <file>..." to include in what will be committed)
        app.js
    ```
    *(You should see `README.md` and `myfile.txt` under "Changes to be committed" and `app.js` still under "Untracked files".)*

6.  **Commit the Staged Changes:**
    ```bash
    git commit -m "Add README and update myfile"
    ```

7.  **Check Status After Commit:**
    ```bash
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            app.js

    nothing added to commit but untracked files present (use "git add" to track)
    ```
    *(Now it should only show `app.js` as untracked, and the working tree is clean regarding tracked files.)*

8.  **Stage and Commit Remaining Files:**
    Now let's add and commit `app.js`.
    ```bash
    git add app.js
    # or git add . to add all remaining untracked/modified files
    ```
    ```bash
    git commit -m "Add initial app.js script"
    ```

9.  **Final Status Check:**
    ```bash
    git status
    ```
    **Expected Output:**
    ```bash
    On branch main
    nothing to commit, working tree clean
    ```

## "Try It Yourself"

1.  In your `git-learning-space` repository:
    *   Create two new files: `index.html` and `style.css`.
    *   Add some basic HTML content to `index.html`.
    *   Add some basic CSS content to `style.css`.
2.  Run `git status` to see they are untracked.
3.  Use `git add index.html` to stage only the HTML file.
4.  Run `git status` again. Observe that `index.html` is staged, but `style.css` is still untracked.
5.  Commit the staged `index.html` with a message like "Add initial HTML structure":
    `git commit -m "Add initial HTML structure"`
6.  Run `git status`. `style.css` should still be untracked.
7.  Now, add `style.css` using `git add .` (or `git add style.css`).
8.  Commit `style.css` with an appropriate message.
9.  Modify `index.html` again.
10. Use `git commit -am "Update index.html content"` (notice the `-a` flag to automatically stage the tracked, modified file).
11. Run `git status`. Your working directory should be clean.

## Best Practices for Committing

*   **Commit Often:** Make small, frequent commits. This makes it easier to understand changes and revert them if necessary.
*   **Commit Logically Related Changes:** Each commit should represent a single logical unit of work (e.g., "Fix login bug," "Add user registration feature," "Update documentation for API endpoint X").
*   **Write Good Commit Messages:**
    *   **Subject Line:** Concise summary (e.g., 50 characters), imperative mood (e.g., "Add feature" not "Added feature" or "Adds feature").
    *   **Body (Optional):** Explain the "why" and "how" if the subject isn't enough. Separate subject from body with a blank line.
*   **Test Before Committing:** Ensure your changes work and don't break anything before committing.
*   **Don't Commit Generated Files or Dependencies:** Use a `.gitignore` file (we'll cover this soon) to tell Git to ignore files like compiled code, `node_modules`, log files, etc.

## Summary / Key Takeaways

*   The **staging area (index)** acts as an intermediary between your working directory and the repository history.
*   `git add <file>` (or `git add .`) is used to move changes from the working directory to the staging area.
*   `git commit -m "message"` (or `git commit`) records the changes currently in the staging area into the repository's history as a new snapshot.
*   `git commit -am "message"` is a shortcut to stage all *tracked modified* files and then commit. It does **not** add new untracked files.
*   Writing clear, concise, and informative commit messages is crucial for a healthy project history.
