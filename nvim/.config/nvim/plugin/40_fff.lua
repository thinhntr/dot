Z.later(function()
  Z.add({
    source = 'https://github.com/dmtrKovalenko/fff.nvim',
    hooks = {
      post_install = function() require('fff.download').download_or_build_binary() end,
    },
  })

  vim.g.fff = {
    keymaps = { close = '<C-c>' },
    debug = { enabled = true, show_scores = true },
    preview = { wrap_lines = true, line_numbers = true },
    layout = { width = 1, preview_size = 0.45 },
  }

  Z.map('n', '<leader><leader>', '<Cmd>lua require("fff").find_files()<CR>')
  Z.map('n', '<leader>fg', '<Cmd>lua require("fff").live_grep()<CR>')
end)
