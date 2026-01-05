local function keymaps()
  local keymap = vim.keymap
  local builtin = require("telescope.builtin")

  -- ファイル検索
  keymap.set("n", "<leader>tf", function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end, { desc = "Telescope: List Files" })
  -- live grep
  keymap.set("n", "<leader>tr",
    function()
      builtin.live_grep()
    end, 
    { desc = "Telescope: Live Grep" })
  keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "Telescope: Lists open buffers in current neovim instance" })

  -- キーマップ検索
  keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "Telescope: Lists normal mode keymappings" })

  -- nvimのautocmdを検索する
  keymap.set("n", "<Leader>ta", builtin.commands, { desc = "Telescope: Lists vim autocommands" })

  -- LSP の diagnostic 一覧を検索する
  keymap.set("n", "<Leader>d", builtin.diagnostics, { desc = "Telescope: Lists diagnostics" })

  -- File browser
  keymap.set("n", "<leader>ts", function()
    require("telescope").extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = vim.fn.expand("%:p:h"),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 }
    })
  end)
end

local function setup()
  local actions = require("telescope.actions")
  local filebrowser_actions = require("telescope").extensions.file_browser.actions

  require("telescope").setup({
    defaults = {
      prompt_title = false,
      mappings = {
        n = {
          -- Telescope を閉じる
          ["<ECS>"] = actions.close,
          ["q"] = actions.close
        },
        i = {
          ["<ECS>"] = actions.close,
          ["<C-u>"] = false
        }
      },
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = "top",
        mirror = true,
      },
      sorting_strategy = "ascending"
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        highjack_netrw = true,
        mapping = {
          ["i"] = {
            ["<C-w>"] = function()
              vim.cmd("normal vbd")
            end
          },
          ["n"] = {
            ["N"] = filebrowser_actions.create,
            ["h"] = filebrowser_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end
          }
        }
      }
    }
  })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
    "nvim-telescope/telescope-file-browser.nvim"
  },
  config = function()
    local _, telescope = pcall(require, "telescope")
    telescope.load_extension("file_browser")

    setup()
    keymaps()
  end,
}
