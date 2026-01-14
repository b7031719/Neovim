-- File explorer plugin
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
  },
	lazy = true, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
		window = {
			position = "left", -- can be "left", "right", or "float"
			width = 30, -- fixed width of the Neo-tree sidebar
			auto_expand_width = false, -- disables auto-expansion
		},
	},
	keys = {
		{ "<C-e>", "<cmd>Neotree filesystem toggle reveal=true position=left<cr>", desc = "Toggle neotree" },
	},
}
