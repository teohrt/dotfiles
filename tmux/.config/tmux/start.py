#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path

SESSION = "default"
HOME = Path.home()

WINDOWS = [
    ("misc", HOME / "Dev"),
    ("work", HOME / "Dev/work/hudsonts"),
    ("nixos", HOME / "Dev/other/nixos"),
    ("dotfiles", HOME / "Dev/other/dotfiles"),
]


def tmux(*args):
    subprocess.run(["tmux", *args], check=True)


def tmux_quiet(*args):
    return subprocess.run(
        ["tmux", *args], capture_output=True
    ).returncode == 0


def get_worktrees(directory):
    result = subprocess.run(
        ["git", "worktree", "list", "--porcelain"],
        capture_output=True, text=True, cwd=directory,
    )
    worktrees = []
    for line in result.stdout.splitlines():
        if line.startswith("worktree ") and "__worktrees/" in line:
            worktrees.append(line.rstrip().rsplit("/", 1)[-1])
    return worktrees


def attach_and_exit():
    tmux("attach", "-t", SESSION)
    os.execvp("zsh", ["zsh"])


def main():
    if tmux_quiet("has-session", "-t", SESSION):
        attach_and_exit()

    name, directory = WINDOWS[0]
    tmux("new-session", "-d", "-s", SESSION, "-n", name, "-c", str(directory))

    for name, directory in WINDOWS[1:]:
        tmux("new-window", "-t", SESSION, "-n", name, "-c", str(directory))

    # Restore workmux worktree sessions
    env = {**os.environ, "WORKMUX_BACKEND": "tmux"}
    for _, directory in WINDOWS:
        worktrees = get_worktrees(directory)
        if worktrees:
            subprocess.run(
                ["workmux", "open", *worktrees],
                cwd=str(directory), env=env,
            )

    tmux("new-window", "-t", SESSION, "-n", "btop")
    tmux("send-keys", "-t", f"{SESSION}:btop", "btop", "Enter")

    tmux("select-window", "-t", f"{SESSION}:1")
    attach_and_exit()


if __name__ == "__main__":
    main()
