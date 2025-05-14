return { -- "folke/snacks.nvim"
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {},
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
  },
  keys = {
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "find help",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "find keymaps",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "find buffers",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.files()
      end,
      desc = "find files",
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "find all files",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word({ hidden = true })
      end,
      desc = "grep word or visual selection?",
      mode = { "n", "x" },
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.grep({ hidden = true })
      end,
      desc = "grep",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "find diagnostics",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "find git files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.resume()
      end,
      desc = "find resume",
    },
    {
      "<leader>fn",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "find neovim config files",
    },
  },
}
