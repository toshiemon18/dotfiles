local function tree_keys(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "<S-e>", api.node.open.vertical, opts("Open vertical"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open horizontal"))
end

return {
  "nvim-tree/nvim-tree.lua",
  config = function ()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      on_attach = tree_keys,
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = {
          "node_modules",
           "^.git$",
           "^.idea$",
          },
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<Leader>f", ":NvimTreeToggle<CR>", { silent = true, desc = "NvimTreeToggle" } },
    { "<C-n>", ":NvimTreeToggle<CR>", {silent = true, desc = "NvimTreeToogle"} },
    { "<leader><C-1>", "<cmd>NvimTreeFocus<CR>",  { silent = true, desc = "Focus NvimTree buffer" } }
  },
}

