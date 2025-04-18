-- Markdown

-- インデント設定
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true

-- テキストの折りたたみ設定
vim.opt_local.conceallevel = 2
vim.opt_local.foldmethod = "marker"
vim.opt_local.foldmarker = "{{{,}}}"

-- 箇条書きの設定
vim.opt_local.comments = {
  "b:* [ ]",
  "b:* [x]",
  "b:- [ ]",
  "b:- [x]",
  "b:*",
  "b:-",
  "b:+",
  "b:1.",
  "nb:>",
}
vim.opt_local.formatoptions:remove("c")
vim.opt_local.formatoptions:append("jro")

-- チェックボックスの処理関数
local function get_range(args)
  local from = args.line1
  local to = args.line2
  local another = vim.fn.line("v")
  if another == nil then
    return nil, nil
  end
  if from == to and from ~= another then
    if another < from then
      from = another
    else
      to = another
    end
  end
  return from, to
end

local LIST_PATTERN = [[^\s*\([\*+-]\|[0-9]\+\.\)\s\+]]
local function toggle_checkbox(args)
  local from, to = get_range(args)
  if from == nil or to == nil then
    vim.notify("チェックボックスの範囲を取得できませんでした", vim.log.levels.ERROR)
    return
  end
  local curpos = vim.fn.getcursorcharpos()
  local lines = vim.fn.getline(from, to)

  for lnum = from, to, 1 do
    local line = lines[lnum - from + 1]

    if not vim.regex(LIST_PATTERN):match_str(line) then
      vim.fn.setline(lnum, vim.fn.substitute(line, [[\v\S|$]], [[- [ ] \0]], ""))
      if lnum == curpos[1] then
        vim.fn.setcursorcharpos({ curpos[1], curpos[2] + 6 })
      end
    elseif vim.regex(LIST_PATTERN .. [[\[ \]\s\+]]):match_str(line) then
      vim.fn.setline(lnum, vim.fn.substitute(line, "\\[ \\]", "[x]", ""))
    elseif vim.regex(LIST_PATTERN .. [[\[x\]\s\+]]):match_str(line) then
      vim.fn.setline(lnum, vim.fn.substitute(line, "\\[x\\]", "[ ]", ""))
    else
      vim.fn.setline(lnum, vim.fn.substitute(line, [[\S\+]], "\\0 [ ]", ""))
      if lnum == curpos[1] then
        vim.fn.setcursorcharpos({ curpos[1], curpos[2] + 4 })
      end
    end
  end
end

-- コマンドとキーマップの設定
vim.api.nvim_create_user_command("ToggleCheckbox", toggle_checkbox, { range = true, force = true })
local keymap_opts = { buffer = true }
vim.keymap.set({ "n", "i", "x" }, '<leader>tt', ':ToggleCheckbox<CR>', keymap_opts)
