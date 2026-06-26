# dotfiles
![prompt](prompt.png)

Welcome to my humble abode.

## Setup

1. Clone this repository anywhere:
   ```bash
   git clone <repo-url> ~/Dev/other/dotfiles
   cd ~/Dev/other/dotfiles
   ```

2. Enter the dev shell (installs pre-commit hooks and tools):
   ```bash
   nix develop   # or let direnv handle it automatically
   ```

3. Stow everything into your home directory:
   ```bash
   make stow-all
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc   # or: rzsh
   ```

To remove symlinks: `make unstow-all`

You can also stow/unstow individual packages: `make stow-shell`, `make unstow-git`, etc.

## How It Works

The repo is organized into **stow packages** (`shell/`, `git/`, `direnv/`), each containing a file tree relative to `$HOME`. Running `make stow-<package>` symlinks that tree into your home directory.

The shell package's `load_config.sh` script automatically:
- Detects your operating system (Linux or macOS)
- Loads OS-specific configs from `my-shell/{linux,mac}/`
- Loads OS-agnostic configs from `my-shell/agnostic/`

## Adding New Configs

- **OS-agnostic**: Add `.sh` files to `shell/.config/my-shell/agnostic/`
- **OS-specific**: Add `.sh` files to `shell/.config/my-shell/linux/` or `mac/`

All files in these directories are automatically sourced when your shell starts.

## Structure

```
dotfiles/
├── shell/                          # Shell stow package
│   ├── .zshrc                      # Interactive shell entry point
│   ├── .zprofile                   # Login shell entry point
│   └── .config/my-shell/
│       ├── load_config.sh          # Main loader (detects OS, sources configs)
│       ├── agnostic/
│       │   ├── git.sh              # Git aliases and helper functions
│       │   ├── languages.sh        # Language setup (nvm, go)
│       │   ├── misc.sh             # Prompt, general aliases, fzf config
│       │   ├── navigation.sh       # Directory navigation aliases
│       │   └── zsh.sh              # Zsh-specific history and UX
│       ├── linux/
│       │   └── misc.sh             # git-prompt.sh, Linux aliases
│       └── mac/
│           └── misc.sh             # Homebrew, macOS utilities
├── git/                            # Git stow package
│   └── .config/git/
│       ├── config                  # Main git config
│       ├── work                    # Work email + SSH key (via includeIf)
│       └── personal                # Personal email + SSH key (via includeIf)
├── direnv/                         # Direnv stow package
│   └── .config/direnv/
│       └── direnv.toml
├── flake.nix                       # Dev shell with pre-commit hooks
├── Makefile                        # Stow targets
└── README.md
```

## Linting

The nix dev shell installs pre-commit hooks that run on every commit:
- **shellcheck** -- shell script linting
- **checkmake** -- Makefile linting
- **deadnix** -- unused Nix bindings
- **statix** -- Nix anti-patterns

Run manually with `pre-commit run --all-files` from inside the dev shell.

## Git Profiles

Git uses `includeIf` to load different SSH keys and emails based on repo location:
- Repos under `~/Dev/work/` use the work profile
- Repos under `~/Dev/other/` use the personal profile

Both profiles are managed by stow alongside the main git config.

## NixOS Integration

Zsh plugins (autosuggestions, syntax-highlighting) are configured in the NixOS config, not here. This repo only manages shell config files via stow; plugin installation is handled by NixOS.
