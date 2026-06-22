return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ lsp_fallback = true, async = false })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			python = { "isort", "black" },
			lua = { "stylua" },
			nix = { "nixfmt" },
			html = { "prettier" },
			javascript = { "prettier" },
		},

		formatters = {
			black = {
				prepend_args = { "--line-length", "88" }, -- or your preference
			},
		},
	},
}
