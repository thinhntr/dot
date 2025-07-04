return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { "echasnovski/mini.align", version = false, opts = {} },

  {
    "tpope/vim-surround",
    keys = { "ys", "ds", "cs" },
    dependencies = "tpope/vim-repeat",
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    opts = function()
      local sources = require("dropbar.configs").opts.sources
      local ts_valid_types = vim.tbl_filter(function(value)
        return value ~= "pair"
      end, sources.treesitter.valid_types)

      return {
        sources = {
          path = { max_depth = 0 },
          treesitter = {
            valid_types = ts_valid_types,
          },
        },
      }
    end,
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
        no_italic = true,
        no_bold = true,
        color_overrides = {
          macchiato = {
            base = "#232136",
            mantle = "#232136",
          },
        },
        integrations = {
          ufo = false,
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
