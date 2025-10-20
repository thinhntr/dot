return { -- "saghen/blink.cmp",
  "saghen/blink.cmp",
  event = "CursorMoved",
  dependencies = {
    "nvim-mini/mini.nvim",
    "rafamadriz/friendly-snippets",
  },
  version = "1.*",
  opts = {
    signature = { enabled = true },
    keymap = {
      ["<Tab>"] = false,
      ["<S-Tab>"] = false,
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature" },
    },
    sources = {
      providers = {
        lazydev = {
          module = "lazydev.integrations.blink",
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
                local kind_icon, _, _ =
                  require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  },
}
