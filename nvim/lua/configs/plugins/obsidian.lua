local keymap = vim.keymap
local vaultPath = "$HOME/Dropbox/toshiemon_obsidian/"
local dailyDirName = "日記"

local function daily_path()
  return vaultPath .. dailyDirName
end

local function todays_note_path()
	local note_filename = os.date("/%Y/%m/%Y-%m-%d") .. ".md"

	return  daily_path() .. note_filename
end

function open_today_note()
	local note_path = todays_note_path()

	vim.cmd(':e' .. note_path)
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

keymap.set(
	"n",
	"<leader><leader>ot",
	":e " .. todays_note_path() .. "<CR>",
	{
		silent = true,
		desc = "Open today's obsidian notebook",
	}
)

