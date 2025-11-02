return {
  {
    "thinhntr/mini.hues",
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
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    priority = 5000,
    config = function()
      require("mini.icons").setup({})
      require("mini.icons").mock_nvim_web_devicons()

      require("mini.ai").setup({
        n_lines = 10000,
        custom_textobjects = {
          f = require("mini.ai").gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
        },
      })

      require("mini.align").setup({})

      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
        },
      })
      vim.keymap.set("n", "yss", "ys_", {
        remap = true,
        desc = "Add surrounding linewise",
      })

      require("mini.files").setup({
        mappings = { go_in_plus = "l", synchronize = ":w" },
      })
      vim.keymap.set("n", "<leader>e", function()
        local path
        path = vim.api.nvim_buf_get_name(0)

        -- try getting parent directory
        if vim.fn.isdirectory(path) == 0 then
          path = vim.fn.fnamemodify(path, ":h")
        end

        -- set to nil if that directory doesn't exist, e.g. fugitive://...
        if not vim.uv.fs_stat(path) then
          path = nil
        end

        if not MiniFiles.close() then
          MiniFiles.open(path)
        end
      end, { desc = "MiniFiles.open" })
    end,
  },
}
