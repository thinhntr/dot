return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { "nvim-mini/mini.align", version = false, opts = {} },

  { "nvim-mini/mini.ai", version = false, opts = { n_lines = 500 } },

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
    enabled = false,
    lazy = vim.fn.argc(-1) == 0,
    opts = {
      default_file_explorer = false,
      view_options = { show_hidden = true },
    },
    keys = { { "<leader>k", "<CMD>Oil<CR>" } },
    dependencies = {
      "nvim-mini/mini.icons",
      version = false,
      opts = {},
    },
  },

  {
    "nvim-mini/mini.files",
    version = false,
    opts = {
      mappings = {
        go_in_plus = "<cr>",
      },
    },
    keys = {
      {
        "<leader>e",
        "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" } },
    opts = {
      outline_window = {
        position = "left",
      },
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
