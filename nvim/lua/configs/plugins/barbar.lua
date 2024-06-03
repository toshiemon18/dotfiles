return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
	},
	init = function()
		vim.g.barbar_auto_setup = false
		require("bufferline").setup({})

		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		keymap('n', '<C-j>', ':BufferPrevious<CR>', opts)
		keymap('n', '<C-k>', ':BufferNext<CR>',     opts)
		keymap('n', '<leader>e', ':BufferClose<CR>',opts)
	end,
}

