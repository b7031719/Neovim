-- provides the status bar at the bottom of Neovim
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    theme = "monokai-pro",
  },
}
