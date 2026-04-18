Z.now_if_args(function()
  Z.add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  Z.add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
    checkout = 'master',
  })
  Z.add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  })

  require('nvim-treesitter').install({ 'lua', 'python', 'go' })
  Z.create_autocmd('FileType', { 'lua', 'py', 'go' }, function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end, 'setup treesitter')

  require('nvim-treesitter-textobjects').setup({})

  require('treesitter-context').setup({
    trim_scope = 'outer',
    mode = 'topline',
    max_lines = 5,
    min_window_height = 20,
  })
end)
