local function keymaps()
  local keymap = vim.keymap
  local builtin = require("telescope.builtin")

  keymap.set("n", "<Leader>m", builtin.marks,                { desc = "Telescope: Lists vim marks" })
  keymap.set("n", "<Leader>k", builtin.keymaps,              { desc = "Telescope: Lists normal mode keymappings" })
  keymap.set("n", "<Leader>l", builtin.buffers,              { desc = "Telescope: Lists open buffers in current neovim instance" })
  keymap.set("n", "<Leader>0", builtin.oldfiles,             { desc = "Telescope: Lists previously open files" })
  keymap.set("n", "<Leader>c", builtin.commands,             { desc = "Telescope: Lists vim autocommands" })
  keymap.set("n", "<Leader>o", builtin.find_files,           { desc = "Telescope: Open files" })
  keymap.set("n", "<Leader>d", builtin.diagnostics,          { desc = "Telescope: Lists diagnostics" })
  keymap.set("n", "<Leader><Leader>", builtin.builtin,       { desc = "Telescope: Open builtin function" })
  keymap.set("n", "<Leader>a", builtin.lsp_document_symbols, { desc = "Telescope: List LSP document symbols" })
end

local function setup()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      mappings = {
        n = { ["<ECS>"] = actions.close }
      },
      layout_strategy = "vertical",
    }
  })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim"
  },
  config = function()
    setup()
    keymaps()
  end,
}

