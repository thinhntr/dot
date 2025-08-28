return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { "echasnovski/mini.align", version = false, opts = {} },

  {
    "tpope/vim-surround",
    keys = { "ys", "ds", "cs" },
    dependencies = "tpope/vim-repeat",
  },

  { -- "catppuccin/nvim",
    "catppuccin/nvim",
    lazy = false,
    priority = 412049,
    name = "catppuccin",
    cond = true,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        float = {
          transparent = true,
          solid = true,
        },
        no_italic = true,
        no_bold = true,
        dim_inactive = {
          enabled = true,
          ---@diagnostic disable-next-line: assign-type-mismatch
          shade = "crust",
          percentage = 0.15,
        },
        color_overrides = {
          macchiato = {
            base = "#232136", -- original = "#24273a"
            mantle = "#2a273f", -- original = "#1e2030"
            crust = "#393552", -- original = "#181926"
            green = "#89ced9", -- original = "#a6da95"
            pink = "#e68ca5", -- original = "#f5bde6"
          },
        },
        integrations = {
          ufo = false,
          snacks = {
            enabled = true,
            indent_scope_color = "lavender",
          },
          navic = {
            enabled = true,
            custom_bg = "NONE",
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
    dependencies = {
      "echasnovski/mini.icons",
      version = false,
      opts = {},
    },
  },

  { -- "kevinhwang91/nvim-ufo"
    "kevinhwang91/nvim-ufo",
    event = "CursorMoved",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      local ufo = require("ufo")
      ufo.setup({})

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
