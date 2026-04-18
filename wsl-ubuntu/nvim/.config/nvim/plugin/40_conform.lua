Z.later(function()
  Z.add('https://github.com/stevearc/conform.nvim')
  local conform = require('conform')
  conform.setup({
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
    },
  })

  Z.map(
    'n',
    '<leader>bf',
    function() require('conform').format({ async = false, lsp_format = 'fallback' }) end,
    { desc = 'conform format' }
  )
end)

