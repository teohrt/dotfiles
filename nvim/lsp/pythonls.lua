vim.lsp.config['pythonls'] = {
	cmd = { "python-lsp-server" },
	filetypes = { "python" },
	-- Optional: Root markers
	root_markers = { ".git", ".hg", ".python-project", ".pyproject.toml" },
	-- Optional: Settings
	settings = {
		-- Example setting:
		python = {
			analysis = {
				ignore = {
					"*.pyc",
					"__pycache__",
				},
			},
		},
	},
}
