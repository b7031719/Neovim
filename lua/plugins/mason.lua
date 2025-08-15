return {
	{
		"mason-org/mason.nvim",
    opts = {},
	},
	{
		-- Mason-lspconfig provides the ensure-installed function for installing language servers
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"bashls",
				"html",
				"cssls",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"eslint_d",
				"flake8",
				"stylua",
				"prettier",
				"black",
				"isort",
			},
			automatic_installation = true,
			handlers = {},
		},
	},
}
