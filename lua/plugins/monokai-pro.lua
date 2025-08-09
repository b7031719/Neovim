-- Color theme for Neovim
return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function ()
    require("monokai-pro").setup({
      filter = "classic",
    })

    -- Set the color scheme for Neovim
    vim.cmd.colorscheme("monokai-pro")
  end
}
