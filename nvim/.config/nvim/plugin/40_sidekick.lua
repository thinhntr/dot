Z.later(function()
  Z.add('https://github.com/folke/sidekick.nvim')

  require('sidekick').setup({
    cli = {
      mux = {
        enabled = true,
        backend = 'tmux',
        create = 'split',
      },
    },
  })
  local cli = require('sidekick.cli')
  local default = 'opencode'

  Z.map(
    'n',
    '<leader>bb',
    function() cli.toggle({ name = default }) end,
    { desc = 'open sidekick' }
  )
  Z.map(
    'n',
    '<leader>bn',
    function() cli.send({ name = default, msg = '{file}' }) end,
    { desc = 'open sidekick with current file' }
  )
end)
