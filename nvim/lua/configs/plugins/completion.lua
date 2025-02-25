local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 15

-- 補完候補のメニューを整形するための関数
-- menu は非表示にする
-- 補完候補は最大30文字、最低でも15文字分の幅までは確保する
local function completion_candidates_formatter(entry, vim_item)
  local label = vim_item.abbr
  local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

  vim_item.menu = ""

  if truncated_label ~= label then
    vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
  elseif string.len(label) < MIN_LABEL_WIDTH then
    local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
    vim_item.abbr = label .. padding
  end

  return vim_item
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "L3MON4D3/LuaSnip",                       dependencies = { "afamadriz/friendly-snippets" } },
      "saadparwaiz1/cmp_luasnip",
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    config = function()
      local cmp = require("cmp")

      vim.o.completeopt = "menu,menuone,noselect"

      cmp.setup({
        ghost_text = { enabled = true },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<TAB>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lua" },
          { name = "nvim_lsp", priority = 100 },
          { name = "buffer",   keyword_length = 5, max_item_count = 5 },
          { name = "path" },
          { name = "luasnip" },
        }),
        formatting = {
          -- fields = {
          --   cmp.ItemField.Menu,
          --   cmp.ItemField.Abbr,
          --   cmp.ItemField.Kind
          -- },
          format = completion_candidates_formatter
        },
        experimental = { native_menu = false, ghost_text = { enabled = true } },
      })
    end,
  },
}
