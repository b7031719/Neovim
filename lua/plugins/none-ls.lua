return {
  {
    -- Setup formatters and linters for different languages
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")

      require("mason-null-ls").setup({
        ensure_installed = {
          "eslint_d",
          "flake8",
          "stylua",
          "prettier",
          "black",
          "isort",
        },
        automatic_installation = true,
        handlers = {},
      })

      null_ls.setup({})

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
