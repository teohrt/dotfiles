.PHONY: stow-shell unstow-shell stow-git unstow-git stow-direnv unstow-direnv stow-all unstow-all

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

stow-all: stow-shell stow-git stow-direnv

unstow-all: unstow-shell unstow-git unstow-direnv
