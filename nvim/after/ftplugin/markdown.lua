-- Markdown

-- indent
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.cindent = false
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.expandtab = true

-- conceallevel
vim.opt.conceallevel = 2

-- 箇条書きを開業したあと、同じシンボルで箇条書きを継続するための設定
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

-- Markdown チェックボックスの処理関数
local function get_range(args)
  -- get target range from user command args
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

--- markdownのCheckbox化・CheckboxのオンオフのToggle
local LIST_PATTERN = [[^\s*\([\*+-]\|[0-9]\+\.\)\s\+]]
local function toggle_checkbox(args)
  local from, to = get_range(args)
  if from == nil or to == nil then
    vim.notify("failed to get range to toggle checkbox", vim.log.levels.ERROR)
    return
  end
  local curpos = vim.fn.getcursorcharpos()
  local lines = vim.fn.getline(from, to)

  for lnum = from, to, 1 do
    local line = lines[lnum - from + 1] --[[@as string]]

    if not vim.regex(LIST_PATTERN):match_str(line) then
      -- not list -> add list marker and blank box
      vim.fn.setline(lnum, vim.fn.substitute(line, [[\v\S|$]], [[- [ ] \0]], ""))
      if lnum == curpos[1] then
        vim.fn.setcursorcharpos({ curpos[1], curpos[2] + 6 })
      end
    elseif vim.regex(LIST_PATTERN .. [[\[ \]\s\+]]):match_str(line) then
      -- blank box -> check
      vim.fn.setline(lnum, vim.fn.substitute(line, "\\[ \\]", "[x]", ""))
    elseif vim.regex(LIST_PATTERN .. [[\[x\]\s\+]]):match_str(line) then
      -- checked box -> uncheck
      vim.fn.setline(lnum, vim.fn.substitute(line, "\\[x\\]", "[ ]", ""))
    else
      -- list but no box -> add box after list marker
      vim.fn.setline(lnum, vim.fn.substitute(line, [[\S\+]], "\\0 [ ]", ""))
      if lnum == curpos[1] then
        vim.fn.setcursorcharpos({ curpos[1], curpos[2] + 4 })
      end
    end
  end
end

-- コマンドを作成
vim.api.nvim_create_user_command("ToggleCheckbox", toggle_checkbox, { range = true, force = true })
local keymap_opts = { buffer = true }
vim.keymap.set({ "n", "i", "x" }, '<leader>tt', ':ToggleCheckbox<CR>', keymap_opts)
