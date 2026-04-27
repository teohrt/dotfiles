# dotfiles
![prompt](prompt.png)

Welcome to my humble abode.

## Setup

1. Clone this repository anywhere:
   ```bash
   git clone <repo-url> ~/Dev/other/dotfiles
   cd ~/Dev/other/dotfiles
   ```

2. Stow the dotfiles into your home directory:
   ```bash
   make stow
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc   # or: rzsh
   ```

To remove symlinks: `make unstow`

## How It Works

The `load_config.sh` script automatically:
- Detects your operating system (Linux, macOS, etc.)
- Loads all configs from `.shell_config/agnostic/` (OS-independent)
- Loads OS-specific configs from `.shell_config/{os}/` (e.g., `.shell_config/linux/` or `.shell_config/mac/`)

## Adding New Configs

- **OS-agnostic configs**: Add files to `.shell_config/agnostic/`
- **OS-specific configs**: Add files to `.shell_config/linux/` or `.shell_config/mac/`

All files in these directories will be automatically sourced when your shell starts.

## Structure

```
dotfiles/
├── .shell_config/
│   ├── agnostic/
│   │   ├── git            # Git aliases
│   │   ├── languages      # Language-specific setup (nvm, cargo, etc.)
│   │   ├── misc           # PS1 prompt, general aliases, fzf config
│   │   ├── navigation     # Directory navigation aliases
│   │   └── zsh            # History, RPROMPT, command duration tracking
│   ├── linux/
│   │   └── misc           # direnv, git-prompt.sh, Linux aliases
│   └── mac/
│       └── misc
├── load_config.sh         # Main loader script (detects OS and shell)
├── .zshrc                 # Entry point, sources load_config.sh
└── README.md
```

## NixOS Integration

Zsh plugins (autosuggestions, syntax-highlighting) are configured in the NixOS config, not here. See `programs.zsh` in your NixOS configuration.

This repo only manages shell config files via stow; plugin installation is handled by NixOS.

## Legacy Bash Support

Bash configs (`.bashrc`, `.bash_profile`) exist but are unmaintained. The core `load_config.sh` script works with both shells, so basic functionality remains intact.
