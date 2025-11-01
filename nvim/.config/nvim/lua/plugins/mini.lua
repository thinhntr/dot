return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    priority = 5000,
    config = function()
      local palette = require("mini.hues").make_palette({
        -- winter
        background = "#1c2231",
        foreground = "#c4c7cd",
        n_hues = 7,
      })
      require("mini.hues").apply_palette(palette)
      vim.api.nvim_set_hl(0, "NonText", { fg = palette.fg_mid2 })

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
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end, { desc = "MiniFiles.open" })
    end,
  },
}
