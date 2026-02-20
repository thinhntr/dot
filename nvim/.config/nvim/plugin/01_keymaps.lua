Z.map('n', 'Q', '<Nop>')
Z.map('i', '<C-c>', '<Esc>')
Z.map('t', '<Esc><Esc>', '<C-\\><C-n>')
Z.map('n', '<Esc>', '<Cmd>nohlsearch<CR>')
Z.map('i', '<C-l>', '<Right>', { desc = 'move cursor to the right' })

Z.map('n', '<C-q>', '<C-w><C-q>', { desc = 'close window' })
Z.map('n', '<C-h>', '<C-w><C-h>', { desc = 'cycle through windows' })

Z.map({ 'x' }, '<leader>p', '"_dP')
Z.map({ 'n', 'v' }, '<leader>d', '"_d')
Z.map({ 'n', 'v' }, '<leader>D', '"_D')
Z.map({ 'n', 'v' }, '<leader>c', '"_c')
Z.map({ 'n', 'v' }, '<leader>C', '"_C')
Z.map({ 'n', 'v' }, '<leader>y', '"+y')
Z.map({ 'n', 'v' }, '<leader>Y', '"+Y')
Z.map({ 'n' }, '<leader>by', function()
  local text = vim.fn.getreg('+')
  vim.system({ 'ansifilter' }, { stdin = text, text = true }, function(obj)
    vim.schedule(function()
      vim.fn.setreg('+', obj.stdout)
      vim.notify('ansifilter cleaned "+')
    end)
  end)
end, { desc = 'yank with ansifilter' })

Z.map('n', 'n', 'nzz')
Z.map('n', 'N', 'Nzz')
Z.map('n', '<C-d>', '<C-d>zz')
Z.map('n', '<C-u>', '<C-u>zz')
Z.map('n', '<C-n>', '<Cmd>cnext<CR>zz')
Z.map('n', '<C-p>', '<Cmd>cprev<CR>zz')

Z.map('x', '>', '>gv', { desc = 'shift lines right nonstop' })
Z.map('x', '<', '<gv', { desc = 'shift lines left nonstop' })

Z.map('n', '[e', '<Cmd>move--v:count1<CR>')
Z.map('n', ']e', '<Cmd>move+v:count1<CR>')

Z.map('n', '<leader>q', vim.diagnostic.open_float, { desc = 'diag open float' })
Z.map('n', '<leader>bq', vim.diagnostic.setqflist, { desc = 'diag set qflist' })

Z.map('n', '<leader>r', function()
  if vim.env.TMUX == nil or vim.env.TMUX == '' then
    vim.notify('run: failed. Not in tmux')
    return
  end
  local count = vim.fn.system('tmux list-panes | wc -l')
  if tonumber(count) < 2 then
    if vim.api.nvim_win_get_width(0) > 125 then
      vim.fn.system('tmux splitw -h -l 60')
    else
      vim.fn.system('tmux splitw -v -l 15')
    end
  end
  local cmd = 'make'
  vim.system({ 'tmux', 'send-keys', '-t', ':.2', cmd, 'Enter' })
  vim.notify('run: ok. ' .. cmd)
end, { desc = 'split tmux panes and run stuff' })
