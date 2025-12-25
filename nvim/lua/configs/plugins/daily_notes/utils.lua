local daily_notes = require("configs.plugins.daily_notes")

-- コマンドの登録
vim.api.nvim_create_user_command(
  "DailyNote",
  function()
    daily_notes.create_daily_note()
  end,
  { desc = "今日のデイリーノートを作成または開く" }
)

vim.api.nvim_create_user_command(
  "SearchDailyNotes",
  function()
    daily_notes.search_notes()
  end,
  { desc = "デイリーノートを検索" }
)

-- キーマッピングの設定
local keymap = vim.keymap.set

keymap("n", "<C-d><C-n>", "<cmd>DailyNote<CR>", {
  silent = true,
  desc = "今日のデイリーノートを作成または開く",
})

keymap("n", "<C-d><C-s>", "<cmd>SearchDailyNotes<CR>", {
  silent = true,
  desc = "デイリーノートを検索",
})

