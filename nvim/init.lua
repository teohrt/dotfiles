print("loading neo vim profile")
require("trace")

print("loading LSPs")

-- git clone https://github.com/LuaLS/lua-language-server
-- cd lua-language-server
vim.lsp.enable('luals')

-- pip install python-lsp-server
vim.lsp.enable('pythonls')
