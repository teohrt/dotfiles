local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files globally' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files in git' })

-- requires ripgreg installed
vim.keymap.set('n', '<leader>pg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
