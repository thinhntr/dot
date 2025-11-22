return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  {
    "thinhntr/mini.hues",
    cond = false,
    version = false,
    lazy = false,
    priority = 6000,
    opts = {
      -- winter
      background = "#1c2231",
      foreground = "#c4c7cd",
      n_hues = 7,
    },
  },

  {
    "folke/tokyonight.nvim",
    cond = true,
    priority = 7000,
    lazy = false,
    config = function()
      require("tokyonight").setup({})
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    opts = {
      overwrite = {
        undo = { enabled = true },
        redo = { enabled = true },
      },
      animations = { fade = { from_color = "CurSearch" } },
    },
  },

  {
    "ggandor/leap.nvim",
    lazy = false,
    keys = {
      { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "leap" },
    },
  },

  { -- "hedyhli/outline.nvim",
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle outline" } },
    opts = { outline_window = { position = "left" } },
  },

  { -- "kevinhwang91/nvim-ufo"
    "kevinhwang91/nvim-ufo",
    event = "CursorMoved",
    dependencies = "kevinhwang91/promise-async",
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    config = function()
      require("ufo").setup({})

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, {
        desc = "openAllFolds",
      })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, {
        desc = "ufo closeAllFolds",
      })
    end,
  },
}
