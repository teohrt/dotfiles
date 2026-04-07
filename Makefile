DOTFILES := $(shell pwd)

.PHONY: stow unstow git-profiles git-profiles-unlink all

stow:
	stow --target=$(HOME) .

unstow:
	stow --target=$(HOME) --delete .

git-profiles:
	mkdir -p $(HOME)/.config/git
	mkdir -p $(HOME)/Dev/work
	mkdir -p $(HOME)/Dev/other
	ln -sf $(DOTFILES)/git-profiles/config $(HOME)/.config/git/config
	ln -sf $(DOTFILES)/git-profiles/.gitconfig-work $(HOME)/Dev/work/.gitconfig-work
	ln -sf $(DOTFILES)/git-profiles/.gitconfig-personal $(HOME)/Dev/other/.gitconfig-personal

git-profiles-unlink:
	rm -f $(HOME)/.config/git/config
	rm -f $(HOME)/Dev/work/.gitconfig-work
	rm -f $(HOME)/Dev/other/.gitconfig-personal

all: stow git-profiles
