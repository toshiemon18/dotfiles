-- keymaps
--  デフォルトのキーマップについてのみ
--  各プラグインのキーマップはそれぞれの設定ファイルで記述する
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 新規バッファを水平方向に開く
keymap('', 'vn', ':vnew<CR>', opts)
-- Shift + {h,l} で末尾に飛ぶ
keymap('', '<S-h>', '^', opts)
keymap('', '<S-l>', '$', opts)

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal
-- USキーボード向け
keymap('n', ';', ':', opts)

-- 検索結果のハイライトを消す
keymap('n', '<ESC><ESC>', ':nohlsearch<CR>', opts)

-- :UpdateRemotePlugins
keymap('n', '<Space>ur', ':UpdateRemotePlugins<CR>', opts)
