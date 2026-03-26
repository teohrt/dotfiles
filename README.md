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
   source ~/.bashrc
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
│   ├── agnostic/          # Configs that work on all OSes
│   │   ├── git
│   │   ├── languages
│   │   ├── misc
│   │   └── navigation
│   ├── linux/             # Linux-specific configs
│   │   └── misc
│   └── mac/               # macOS-specific configs
│       └── misc
├── load_config.sh         # Main script that loads configs based on OS
├── .bashrc                # Sourced by shell, sources load_config.sh
├── .bash_profile          # Sources .bashrc
└── README.md
```