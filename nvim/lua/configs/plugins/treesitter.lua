return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		"andymass/vim-matchup",
		"RRethy/nvim-treesitter-endwise",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
    -- NOTE: ruby でメソッド呼び出しの入力をするとインデントが下げられる問題への対応
    vim.api.nvim_create_autocmd(
      "FileType",
      {
        pattern = {"ruby"},
        callback = function()
          vim.opt_local.indentkeys:remove(".")
        end
      }
    )

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"git_config",
				"gitcommit",
				"go",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"rbs",
				"rst",
				"ruby",
				"sql",
				"tsx",
				"toml",
				"typescript",
				"vim",
				"yaml",
			}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			autotag = {
				enable = true
			},
			highlight = {
				enable = true, -- false will disable the whole extension
			},
			incremental_selection = {
				enable = true,
			},
			indent = {
				enable = true,
				-- disable = { "ruby" },
			},
			matchup = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = 2000,
			},
			endwise = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
					},
					-- You can choose the select mode (default is charwise 'v')
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding xor succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					include_surrounding_whitespace = false,
				},
			},
	})
	end
}
