-- provides the status bar at the bottom of Neovim
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {

				-- Set the theme to Monokai-pro
				theme = "monokai-pro",
			},
		})
	end,
}
