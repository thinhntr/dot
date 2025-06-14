local function kickstart_lsp_attach(event)
  local map = function(keys, func, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = event.buf })
  end

  map("grr", Snacks.picker.lsp_references)
  map("gri", Snacks.picker.lsp_implementations)
  map("grd", Snacks.picker.lsp_definitions)
  map("gO", Snacks.picker.lsp_symbols)
  map("gW", Snacks.picker.lsp_workspace_symbols)
  map("grt", Snacks.picker.lsp_type_definitions)

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if
    client
    and client:supports_method(
      vim.lsp.protocol.Methods.textDocument_documentHighlight,
      event.buf
    )
  then
    local highlight_augroup =
      vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
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
end

return {
  { -- "neovim/nvim-lspconfig", Main LSP Configuration
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
          "pyrefly",
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
    end,
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
      "echasnovski/mini.icons",
    },
    version = "1.*",
    opts = {
      signature = { enabled = true },
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
