return {
  {
    "NeogitOrg/neogit",
    opts = {
      graph_style = "kitty",
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame<cr>" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>" },
      { "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>" },
      { "]h", "<cmd>Gitsigns next_hunk<cr>" },
      { "<leader>gh", "<cmd>Gitsigns setqflist<cr>" },
      { "<leader>g-", ":Gitsigns stage_hunk<cr>", mode = { "n", "v" } },
      { "<leader>gr", ":Gitsigns reset_hunk<cr>", mode = { "n", "v" } },
    },
  },

  { -- "tpope/vim-fugitive",
    "tpope/vim-fugitive",
    cond = false,
    dependencies = "lewis6991/gitsigns.nvim",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gg", "<cmd>vertical Git<cr><cmd>vert resize 70<cr>" },
      { "<leader>gs", "<cmd>Git difftool --name-status<cr>" },
    },
  },
}
