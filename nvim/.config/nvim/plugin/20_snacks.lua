Z.now(function()
  Z.add('https://github.com/folke/snacks.nvim')
  require('snacks').setup({
    statuscolumn = {},
    styles = { notification = { wo = { wrap = true } } },
    notifier = { timeout = 8000 },
    picker = {
      layout = { preset = 'ivy', preview = false },
      matcher = { frecency = true },
      formatters = { file = { truncate = 120 } },
    },
    indent = {
      indent = { char = '╎' },
      scope = { char = '╎' },
      animate = { enabled = false },
    },
    scope = {
      keys = {
        jump = {
          ['[i'] = { cursor = true },
          [']i'] = { cursor = true },
        },
      },
    },
  })

  Z.create_autocmd('FileType', { 'help', 'qf' }, function() vim.wo.stc = '' end)

  -- stylua: ignore start
  Z.map('n', 'grr', '<Cmd>lua Snacks.picker.lsp_references()<CR>')
  Z.map('n', 'gri', '<Cmd>lua Snacks.picker.lsp_implementations()<CR>')
  Z.map('n', 'grd', '<Cmd>lua Snacks.picker.lsp_definitions()<CR>')
  Z.map('n', 'grt', '<Cmd>lua Snacks.picker.lsp_type_definitions()<CR>')
  Z.map('n', 'gO',  '<Cmd>lua Snacks.picker.lsp_symbols()<CR>')
  Z.map('n', 'gW',  '<Cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>')

  Z.map('n', '<leader>fa', '<Cmd>lua Snacks.picker()<CR>')
  Z.map('n', '<leader>fh', '<Cmd>lua Snacks.picker.help()<CR>')
  Z.map('n', '<leader>fk', '<Cmd>lua Snacks.picker.key.maps()<CR>')
  Z.map('n', '<leader>fb', '<Cmd>lua Snacks.picker.buffers()<CR>')
  Z.map('n', '<leader>fr', '<Cmd>lua Snacks.picker.resume()<CR>')
  Z.map('n', '<leader>ft', '<Cmd>lua Snacks.notifier.show_history()<CR>')

  Z.map('n', '<leader>fg',       '<Cmd>lua Snacks.picker.grep({ hidden = true })<CR>')
  Z.map('n', '<leader><leader>', '<Cmd>lua Snacks.picker.files({ hidden = true })<CR>')
  -- stylua: ignore end

  Z.map(
    'n',
    '<leader>,',
    function()
      Snacks.picker.files({
        dirs = { vim.fn.stdpath('config') },
        hidden = true,
      })
    end,
    { desc = 'pick neovim config' }
  )

  Z.map('n', '<leader>fp', function()
    Snacks.picker.projects({
      win = {
        input = {
          keys = {
            ['<c-w>'] = { { '<c-s-w>' }, mode = { 'i' }, expr = true },
          },
        },
      },
      dev = {
        '~/.local/share/nvim/lazy',
        '~/projects',
        '~/tmp',
        vim.fn.stdpath('data'),
      },
      ---@param picker snacks.Picker
      ---@param item snacks.picker.Item
      confirm = function(picker, item)
        picker:close()
        local dir = item and item.file or nil
        if dir then
          vim.schedule(
            function() Snacks.picker.files({ hidden = true, dirs = { item.file } }) end
          )
        end
      end,
    })
  end, { desc = 'pick projects' })
end)
