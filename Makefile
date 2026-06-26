DOTFILES := $(shell pwd)

# Mark all targets as phony so make doesn't look for matching filenames
.PHONY: stow-shell unstow-shell stow-git unstow-git stow-direnv unstow-direnv stow-git-profiles unstow-git-profiles stow-all unstow-all

# Stow/unstow individual packages (e.g. make stow-shell, make unstow-git)
# Each package is a subdirectory containing a $HOME-relative file tree
stow-shell:
	stow --target=$(HOME) shell

unstow-shell:
	stow --target=$(HOME) --delete shell

stow-git:
	stow --target=$(HOME) git

unstow-git:
	stow --target=$(HOME) --delete git

stow-direnv:
	stow --target=$(HOME) direnv

unstow-direnv:
	stow --target=$(HOME) --delete direnv

# Git profile configs use includeIf to load different SSH keys and emails
# based on repo location (~/Dev/work/ vs ~/Dev/other/). These can't be
# managed by stow because they live outside $HOME root.
stow-git-profiles:
	mkdir -p $(HOME)/Dev/work
	mkdir -p $(HOME)/Dev/other
	ln -sf $(DOTFILES)/git-profiles/.gitconfig-work $(HOME)/Dev/work/.gitconfig-work
	ln -sf $(DOTFILES)/git-profiles/.gitconfig-personal $(HOME)/Dev/other/.gitconfig-personal

unstow-git-profiles:
	rm -f $(HOME)/Dev/work/.gitconfig-work
	rm -f $(HOME)/Dev/other/.gitconfig-personal

stow-all: stow-shell stow-git stow-direnv stow-git-profiles

unstow-all: unstow-shell unstow-git unstow-direnv unstow-git-profiles
