return { -- "folke/snacks.nvim"
  "folke/snacks.nvim",
  priority = 412054,
  lazy = false,
  opts = {
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    notifier = {
      timeout = 10000,
    },
    picker = {
      layout = { preset = "ivy", preview = false },
      matcher = { frecency = true },
      formatters = {
        file = { truncate = 120 },
      },
    },
    indent = {
      enabled = true,
      animate = { enabled = false },
    },
    scope = {
      keys = {
        jump = {
          ["[i"] = { cursor = true },
          ["]i"] = { cursor = true },
        },
      },
    },
    statuscolumn = {},
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
        Snacks.picker.files({ hidden = true })
      end,
      desc = "find all files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.git_files()
      end,
      desc = "find git files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ hidden = true })
      end,
      desc = "grep",
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
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "find diagnostics",
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
        Snacks.picker.files({
          hidden = true,
          cwd = vim.env.HOME .. "/projects/dot",
        })
      end,
      desc = "find neovim config files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker()
      end,
      desc = "snacks picker",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "snacks notification history",
    },
  },
}
