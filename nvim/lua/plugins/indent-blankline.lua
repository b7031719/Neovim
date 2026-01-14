-- Provides vertical indentation lines
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  event = "BufReadPost",
  opts = {},
}
