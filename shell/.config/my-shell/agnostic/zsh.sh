# Zsh-specific configuration
[ -z "$ZSH_VERSION" ] && return

eval "$(zoxide init zsh)"

# History
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY       # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates when new one added
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_VERIFY            # Show command before executing from history

unsetopt PROMPT_SP            # Disable partial line indicator (%)

# Synchronized output: buffer prompt rendering until the line editor is ready,
# then flush in one frame to prevent the cursor trail animation.
precmd() { printf '\e[?2026h'; }
zle-line-init() { printf '\e[?2026l'; }
zle -N zle-line-init
