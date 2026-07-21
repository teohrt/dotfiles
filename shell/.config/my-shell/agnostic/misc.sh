# Direnv hook - shell-aware
if command -v direnv &>/dev/null; then
    if [ -n "$ZSH_VERSION" ]; then
        eval "$(direnv hook zsh)"
    else
        eval "$(direnv hook bash)"
    fi
else
    echo "Warning: direnv not found on PATH" >&2
fi

# Shell Personality
__build_ps1() {
    local dir_section="" env_section="" git_section=""

    # Detect active dev environment
    local env_name=""
    if [ -n "$IN_NIX_SHELL" ]; then # nix develop / nix-shell
        env_name="${name:-nix}"
    elif [ -n "$DIRENV_DIR" ]; then # direnv activated
        env_name="$(basename "${DIRENV_DIR#-}")" # strip leading "-" added by direnv
    fi

    local git
    git="$(__git_ps1 " %s")"

    # Zsh: %F{color}...%f for color, %B...%b for bold, %1/ for basename
    # Bash: \[...\] wraps non-printing chars, \e[...m for color, ${PWD##*/} for basename
    if [ -n "$ZSH_VERSION" ]; then # zsh
        dir_section="%F{cyan} %1/%f"
        [ -n "$env_name" ] && env_section=" %F{222} ${env_name}%f"
        [ -n "$git" ] && git_section=" %F{green}%B${git}%b%f"
    else # bash
        dir_section="\[\e[0;36m\] ${PWD##*/}\[\e[m\]"
        [ -n "$env_name" ] && env_section=" \[\e[38;5;222m\] ${env_name}\[\e[m\]"
        [ -n "$git" ] && git_section=" \[\e[1;32m\]${git}\[\e[m\]"
    fi

    PS1="╭─ ${dir_section}${env_section}${git_section}
╰─⟫ "
}
if [ -n "$ZSH_VERSION" ]; then
    setopt PROMPT_SUBST
    precmd_functions+=(__build_ps1)
else
    PROMPT_COMMAND="__build_ps1${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EZA_COLORS="xx=37" # white punctuation (symlink arrows, etc.)

# Gum
export GUM_INPUT_CURSOR_FOREGROUND="117"
export GUM_INPUT_PLACEHOLDER_FOREGROUND="250"
export GUM_INPUT_HEADER_FOREGROUND="250"
export GUM_WRITE_CURSOR_FOREGROUND="117"
export GUM_WRITE_PLACEHOLDER_FOREGROUND="250"
export GUM_WRITE_HEADER_FOREGROUND="250"
export GUM_FILTER_INDICATOR_FOREGROUND="117"
export GUM_FILTER_SELECTED_PREFIX_FOREGROUND="117"
export GUM_FILTER_MATCH_FOREGROUND="117"
export GUM_FILTER_PLACEHOLDER_FOREGROUND="250"
export GUM_CONFIRM_PROMPT_FOREGROUND="117"
export GUM_CONFIRM_SELECTED_FOREGROUND="230"
export GUM_CONFIRM_SELECTED_BACKGROUND="117"
export GUM_INPUT_SHOW_HELP="false"
export GUM_WRITE_SHOW_HELP="false"
export GUM_FILTER_SHOW_HELP="false"
export GUM_CONFIRM_SHOW_HELP="false"

# Meta
alias ezsh="code ~/.zshrc"
alias rzsh="source ~/.zshrc"

# Replaces fzf grep with ripgrep when STDIN pipe isn't provided - makes fzf faster
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-require-git --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--wrap'

alias c.="code ."
alias c="clear"
alias l="clear; ls"
alias ninja="chmod 700 "
alias sneak="chmod 600 "
alias epg="printenv | grep "
alias path='echo -e ${PATH//:/\\n}'
alias m="make"
alias big10="du -a -h ./ | sort -h -r | head -n 10" # show 10 largest files/dirs in current directory

fkill () { # Fuzzy matching process murder
  local process pid
  process=$(ps -ef | sed 1d | gum filter --no-limit)
  if [ "$process" != "" ] ; then
    pid=$(echo "$process" | awk '{print $2}')
    echo "$pid" | xargs kill -"${1:-9}"
    gum log --level info "$process"
  fi
}

killport () { # Kill process(es) on a given port
  local signal=TERM
  if [ "$1" = "-f" ]; then
    signal=KILL
    shift
  fi

  local port=$1
  if [ -z "$port" ]; then
    gum log --level error "Usage: killport [-f] <port>"
    return 1
  fi
  if ! [ "$port" -eq "$port" ] 2>/dev/null; then
    gum log --level error "'$port' is not a valid port number"
    return 1
  fi

  local pids
  pids=$(lsof -i :"$port" -t 2>/dev/null | sort -u)
  if [ -z "$pids" ]; then
    gum log --level info "No process found on port $port."
    return 0
  fi

  echo ""
  printf "  %-8s %-16s %s\n" "PID" "COMMAND" "USER"
  while read -r p; do
    printf "  %-8s %-16s %s\n" \
      "$p" \
      "$(ps -p "$p" -o comm= 2>/dev/null)" \
      "$(ps -p "$p" -o user= 2>/dev/null)"
  done <<< "$pids"
  echo ""

  local count
  count=$(echo "$pids" | wc -l | tr -d ' ')
  if gum confirm "Kill $count process(es) on port $port?"; then
    echo "$pids" | xargs kill -"$signal" 2>/dev/null
    gum log --level info "Killed $count process(es) on port $port."
  else
    gum log --level warn "Aborted."
  fi
}

emoji () { # Fuzzy match emoji printing
  local emojis selected_emoji
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo "$emojis" | gum filter)
  echo "$selected_emoji"
}
