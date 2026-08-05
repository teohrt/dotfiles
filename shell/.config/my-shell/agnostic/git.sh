# Facilitate gpg signing for git commits
GPG_TTY=$(tty)
export GPG_TTY

# Aliases
alias push="git push"
alias pull="git pull"
alias gs="clear; git status"
alias gl="git log"
alias ga="git add . ; git status"
alias unstage="git restore --staged ."

# Functions
pushF () {
    # git force push
  local remote branch
  remote=$(git remote)
  branch=$(git rev-parse --abbrev-ref HEAD)
  printf "%s → %s/%s\n\n%s" \
    "$branch" "$remote" "$branch" \
    "$(git log "$remote/$branch"..HEAD --oneline 2>/dev/null || echo "(new branch)")" \
    | gum style --border rounded --padding "0 1"
  echo ""
  if gum confirm --default=no "Force push?"; then
    git push --force
  else
    gum log --level warn "Aborting."
  fi
}

gc () {
  # git commit
  git commit -m "$*"
}

gchB () {
  # git checkout -B
  local branch
  branch=$(gum input --header "New branch name" --placeholder "...") || return
  git checkout -B "$branch"
}

gch () {
  # git checkout
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | gum filter) || return
  git checkout "$(echo "$branch" | sed 's/^[* ]*//' | awk '{print $1}')"
}

gbD () {
    # git branch -D
  local branches branchInfo branchName
  branches=$(git --no-pager branch -vv) &&
  branchInfo=$(echo "$branches" | gum filter) &&
  branchName=$(echo "$branchInfo" | sed 's/^[* ]*//' | awk '{print $1}')

  printf "%s\n\nLast Commit:\n%s" \
    "$branchName" \
    "$(git log -1 --format="%h - %s (%ar)" "$branchName")" \
    | gum style --border rounded --padding "0 1"
  echo ""
  if gum confirm --default=no "Delete this branch?"; then
    git branch -D "$branchName"
  else
    gum log --level warn "Aborting."
  fi
}

greset1 () {
  printf "%s\n\nCommit Message:\n%s" \
    "$(git log -1 --format="%h - %an, %ar")" \
    "$(git log -1 --format="%B")" | gum style --border rounded --padding "0 1"
  echo ""
  if gum confirm --default=no "Reset this commit?"; then
    git reset HEAD~1
  else
    gum log --level warn "Aborting."
  fi
}

stash () {
  local msg
  msg=$(gum input --placeholder "Stash name") || return
  git stash push --include-untracked -m "$msg"
}

pop () {
  local stashes selection index
  stashes=$(git stash list) || return
  if [ -z "$stashes" ]; then
    gum log --level warn "No stashes found."
    return 1
  fi
  # shellcheck disable=SC2016
  selection=$(echo "$stashes" | fzf +m --preview 'git stash show -p $(echo {} | cut -d: -f1) | delta') || return
  index=$(echo "$selection" | cut -d: -f1)
  git stash pop "$index"
}

gh () {
  local branch origin repoURL repoName repoDirectory url
  branch=$(git rev-parse --abbrev-ref HEAD)
  origin=$(git config --get remote.origin.url)
  repoURL=$(echo "$origin" | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//')
  repoURL+="/tree/$branch"
  repoName=$(echo "$origin" | sed -e'0,/\//d' -e's/.*\///' -e's/\.git$//')
  repoDirectory=$(pwd | sed "s/.*$repoName//")
  url="$repoURL$repoDirectory"
  open "$url"
}
