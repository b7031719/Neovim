local function is_not_nixos()
  return vim.fn.executable("nixos-version") == 0
end

return {
	{
		"mason-org/mason.nvim",
    enabled = is_not_nixos,
    opts = {},
	},
	{
		-- Mason-lspconfig provides the ensure-installed function for installing language servers
		"mason-org/mason-lspconfig.nvim",
    enabled = is_not_nixos,
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
    enabled = is_not_nixos,
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
