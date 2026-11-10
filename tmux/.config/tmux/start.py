#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path

DEFAULT_SESSION_NAME = "default-session"
DEV_PATH = Path.home() / "Dev"

DEFAULT_WINDOWS = {
    "misc": DEV_PATH,
    "work": DEV_PATH / "work/hudsonts",
    "nixos": DEV_PATH / "other/nixos",
    "dotfiles": DEV_PATH / "other/dotfiles",
}


def tmux(*args):
    subprocess.run(["tmux", *args], check=True)


def get_workmux_worktrees(directory):
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
    tmux("attach", "-t", DEFAULT_SESSION_NAME)
    os.execvp("zsh", ["zsh"])


def main():
    if subprocess.run(["tmux", "has-session", "-t", DEFAULT_SESSION_NAME], capture_output=True).returncode == 0:
        attach_and_exit()

    env = {**os.environ, "WORKMUX_BACKEND": "tmux"}
    for i, (name, directory) in enumerate(DEFAULT_WINDOWS.items()):
        if i == 0:
            tmux("new-session", "-d", "-s", DEFAULT_SESSION_NAME, "-n", name, "-c", str(directory))
        else:
            tmux("new-window", "-t", DEFAULT_SESSION_NAME, "-n", name, "-c", str(directory))

        worktrees = get_workmux_worktrees(directory)
        if worktrees:
            subprocess.run(["workmux", "open", *worktrees], cwd=str(directory), env=env)

    tmux("new-window", "-t", DEFAULT_SESSION_NAME, "-n", "btop")
    tmux("send-keys", "-t", f"{DEFAULT_SESSION_NAME}:btop", "btop", "Enter")

    tmux("select-window", "-t", f"{DEFAULT_SESSION_NAME}:1")
    attach_and_exit()


if __name__ == "__main__":
    main()
