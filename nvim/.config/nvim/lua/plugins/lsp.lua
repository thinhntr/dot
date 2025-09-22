local function kickstart_lsp_attach(event)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    desc = desc or "n"
    pcall(vim.keymap.del, mode, keys)
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
  end

  map("grr", Snacks.picker.lsp_references, "snacks references")
  map("gri", Snacks.picker.lsp_implementations, "snacks implementations")
  map("grd", Snacks.picker.lsp_definitions, "snacks definitions")
  map("gO", Snacks.picker.lsp_symbols, "snacks symbols")
  map("gW", Snacks.picker.lsp_workspace_symbols, "snacks workspace_symbols")
  map("grt", Snacks.picker.lsp_type_definitions, "snacks type_definitions")

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if
    not client
    or not client:supports_method(
      vim.lsp.protocol.Methods.textDocument_documentHighlight,
      event.buf
    )
  then
    return
  end
  local hl_augroup =
    vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = event.buf,
    group = hl_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = event.buf,
    group = hl_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = vim.api.nvim_create_augroup(
      "kickstart-lsp-detach",
      { clear = true }
    ),
    callback = function(event2)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({
        group = "kickstart-lsp-highlight",
        buffer = event2.buf,
      })
    end,
  })
end

return {
  { -- "neovim/nvim-lspconfig", Main LSP Configuration
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "kickstart-lsp-attach",
          { clear = true }
        ),
        callback = kickstart_lsp_attach,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "gopls",
          "lua_ls",
          "basedpyright",
          "ruff",
          "stylua",
          "vimls",
        },
      })

      require("mason-lspconfig").setup({
        automatic_enable = {
          exclude = {
            "ruff",
          },
        },
        ensure_installed = {},
        automatic_installation = false,
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            typeCheckingMode = "basic",
          },
        },
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = { auto_attach = true },
      highlight = true,
    },
  },

  { -- "folke/lazydev.nvim"
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  { -- "saghen/blink.cmp",
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "nvim-mini/mini.icons",
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
      snippets = { preset = "luasnip" },
      completion = {
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          draw = {
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  return require("mini.icons").get("lsp", ctx.kind)
                end,
              },
            },
          },
        },
      },
    },
  },

  { -- "L3MON4D3/LuaSnip"
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {},
  },
}
