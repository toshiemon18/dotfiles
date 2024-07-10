local keymap = vim.keymap
local vaultPath = "$HOME/Dropbox/toshiemon_obsidian/"
local dailyDirName = "日記"

local function todays_note_path()
	local note_dir = vaultPath .. dailyDirName
	local note_path = os.date("/%Y/%m/%Y-%m-%d")

	return note_dir .. note_path .. ".md"
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

keymap.set(
	"n",
	"<leader><leader>ot",
	":e " .. todays_note_path() .. "<CR>",
	{
		silent = true,
		desc = "Open today's obsidian notebook",
	}
)

