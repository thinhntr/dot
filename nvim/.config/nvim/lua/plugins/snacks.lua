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
    { "<leader>fr", function() Snacks.picker.resume() end, desc = "find resume", },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "find help", },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "find keymaps", },
    { "<leader>ft", function() Snacks.notifier.show_history() end, desc = "snacks notification history", },

    { "grr", function() Snacks.picker.lsp_references() end, desc = "snacks references" },
    { "gri", function() Snacks.picker.lsp_implementations() end, desc = "snacks implementations" },
    { "grd", function() Snacks.picker.lsp_definitions() end, desc = "snacks definitions" },
    { "gO", function() Snacks.picker.lsp_symbols() end, desc = "snacks symbols" },
    { "gW", function() Snacks.picker.lsp_workspace_symbols() end, desc = "snacks workspace_symbols" },
    { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "snacks type_definitions" },
    -- stylua: ignore end

    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ hidden = true })
      end,
      desc = "grep",
    },
    {
      "<leader>fb",
      function()
        local filename = vim.api.nvim_buf_get_name(0)
        filename = vim.fs.normalize(filename)
        Snacks.picker.grep({ dirs = { filename } })
      end,
      desc = "grep in current buf",
    },
    {
      "<leader>fs",
      function()
        local dirname = vim.api.nvim_buf_get_name(0)
        dirname = vim.fs.dirname(dirname)
        dirname = vim.fs.normalize(dirname)
        Snacks.picker.grep({ dirs = { dirname } })
      end,
      desc = "grep in current directory",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "find all files",
    },
    {
      "<leader>fd",
      function()
        local dirname = vim.api.nvim_buf_get_name(0)
        dirname = vim.fs.dirname(dirname)
        dirname = vim.fs.normalize(dirname)
        Snacks.picker.files({ hidden = true, dirs = { dirname } })
      end,
      desc = "grep in current directory",
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
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("snacks_ag", { clear = true }),
      pattern = "help",
      command = "setlocal stc=",
    })
  end,
}
