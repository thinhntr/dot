Z.on_event('CursorMoved', function()
  Z.add('https://github.com/rafamadriz/friendly-snippets')
  Z.add({
    source = 'https://github.com/saghen/blink.cmp',
    checkout = 'v1.9.1',
  })

  require('blink.cmp').setup({
    signature = { enabled = true },
    keymap = {
      ['<Tab>'] = false,
      ['<S-Tab>'] = false,
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
      ['<C-s>'] = { 'show_signature', 'hide_signature' },
    },
    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    completion = {
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = MiniIcons.get('lsp', ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = MiniIcons.get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  })
end)
