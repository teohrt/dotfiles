#!/usr/bin/env bash
SESSION="default"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux attach -t "$SESSION"
else
  tmux new-session -d -s "$SESSION" -n misc -c "$HOME/Dev"
  tmux new-window -t "$SESSION" -n work -c "$HOME/Dev/work/hudsonts"
  tmux new-window -t "$SESSION" -n nixos -c "$HOME/Dev/other/nixos"
  tmux new-window -t "$SESSION" -n dotfiles -c "$HOME/Dev/other/dotfiles"
  tmux new-window -t "$SESSION" -n btop
  tmux send-keys -t "$SESSION:btop" 'btop' Enter
  tmux select-window -t "$SESSION:1"
  tmux attach -t "$SESSION"
fi

exec zsh
