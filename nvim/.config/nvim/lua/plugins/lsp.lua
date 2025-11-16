return {
  { -- "neovim/nvim-lspconfig", Main LSP Configuration
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = {
          exclude = { "ruff", "stylua" },
        },
        ensure_installed = {},
        automatic_installation = false,
      })

      vim.lsp.config("rust_analyzer", {})
      vim.lsp.enable("rust_analyzer")
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
}
