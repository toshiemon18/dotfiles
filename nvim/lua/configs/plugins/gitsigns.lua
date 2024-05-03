return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "▐" },
        change = { hl = "GitSignsChange", text = "▐" },
        delete = { hl = "GitSignsDelete", text = "▐" },
        topdelete = { hl = "GitSignsDelete", text = "▐" },
        changedelete = { hl = "GitSignsChange", text = "▐" },
        untracked = { hl = "GitSignsAdd", text = "▐" },
      },
    })

    local opts = { noremap = true }
    vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', opts)
    vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', opts)
    vim.keymap.set('n', '<C-g><C-p>', ':Gitsigns preview_hunk<CR>', opts)
    vim.keymap.set('n', '<C-g><C-v>', ':Gitsigns blame_line<CR>', opts)
    vim.keymap.set('n', '<C-g>a', ':Gitsigns stage_buffer<CR>', opts)
  end,
}

