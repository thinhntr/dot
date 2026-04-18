Z.later(function()
-- Z.on_filetype('markdown', function()
  local post_checkout = function() vim.fn['mkdp#util#install']() end
  Z.add({
    source = 'https://github.com/iamcco/markdown-preview.nvim',
    hooks = { post_checkout = post_checkout },
  })

  vim.g.mkdp_filetypes = { 'markdown' }
end)
