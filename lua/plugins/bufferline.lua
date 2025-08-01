-- Provides the tab line at the top of the screen
return {
	"akinsho/bufferline.nvim",
	lazy = false,
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true

		require("bufferline").setup({
			options = {
        mode = 'buffers',
				separator_style = "slant", -- Define the style of the tabs
				show_buffer_close_icons = true,
				show_close_icon = false,
				offsets = {
					{
						filetype = "neo-tree", -- The filetype of the sidebar window
						text = "File Explorer", -- Optional text to show in the offset area
						highlight = "Directory", -- Optional highlight group for the text
						text_align = "center", -- Can be "left", "center", or "right"
						separator = true, -- Optional: Adds a separator after the text (newer versions)
					},
				},
			},
			highlights = {
				buffer_selected = {
					underline = true,
					italic = true,
				},
				separator_selected = {
					underline = true,
				},
			},
		})

		-- keymaps
		vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
	end,
}
