local keymap = vim.keymap
local vaultPath = "$HOME/Dropbox/アプリ/remotely-save/toshiemon_obsidian/"
local dailyDirName = "日記"

local function daily_path()
  return vaultPath .. dailyDirName
end

vim.api.nvim_create_user_command(
	"ObsidianDaily",
	function()
		open_today_note()
	end,
	{}
)

vim.api.nvim_create_user_command(
  "OpenObisidianVault",
  function()
    local telescope = require("telescope.builtin")

    telescope.find_files({ cwd = vaultPath })
  end,
  {}
)

vim.api.nvim_create_user_command(
  "OpenJournal",
  function()
    local note_filename = os.date("/%Y/%m/%Y-%m-%d") .. ".md"

    vim.cmd("e " .. daily_path() .. note_filename)
  end,
  {}
)

keymap.set(
	"n",
	"<leader><leader>ot",
  "<cmd>OpenJournal<CR>",
	{
		silent = true,
		desc = "Open today's obsidian notebook",
	}
)

