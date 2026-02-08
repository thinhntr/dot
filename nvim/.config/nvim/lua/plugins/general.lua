return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "stevearc/quicker.nvim", opts = {}, ft = "qf" },

  {
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup({})

      vim.api.nvim_create_autocmd("FileType", {
        desc = "nvim-terminal concealcursor",
        group = vim.api.nvim_create_augroup(
          "nvim-terminal_ag",
          { clear = true }
        ),
        pattern = "terminal",
        callback = function()
          vim.o.cocu = vim.o.cocu .. "v"
        end,
      })
    end,
  },

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
    "ggandor/leap.nvim",
    url = "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    keys = {
      { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "leap" },
    },
  },

  { -- "hedyhli/outline.nvim",
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>bo", "<cmd>Outline<CR>", desc = "Toggle outline" } },
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
