Z.later(function()
  Z.add('https://github.com/mason-org/mason-lspconfig.nvim')
  Z.add('https://github.com/mason-org/mason.nvim')
  Z.add('https://github.com/neovim/nvim-lspconfig')
  Z.add('https://github.com/SmiteshP/nvim-navic')

  require('mason').setup({})
  require('mason-lspconfig').setup({
    automatic_enable = {
      exclude = { 'ruff', 'stylua' },
      ensure_installed = {},
      automatic_installation = false,
    },
  })

  vim.lsp.enable({ 'basedpyright' })

  require('nvim-navic').setup({
    lsp = { auto_attach = true },
    depth_limit = 5,
  })

  Z.on_filetype('lua', function()
    Z.add('https://github.com/folke/lazydev.nvim')
    require('lazydev').setup({
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    })
  end)
end)
