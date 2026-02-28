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
  Z.map('n', '<leader>fk', '<Cmd>lua Snacks.picker.keymaps()<CR>')
  Z.map('n', '<leader>fb', '<Cmd>lua Snacks.picker.buffers()<CR>')
  Z.map('n', '<leader>fr', '<Cmd>lua Snacks.picker.resume()<CR>')
  Z.map('n', '<leader>ft', '<Cmd>lua Snacks.notifier.show_history()<CR>')

  -- Z.map('n', '<leader>fg',       '<Cmd>lua Snacks.picker.grep({ hidden = true })<CR>')
  -- Z.map('n', '<leader><leader>', '<Cmd>lua Snacks.picker.files({ hidden = true })<CR>')
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
    local finder = function()
      local res = vim.fn.systemlist('tt')
      local items = {}
      for _, item in ipairs(res) do
        items[#items + 1] = { text = item, file = item, dir = item }
      end
      return items
    end

    local confirm = function(picker, item)
      picker:close()
      local dirs = { item.dir }
      vim.schedule(
        function() Snacks.picker.files({ dirs = dirs, hidden = true }) end
      )
    end

    Snacks.picker({
      title = 'Projects',
      format = 'filename',
      finder = finder,
      confirm = confirm,
      live = false,
    })
  end, { desc = 'pick projects' })
end)
