return {
  "khoido2003/monokai-v2.nvim",
  priority = 1000,
  config = function()
    require("monokai-v2").setup({
      -- Basic settings
      transparent_background = false,
      terminal_colors = true,
      devicons = false,
      
      -- Syntax highlighting styles
      styles = {
        comment = { italic = true },
        keyword = { italic = true },
        type = { italic = false },
        storageclass = { italic = false },
        structure = { italic = false },
        parameter = { italic = false },
        annotation = { italic = false },
        tag_attribute = { italic = false },
      },
      
      -- Treesitter settings
      treesitter = {
        italic = false,
      },
      
      -- Filter selection (default: classic for dark, light for light background)
      filter = "classic", -- classic | light | machine | octagon | pro | ristretto | spectrum
      
      -- Day/night mode
      day_night = {
        enable = false,
        day_filter = "pro",
        night_filter = "spectrum",
      },
      
      -- Incremental search style
      inc_search = "background", -- underline | background
      
      -- Background clearing for floating windows
      background_clear = {
        "toggleterm",
        "telescope",
        "renamer",
        "notify",
      },
      
      -- Plugin-specific settings
      plugins = {
        indent_blankline = {
          context_highlight = "default", -- default | pro
          context_start_underline = false,
        },
      },
    })
    vim.cmd("colorscheme monokai-v2")
  end,
}
