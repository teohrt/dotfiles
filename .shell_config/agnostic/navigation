alias mv="mv -v"
alias rm="rm -i -v"
alias cp="cp -v"
alias ls="eza -Alh --icons -t modified --group-directories-first"
alias grep="grep --ignore-case --color --line-number"
alias mkdir="mkdir -pv "
alias x="exit"
alias o="open ."
alias ..="cd ..; clear; ls"
alias ...="cd ../..; clear; ls"
alias ~="cd ~; clear; ls"
alias Downloads="cd ~/Downloads; clear; ls"
alias Documents="cd ~/Documents; clear; ls"
alias Dev="cd ~/Dev; clear; ls"

fd() { # Fuzzy match directory navigation
  local dir
  dir=$(find "${1:-.}" -type d 2> /dev/null | fzf +m)
  cd "$dir" || return
}

fhistory() { # Fuzzy match shell history search and evaluation
  local cmd
  cmd=$(history | cut -c 8- | fzf)
  echo "$cmd"
  eval "$cmd"
}
