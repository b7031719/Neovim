-- Provides the tab line at the top of the screen
return {
  "akinsho/bufferline.nvim",
  event = "BufReadPost",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.opt.termguicolors = true
  end,
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant", -- Define the style of the tabs
      show_buffer_close_icons = true,
      show_close_icon = false,
      offsets = {
        {
          filetype = "neo-tree", -- The filetype of the sidebar window
          text = "File Explorer", -- Optional text to show in the offset area
          highlight = "Directory", -- Optional highlight group for the text
          text_align = "center", -- Can be "left", "center", or "right"
          separator = true,   -- Optional: Adds a separator after the text (newer versions)
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
  },
  keys = {
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", mode = "n", { desc = "Bufferline cycle next", noremap = true, silent = true } },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", mode = "n", { desc = "Bufferline cycle previous", noremap = true, silent = true } },
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", mode = "n", { desc = "Bufferline goto buffer 1", noremap = true, silent = true } },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", mode = "n", { desc = "Bufferline goto buffer 2", noremap = true, silent = true } },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", mode = "n", { desc = "Bufferline goto buffer 3", noremap = true, silent = true } },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", mode = "n", { desc = "Bufferline goto buffer 4", noremap = true, silent = true } },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", mode = "n", { desc = "Bufferline goto buffer 5", noremap = true, silent = true } },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", mode = "n", { desc = "Bufferline goto buffer 6", noremap = true, silent = true } },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", mode = "n", { desc = "Bufferline goto buffer 7", noremap = true, silent = true } },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", mode = "n", { desc = "Bufferline goto buffer 8", noremap = true, silent = true } },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", mode = "n", { desc = "Bufferline goto buffer 9", noremap = true, silent = true } },
  },
}
