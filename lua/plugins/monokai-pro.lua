-- Color theme for Neovim
return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function ()
    require("monokai-pro").setup({
      -- Classic theme selected, others are pro, ristretto, spectrum, light, machine, octogon...
      filter = "classic",
    })
    
    -- Set the color scheme for Neovim
    vim.cmd.colorscheme("monokai-pro")
  end
}
