return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    opts = {
      sources = {
        path = { max_depth = 0 },
      },
    },
  },

  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },

  {
    "tpope/vim-surround",
    keys = { "ys", "ds", "cs" },
    dependencies = "tpope/vim-repeat",
  },

  { "lewis6991/gitsigns.nvim", event = "VeryLazy" },

  { -- "tpope/vim-fugitive",
    "tpope/vim-fugitive",
    dependencies = "lewis6991/gitsigns.nvim",
    cmd = "Git",
    keys = { { "<leader>gg", vim.cmd.Git, desc = "vim-fugitive" } },
  },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { -- "catppuccin/nvim",
    "catppuccin/nvim",
    lazy = false,
    priority = 412049,
    name = "catppuccin",
    cond = true,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        no_italic = true,
        no_bold = true,
        color_overrides = {
          macchiato = {
            base = "#232136",
            mantle = "#232136",
          },
        },
        integrations = {
          snacks = {
            enabled = true,
            indent_scope_color = "lavender",
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  { -- "stevearc/oil.nvim",
    "stevearc/oil.nvim",
    lazy = vim.fn.argc(-1) == 0,
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
    },
    keys = { { "<leader>e", "<CMD>Oil<CR>" } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { -- "kevinhwang91/nvim-ufo"
    "kevinhwang91/nvim-ufo",
    event = "CursorMoved",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      local ufo = require("ufo")
      ufo.setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "ufo openAllFolds" })
      vim.keymap.set(
        "n",
        "zM",
        ufo.closeAllFolds,
        { desc = "ufo closeAllFolds" }
      )
    end,
  },
}
