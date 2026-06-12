-- ┌──────────────────────┐
-- │ colorscheme          │
-- └──────────────────────┘
Z.now(function()
  Z.add({ 'https://github.com/folke/tokyonight.nvim' })
  require('tokyonight').setup()
  vim.cmd.colorscheme('tokyonight')
end)

-- ┌──────────────────────┐
-- │ mini.nvim            │
-- └──────────────────────┘
Z.now(
  function() require('mini.notify').setup({ lsp_progress = { enable = false } }) end
)

Z.now(function()
  require('mini.icons').setup()
  require('mini.icons').mock_nvim_web_devicons()
end)

Z.now_if_args(function()
  require('mini.misc').setup()
  require('mini.misc').setup_restore_cursor()
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
      replace = 'cs',
      find = '',
      find_left = '',
      highlight = '',
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

Z.later(function()
  local active = function()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 999 })
    local git = MiniStatusline.section_git({ trunc_width = 90 })
    local diff = MiniStatusline.section_diff({ trunc_width = 100 })
    local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 110 })
    local lsp = MiniStatusline.section_lsp({ trunc_width = 110 })
    local location = MiniStatusline.section_location({ trunc_width = 80 })
    local navic = ''
    if
      package.loaded['nvim-navic']
      and require('nvim-navic').is_available()
      and not MiniStatusline.is_truncated(80)
    then
      navic = require('nvim-navic').get_location()
    end

    return MiniStatusline.combine_groups({
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineFileinfo', strings = { '%t' } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { navic } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { diagnostics, lsp, diff, git } },
      { hl = mode_hl, strings = { location } },
    })
  end
  require('mini.statusline').setup({
    content = {
      active = active,
    },
  })
end)

Z.later(function()
  require('mini.pick').setup({
    mappings = {
      toggle_preview = '<M-p>',
      mark = '<Tab>',
      choose_marked = '<C-q>',
    }
  })
  require('mini.extra').setup({})

  MiniPick.registry.projects = function()
    return MiniPick.builtin.cli({ command = { 'tt' } })
  end

  local function lsp(scope)
    return function() MiniExtra.pickers.lsp({ scope = scope }) end
  end

  -- stylua: ignore start
  Z.map('n', 'grd', lsp('definition'),            { desc = 'go to definition' })
  Z.map('n', 'gri', lsp('implementation'),        { desc = 'go to implementation' })
  Z.map('n', 'grr', lsp('references'),            { desc = 'go to references' })
  Z.map('n', 'grt', lsp('type_definition'),       { desc = 'go to type definition' })
  Z.map('n', 'gO',  lsp('document_symbol'),       { desc = 'document symbol' })
  Z.map('n', 'gW',  lsp('workspace_symbol_live'), { desc = 'workspace symbol' })

  Z.map('n', '<leader>ph', MiniPick.builtin.help,     { desc = 'pick help' })
  Z.map('n', '<leader>pk', MiniExtra.pickers.keymaps, { desc = 'pick keymaps' })
  Z.map('n', '<leader>pb', MiniPick.builtin.buffers,  { desc = 'pick buffers' })
  Z.map('n', '<leader>pr', MiniPick.builtin.resume,   { desc = 'pick resume' })
  Z.map('n', '<leader>pm', MiniNotify.show_history,   { desc = 'pick nofify history' })
  Z.map('n', '<leader>pp', MiniPick.registry.projects, { desc = 'pick projects' })
  -- stylua: ignore end
end)
