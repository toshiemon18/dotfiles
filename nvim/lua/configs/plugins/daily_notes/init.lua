local M = {}

-- 設定のデフォルト値
local config = {
  vault_path = "$HOME/Dropbox/アプリ/remotely-save/toshiemon_obsidian/",
  daily_dir = "日記",
  template_path = "$HOME/Dropbox/アプリ/remotely-save/toshiemon_obsidian/templates/",
  template_file = "daily_node_template.md",
}

-- 設定を更新する関数
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

-- 日付フォーマットを処理する関数
local function format_date(format)
  local date = os.date("*t")
  local formats = {
    ["YYYY"] = string.format("%04d", date.year),
    ["MM"] = string.format("%02d", date.month),
    ["DD"] = string.format("%02d", date.day),
    ["HH"] = string.format("%02d", date.hour),
    ["mm"] = string.format("%02d", date.min),
  }

  local result = format
  for key, value in pairs(formats) do
    result = result:gsub(key, value)
  end

  return result
end

-- テンプレートを読み込む関数
function M.load_template()
  local template_path = vim.fn.expand(config.template_path .. config.template_file)
  local file = io.open(template_path, "r")
  if not file then
    vim.notify("テンプレートファイルが見つかりません: " .. template_path, vim.log.levels.ERROR)
    return nil
  end
  local content = file:read("*all")
  file:close()
  return content
end

-- テンプレート変数を置換する関数
function M.replace_template_variables(template)
  -- 日付と時刻の置換
  template = template:gsub("{{date:([^}]+)}}", function(format)
    return format_date(format)
  end)

  template = template:gsub("{{time:([^}]+)}}", function(format)
    return format_date(format)
  end)

  return template
end

-- デイリーノートを作成する関数
function M.create_daily_note()
  local template = M.load_template()
  if not template then return end

  local processed_template = M.replace_template_variables(template)

  local year = os.date("%Y")
  local month = os.date("%m")
  local filename = os.date("%Y-%m-%d") .. ".md"
  local filepath = vim.fn.expand(config.vault_path .. config.daily_dir .. "/" .. year .. "/" .. month .. "/" .. filename)

  -- ディレクトリが存在しない場合は作成
  vim.fn.mkdir(vim.fn.fnamemodify(filepath, ":h"), "p")

  -- ファイルが存在しない場合は作成
  local file = io.open(filepath, "r")
  if not file then
    file = io.open(filepath, "w")
    if file then
      file:write(processed_template)
      file:close()
    else
      vim.notify("ファイルの作成に失敗しました: " .. filepath, vim.log.levels.ERROR)
      return
    end
  else
    file:close()
  end

  -- ファイルを開く
  vim.cmd("e " .. filepath)
end

-- Telescope用の検索機能
function M.search_notes()
  local telescope = require("telescope.builtin")
  telescope.live_grep({
    cwd = vim.fn.expand(config.vault_path .. config.daily_dir),
    prompt_title = "デイリーノート検索",
  })
end

return M
