return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { "nvim-mini/mini.align", version = false, opts = {}, keys = { "ga", "gA" } },
  {
    "nvim-mini/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = { n_lines = 10000 },
  },
  {
    "nvim-mini/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    lazy = false,
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",
      },
    },
    keys = {
      { "yss", "ys_", remap = true },
    },
  },
  {
    "nvim-mini/mini.files",
    version = false,
    opts = {
      mappings = {
        go_in_plus = "l",
        synchronize = ";",
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
    "nvim-mini/mini.hues",
    cond = true,
    lazy = false,
    priority = 5000,
    config = function()
      require("mini.hues").setup({
        background = "#1c2231",
        foreground = "#c4c7cd",
      })
      local palette = require("mini.hues").get_palette()
      vim.api.nvim_set_hl(0, "NonText", { fg = palette.fg_mid2 })
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
      -- vim.cmd.colorscheme("catppuccin")
    end,
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
