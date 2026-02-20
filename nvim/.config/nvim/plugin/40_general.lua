Z.now_if_args(function()
  Z.add('https://github.com/NMAC427/guess-indent.nvim')
  require('guess-indent').setup({})
end)

Z.now_if_args(function()
  Z.add('https://codeberg.org/andyg/leap.nvim')
  Z.map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
end)

Z.on_filetype('qf', function()
  Z.add('https://github.com/stevearc/quicker.nvim')
  require('quicker').setup({})
end)

Z.on_filetype('terminal', function()
  Z.add('https://github.com/norcalli/nvim-terminal.lua')
  require('terminal').setup({})

  Z.create_autocmd(
    'FileType',
    'terminal',
    function() vim.wo.cocu = vim.wo.cocu .. 'v' end
  )
end)

Z.on_event('CursorMoved', function()
  Z.add('https://github.com/hedyhli/outline.nvim')
  require('outline').setup({ outline_window = { position = 'left' } })
  Z.map('n', '<leader>bo', '<Cmd>Outline<CR>')
end)

Z.on_event('CursorMoved', function()
  Z.add('https://github.com/kevinhwang91/nvim-ufo')
  Z.add('https://github.com/kevinhwang91/promise-async')
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99

  local ufo = require('ufo')
  ufo.setup({})

  Z.map('n', 'zR', ufo.openAllFolds, { desc = 'openAllFolds' })
  Z.map('n', 'zM', ufo.closeAllFolds, { desc = 'closeAllFolds' })
end)
