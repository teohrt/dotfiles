stow:
	stow --target=$(HOME) .

unstow:
	stow --target=$(HOME) --delete .
