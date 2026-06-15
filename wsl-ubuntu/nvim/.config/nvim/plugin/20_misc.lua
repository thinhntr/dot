Z.now_if_args(function()
  Z.add({ 'https://github.com/NMAC427/guess-indent.nvim' })
  require('guess-indent').setup({})
end)

Z.now_if_args(function()
  Z.add({ 'https://codeberg.org/andyg/leap.nvim' })
  Z.map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
end)

Z.on_filetype('qf', function()
  Z.add({ 'https://github.com/stevearc/quicker.nvim' })
  require('quicker').setup({})
end)

Z.on_filetype('terminal', function()
  Z.add({ 'https://github.com/norcalli/nvim-terminal.lua' })
  require('terminal').setup({})

  Z.create_autocmd(
    'FileType',
    'terminal',
    function() vim.wo.cocu = vim.wo.cocu .. 'v' end
  )
end)

Z.now_if_args(function()
  Z.add({ 'https://github.com/kevinhwang91/nvim-ufo' })
  Z.add({ 'https://github.com/kevinhwang91/promise-async' })
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99

  local ufo = require('ufo')
  ufo.setup({})

  Z.map('n', 'zR', ufo.openAllFolds, { desc = 'openAllFolds' })
  Z.map('n', 'zM', ufo.closeAllFolds, { desc = 'closeAllFolds' })
end)

Z.later(function()
  vim.pack.add({ 'https://github.com/saghen/blink.indent' })
  require('blink.indent').setup({
    static = { char = '│' },
    scope = {
      char = '│',
      indent_at_cursor = true,
      highlights = { 'BlinkIndentScope' },
    },
  })
end)

Z.later(function()
  Z.add({ 'https://github.com/hedyhli/outline.nvim' })
  require('outline').setup({ outline_window = { position = 'left' } })
  Z.map('n', '<leader>bo', '<Cmd>Outline<CR>')
end)

Z.later(function()
  Z.add({ 'https://github.com/stevearc/conform.nvim' })
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

Z.later(function()
  vim.g.diffs = {
    integrations = {
      fugitive = true,
      gitsigns = true,
    },
  }

  Z.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/barrettruth/diffs.nvim',
  })

  Z.map('n', '<leader>gg', '<cmd>Git<CR>', { desc = 'open vimfugitive' })

  local setup_keymaps = function(buffer)
    local gs = package.loaded.gitsigns
    local map = function(l, r, desc, mode)
      local opts = { buffer = buffer, desc = desc, silent = true }
      vim.keymap.set(mode or 'n', l, r, opts)
    end

    map('<leader>gb', gs.blame, 'git blame buffer')
    map('<leader>gB', gs.toggle_current_line_blame, 'git blame line')
    map('<leader>gi', gs.preview_hunk_inline, 'git preview hunk inline')
    map('<leader>gp', gs.preview_hunk, 'git preview hunk')
    map('<leader>gp', gs.preview_hunk, 'git preview hunk')
    map('<leader>gq', gs.setqflist, 'git to qf')
    map('<leader>g-', gs.stage_hunk, 'git toggle hunk', { 'n', 'x' })
    map('<leader>gr', gs.reset_hunk, 'git reset hunk', { 'n', 'x' })

    map(']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end, 'Next Hunk')

    map('[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end, 'Prev Hunk')
  end

  require('gitsigns').setup({
    on_attach = setup_keymaps,
    sign_priority = 20,
  })
end)

Z.later(function()
  vim.pack.add({
    { src = 'https://github.com/dmtrKovalenko/fff.nvim', version = 'v0.9.4' },
  })

  Z.on_packchanged(
    'fff.nvim',
    { 'install', 'update' },
    function() require('fff.download').download_or_build_binary() end
  )

  vim.g.fff = {
    lazy_sync = true,
    preview = { enabled = false },
    prompt = '> ',
    -- debug = { enabled = true, show_scores = true },
  }

  vim.keymap.set(
    'n',
    '<leader> ',
    '<cmd>lua require("fff").find_files()<cr>',
    { desc = 'pick files' }
  )

  vim.keymap.set(
    'n',
    '<leader>pg',
    '<cmd>lua require("fff").live_grep()<cr>',
    { desc = 'live grep' }
  )

  vim.keymap.set(
    'n',
    '<leader>,',
    '<cmd>lua require("fff").find_files_in_dir(vim.fn.stdpath("config"))<cr>',
    { desc = 'pick neovim config' }
  )
end)

Z.later(function()
  Z.add({
    'https://github.com/nvim-lua/plenary.nvim',
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  })
  local harpoon = require('harpoon')
  harpoon:setup()

  Z.map('n', '<leader>a', function() harpoon:list():add() end)
  Z.map(
    'n',
    '<leader>h',
    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
  )

  for i = 1, 9 do
    Z.map('n', '<leader>' .. i, function() harpoon:list():select(i) end)
  end
end)

Z.on_filetype('markdown', function()
  vim.g.preview = { markdown = true }
  vim.pack.add({ 'https://git.barrettruth.com/barrettruth/preview.nvim' })
end)

Z.on_filetype('markdown', function()
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
  require('render-markdown').setup({
    anti_conceal = { disabled_modes = { 'n' } },
  })
end)
