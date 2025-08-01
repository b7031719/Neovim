-- Parses code and builds a syntax tree for better automatic colouring etc.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"bash",
				"python",
				"javascript",
				"html",
				"css",
				"json",
				"c",
				"c_sharp",
				"csv",
				"markdown",
        "markdown_inline",
				"nix",
			},

			highlight = { enable = true }, -- Enable Treesitter based syntax highlighting
			indent = { enable = true }, -- Enable Treesitter based automatic indentation
			-- Additional modules (like incremental_selection, textobjects, playground, etc.) can go here
		})
	end,
}
