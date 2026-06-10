Z.now_if_args(function()
  local ts_update = function() vim.cmd('TSUpdate') end
  Z.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  -- stylua: ignore start
  Z.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',             version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main', },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',     version = 'master', },
  })
  -- stylua: ignore end

  require('nvim-treesitter').install({ 'lua', 'python', 'go' })
  Z.create_autocmd(
    'FileType',
    { 'lua', 'python', 'go', 'terraform', 'hcl' },
    function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
    'setup treesitter'
  )

  require('nvim-treesitter-textobjects').setup({})

  require('treesitter-context').setup({
    trim_scope = 'outer',
    mode = 'topline',
    max_lines = 5,
    min_window_height = 20,
  })
end)
