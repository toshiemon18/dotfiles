return {
  "toshiemon18/daily_notes",
  dir = "~/.config/nvim/lua/configs/plugins/daily_notes",
  config = function()
    local daily_notes = require("configs.plugins.daily_notes")
    daily_notes.setup({
      -- 必要に応じて設定を上書きできます
      -- vault_path = "新しいパス",
      -- daily_dir = "新しいディレクトリ名",
      -- template_path = "新しいテンプレートパス",
      -- template_file = "新しいテンプレートファイル名",
    })

    require("configs.plugins.daily_notes.utils")
  end
}
