return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install({ "go" })
      vim.api.nvim_create_autocmd("FileType", {
        -- enable highlight
        group = vim.api.nvim_create_augroup("tsconfig", { clear = true }),
        pattern = { "go", "lua" },
        callback = function()
          vim.treesitter.start() -- enable highlight
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  { -- "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    branch = "master",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      trim_scope = "outer",
      mode = "topline",
      max_lines = 5,
      min_window_height = 20,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = {},
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@function.outer",
            "textobjects"
          )
        end,
        mode = { "x", "o" },
        desc = "select outer function",
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject(
            "@function.inner",
            "textobjects"
          )
        end,
        mode = { "x", "o" },
        desc = "select inner function",
      },
    },
  },
}
