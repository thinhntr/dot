Z.create_autocmd(
  'TextYankPost',
  nil,
  function() vim.hl.on_yank() end,
  'highlight on yank'
)

Z.create_autocmd('FileType', 'help', function()
  if vim.api.nvim_win_get_width(0) > 125 then
    vim.cmd.wincmd('L')
    vim.cmd('vert res 80')
  end
end, 'read help in vertical split')

Z.create_autocmd(
  'BufReadPost',
  nil,
  function() pcall(vim.cmd.normal, '\'"') end,
  'restore cursor position'
)

Z.create_autocmd(
  'WinEnter',
  nil,
  function() vim.o.cursorline = true end,
  'enable cursorline for active win'
)
Z.create_autocmd('WinLeave', nil, function()
  if vim.bo.filetype == 'qf' then return end
  vim.wo.cursorline = false
end, 'disable cursorline for inactive win')

-- vim.api.nvim_create_autocmd('BufWritePost', {
--   desc = 'Create BarBuf',
--   group = common_ag,
--   pattern = { '*.bar' },
--   callback = function()
--     local barBufnr = vim.fn.bufnr('BarBuf')
--
--     if barBufnr == -1 then
--       barBufnr = vim.api.nvim_create_buf(false, true)
--       vim.api.nvim_buf_set_name(barBufnr, 'BarBuf')
--     end
--
--     if not _G.BarWin or not vim.api.nvim_win_is_valid(_G.BarWin) then
--       local curWin = vim.api.nvim_get_current_win()
--       vim.cmd.vsplit()
--       _G.BarWin = vim.api.nvim_get_current_win()
--       vim.api.nvim_win_set_buf(_G.BarWin, barBufnr)
--       vim.api.nvim_set_current_win(curWin)
--     end
--
--     vim.fn.jobstart({ 'zsh', vim.fn.expand('%:p') }, {
--       stdout_buffered = true,
--       on_stdout = function(_, data)
--         vim.api.nvim_buf_set_lines(barBufnr, -1, -1, false, data)
--       end,
--     })
--   end,
-- })
