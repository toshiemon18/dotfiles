return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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

      -- LSP グループ
      { "<leader>a", group = "LSP Actions" },
      { "<leader>aa", desc = "Show Diagnostics" },

      -- LSP 基本操作
      { "g", group = "Go to" },
      { "gd", desc = "Go to Definition" },
      { "gD", desc = "Go to Declaration" },
      { "gi", desc = "Go to Implementation" },
      { "go", desc = "Go to Type Definition" },
      { "gr", desc = "Go to References" },
      { "gy", desc = "Go to Type Definition" },

      -- その他
      { "K", desc = "Hover Documentation" },
      { "<C-s>", desc = "Signature Help", mode = "n" },
      { "<space>gf", desc = "Format Document" },
      { "dl", desc = "Set Diagnostics to Loclist" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
