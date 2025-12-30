return {
  "folke/which-key.nvim",
  -- event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      -- Telescope グループ
      { "<leader>t", group = "Telescope" },
      { "<leader>tf", desc = "Find Files" },
      { "<leader>tr", desc = "Live Grep" },
      { "<leader>tb", desc = "Buffers" },
      { "<leader>tk", desc = "Keymaps" },
      { "<leader>ta", desc = "Commands" },
      { "<leader>ts", desc = "File Browser" },

      -- Diagnostics
      { "<leader>d", desc = "Diagnostics" },

      -- タブ移動
      { "<leader>[", desc = "Previous Tab" },
      { "<leader>]", desc = "Next Tab" },

      -- LSP Actions
      { "<leader>a", group = "LSP Actions" },
      { "<leader>aa", desc = "Show Diagnostics" },
      { "<leader>ca", desc = "Code Action" },
      { "<leader>o", desc = "Outline" },

      -- LSP Go to
      { "g", group = "Go to" },
      { "gd", desc = "Go to Definition" },
      { "gD", desc = "Go to Declaration" },
      { "gi", desc = "Go to Implementation" },
      { "gr", desc = "Go to References" },
      { "gy", desc = "Go to Type Definition" },
      { "gh", desc = "Finder (def/ref/impl)" },
      { "gp", desc = "Peek Definition" },

      -- Diagnostics
      { "[d", desc = "Previous Diagnostic" },
      { "]d", desc = "Next Diagnostic" },
      { "dl", desc = "Set Diagnostics to Loclist" },

      -- Other LSP
      { "K", desc = "Hover Documentation" },
      { "<C-s>", desc = "Signature Help", mode = "n" },
      { "<space>gf", desc = "Format Document" },
    },
  },
  keys = {
    { "<c-w>" },
    { "<leader>" },
    { "]" },
    { "[" },
    { "g" },
    { "<c-g>" },
    { "<c-d>" },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
