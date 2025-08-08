local M = {}

function M.format_json_buffer()
  vim.cmd([[%!jq .]])
end

function M.format_json_visual()
  vim.cmd([['<,'>!jq .]])
end

vim.api.nvim_create_user_command('Jqf', M.format_json_buffer, {})
vim.api.nvim_create_user_command('Jqfv', M.format_json_visual, { range = true })

return M