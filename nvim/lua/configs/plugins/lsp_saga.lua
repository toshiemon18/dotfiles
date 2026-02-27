return {
  "nvimdev/lspsaga.nvim",
  -- cmd = { "Lspsaga" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false
      },
      breadcrumbs = {
        enable = true
      },
      ui = {
        border = "rounded",
        code_action = "💡"
      },
      outline = {
        auto_preview = false,
        layout = "float"
      }
    })

    -- Lspsaga keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Peek Definition - ジャンプせずに定義を確認
    keymap('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)

    -- Finder - 定義・参照・実装を統合UI で表示
    keymap('n', 'gh', '<cmd>Lspsaga finder<CR>', opts)

    -- Code Action - 見やすいコードアクション UI
    keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)

    -- Outline - ファイルのシンボル一覧
    keymap('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)

    -- Hover Doc - 改善されたホバー UI
    keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

    -- Diagnostic Jump - エラー・警告の移動
    keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  end
}
