Z.later(function()
  Z.add('https://github.com/mason-org/mason-lspconfig.nvim')
  Z.add('https://github.com/mason-org/mason.nvim')
  Z.add('https://github.com/neovim/nvim-lspconfig')
  require('mason').setup({})
  require('mason-lspconfig').setup({
    automatic_enable = {
      exclude = { 'ruff', 'stylua' },
      ensure_installed = {},
      automatic_installation = false,
    },
  })

  vim.lsp.enable({ 'basedpyright' })
end)

Z.on_filetype('lua', function()
  Z.add('https://github.com/folke/lazydev.nvim')
  require('lazydev').setup({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  })
end)
