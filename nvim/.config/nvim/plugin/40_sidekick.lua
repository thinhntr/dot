Z.later(function()
  Z.add('https://github.com/folke/sidekick.nvim')

  require('sidekick').setup({})
  local cli = require('sidekick.cli')
  local default = 'opencode'

  Z.map('n', '<leader>bb', function() cli.toggle({ name = default }) end)
  Z.map(
    'n',
    '<leader>bn',
    function() cli.send({ name = default, msg = '{file}' }) end
  )
end)

