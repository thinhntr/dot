return { -- "folke/snacks.nvim"
  "folke/snacks.nvim",
  priority = 4000,
  lazy = false,
  opts = {
    styles = {
      notification = { wo = { wrap = true } },
    },
    statuscolumn = {},
    notifier = { timeout = 10000 },
    indent = {
      indent = { char = "╎" },
      scope = { char = "╎" },
      animate = { enabled = false },
    },
    picker = {
      layout = { preset = "ivy", preview = false },
      matcher = { frecency = true },

      formatters = { file = { truncate = 120 } },
    },
    scope = {
      keys = {
        jump = {
          ["[i"] = { cursor = true },
          ["]i"] = { cursor = true },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>fp", function() Snacks.picker() end, desc = "snacks picker", },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "snacks notification history", },
    { "<leader>fr", function() Snacks.picker.resume() end, desc = "find resume", },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "find help", },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "find keymaps", },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "find buffers", },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "find diagnostics", },
    { "<leader>fg", function() Snacks.picker.grep({ hidden = true }) end, desc = "grep", },
    { "<leader>ff", function() Snacks.picker.git_files() end, desc = "find git files", },
    { "<leader>fw", function() Snacks.picker.grep({ dirs = { vim.api.nvim_buf_get_name(0) } }) end, desc = "grep in current buf" },
    { "<leader><leader>", function() Snacks.picker.files({ hidden = true }) end, desc = "find all files", },
    { "<leader>fn", function() Snacks.picker.files({
          hidden = true,
          cwd = vim.env.HOME .. "/projects/dot",
        })
      end,
      desc = "find neovim config files",
    },

    { "grr", function() Snacks.picker.lsp_references() end, desc = "snacks references" },
    { "gri", function() Snacks.picker.lsp_implementations() end, desc = "snacks implementations" },
    { "grd", function() Snacks.picker.lsp_definitions() end, desc = "snacks definitions" },
    { "gO", function() Snacks.picker.lsp_symbols() end, desc = "snacks symbols" },
    { "gW", function() Snacks.picker.lsp_workspace_symbols() end, desc = "snacks workspace_symbols" },
    { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "snacks type_definitions" },

    -- stylua: ignore end
  },
}
