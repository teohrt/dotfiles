-- while in normal mode, if I press leader+pv, it will excecute the "Ex" command  
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines, respecting indents
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
