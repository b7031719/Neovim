return {
  "barrett-ruth/live-server.nvim",
  lazy = true,
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerRestart" },
  keys = {
    { "<leader>hp", "<cmd>LiveServerStart<cr>", desc = "HTML: Start live preview" },
    { "<leader>hP", "<cmd>LiveServerStop<cr>",  desc = "HTML: Stop live preview"  },
    { "<leader>hr", "<cmd>LiveServerRestart<cr>", desc = "HTML: Restart preview" },
  },
  opts = {
    -- Optional tweaks:
    port = 5500,
    quiet = true,
    -- If you want a specific browser on Windows, set the full path (or keep nil to use default):
    -- browser_command = [[C:\Program Files\Google\Chrome\Application\chrome.exe]],
    -- Choose the project root (defaults are usually fine):
    -- root = function()
    --   return require("live-server.util").get_root({ prefer_buf_cwd = true })
    -- end,
  },
}
