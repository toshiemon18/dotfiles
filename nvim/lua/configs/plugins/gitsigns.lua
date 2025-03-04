return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "▐" },
        change = { text = "▐" },
        delete = { text = "▐" },
        topdelete = { text = "▐" },
        changedelete = { text = "▐" },
        untracked = { text = "▐" },
      },
    })

    local opts = { noremap = true }
    vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', opts)
    vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', opts)
    vim.keymap.set('n', '<C-g><C-p>', ':Gitsigns preview_hunk<CR>', opts)
    vim.keymap.set('n', '<C-g><C-v>', ':Gitsigns blame_line<CR>', opts)
    vim.keymap.set('n', '<C-g><C-b>', ':Gitsigns blame<CR>', opts)
    vim.keymap.set('n', '<C-g>a', ':Gitsigns stage_buffer<CR>', opts)
  end,
}

