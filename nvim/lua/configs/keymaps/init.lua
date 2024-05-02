local keymap = vim.keymap

-- example:
--  noremap vn :vnew<CR> -> keymap.set('', 'vn', ':vnew<CR>', { noremap = true })
-- nnoremap <silent> ,f :GFiles<CR> ->  keymap.set('n', ',f', ":GFiles<CR>", { silent = true })

keymap.set('n', ';', ':',  { noremap = true })

keymap.set('n', '<esc><ecs>', ':nohlsearch<CR>', { noremap = true })

keymap.set('', 'vn', ':vnew<CR>', { noremap = true })

keymap.set('', '<S-h>', '^', { noremap = true })
keymap.set('', '<S-l>', '$', { noremap = true })

-- visual で <> のインデント後に  visual が解除されないようにする
keymap.set('v', ">", ">gv", { noremap = true })
keymap.set('v', "<", "<gv", { noremap = true })
