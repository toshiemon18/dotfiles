return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    config = function()
      local cmp = require("cmp")

      vim.o.completeopt = "menu,menuone,noselect"

      cmp.setup({
        ghost_text = { enabled = true },
        snippet = {
					-- todo*: luasnips
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 5, max_item_count = 5 },
          { name = "path" },
        }),
        formatting = {
          fields = { cmp.ItemField.Menu, cmp.ItemField.Abbr, cmp.ItemField.Kind },
        },
        experimental = { native_menu = false, ghost_text = { enabled = true } },
      })
    end,
  },
}
