-- Parses code and builds a syntax tree for better automatic colouring etc.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
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

    highlight = {
      enable = true,
      addition_vim_regex_highlighting = false,
    },                        -- Enable Treesitter based syntax highlighting
    indent = { enable = true }, -- Enable Treesitter based automatic indentation
    -- Additional modules (like incremental_selection, textobjects, playground, etc.) can go here
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
