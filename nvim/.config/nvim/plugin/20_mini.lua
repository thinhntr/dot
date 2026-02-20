Z.now(function()
  require('mini.icons').setup({})
  Z.later(MiniIcons.mock_nvim_web_devicons)
  Z.later(MiniIcons.tweak_lsp_kind)
end)

Z.now_if_args(function()
  require('mini.files').setup({
    mappings = {
      go_in_plus = 'l',
      synchronize = 'S',
    },
  })

  Z.map('n', '<leader>e', function()
    local path = vim.api.nvim_buf_get_name(0)

    if not vim.uv.fs_stat(path) then path = MiniFiles.get_latest_path() end

    if not MiniFiles.close() then MiniFiles.open(path) end
  end)
end)

Z.later(function() require('mini.align').setup() end)

Z.later(function()
  require('mini.surround').setup({
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = '',
      find_left = '',
      highlight = '',
      replace = 'cs',
    },
  })
  Z.map('n', 'yss', 'ys_', { remap = true, desc = 'Add surrounding linewise' })
end)

Z.later(function()
  local ai = require('mini.ai')
  ai.setup({
    n_lines = 10000,
    custom_textobjects = {
      F = ai.gen_spec.treesitter({
        a = '@function.outer',
        i = '@function.inner',
      }),
    },
  })
end)
