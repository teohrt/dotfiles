alias push="git push"
alias pushF="git push --force"
alias pull="git pull"
stash () {
  local msg
  echo -n "Stash name: "
  read -r msg
  git stash push --include-untracked -m "$msg"
}
pop () {
  local stashes selection index
  stashes=$(git stash list) || return
  if [ -z "$stashes" ]; then
    echo "No stashes found."
    return 1
  fi
  selection=$(echo "$stashes" | fzf +m) || return
  index=$(echo "$selection" | cut -d: -f1)
  git stash pop "$index"
}
alias gs="clear; git status"
alias gl="git log"
alias ga="git add . ; git status"
alias gc="git commit -m "
alias gchB="git checkout -B"
alias unstage="git restore --staged ."

GPG_TTY=$(tty) # facilitate gpg signing for git commits
export GPG_TTY

gh () { # open github branch specfic directory in web browser
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

gbD () { # git branch delete with fuzzy matching
  local branches branchInfo branchName
  branches=$(git --no-pager branch -vv) &&
  branchInfo=$(echo "$branches" | fzf +m) && 
  branchName=$(echo "$branchInfo" | awk '{print $1}' | sed "s/.* //")

  echo Type \'yes\' if you want to delete "$branchName"
  read -r ans
  if [ "$ans" = 'yes' ] ; then
    git branch -D "$branchName"
  else
      echo Aborting.
  fi
}

gch () { # checkout git branch with fuzzy matching
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout "$(echo "$branch" | awk '{print $1}' | sed "s/.* //")"
}

greset1 () {
    echo Type \'yes\' if you want to reset your git history by one commit:
    read -r ans
    if [ "$ans" = 'yes' ] ; then
        git reset HEAD~1
    else
        echo Aborting.
    fi
}