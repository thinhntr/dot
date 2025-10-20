return {
  { "NMAC427/guess-indent.nvim", opts = {} },

  { "norcalli/nvim-terminal.lua", opts = {}, ft = "terminal" },

  { -- "hedyhli/outline.nvim",
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" } },
    opts = { outline_window = { position = "left" } },
  },

  { -- "kevinhwang91/nvim-ufo"
    "kevinhwang91/nvim-ufo",
    event = "CursorMoved",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99

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
