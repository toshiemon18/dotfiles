return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("configs.plugins.lsp.config").setup()
	end,
}
