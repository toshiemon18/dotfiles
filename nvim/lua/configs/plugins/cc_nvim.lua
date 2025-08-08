return {
  -- "toshiemon18/cc.nvim",
  dir = "~/ghq/github.com/toshiemon18/cc.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("cc_nvim").setup({
      claude_executable = "claude", -- Path to Claude Code CLI
      auto_start = true, -- Auto-start Claude Code session
      timeout = 30000, -- Timeout for Claude Code responses
      max_history = 100, -- Maximum chat history
    })
  end
}
