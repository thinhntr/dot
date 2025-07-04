local ts_ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "go",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "typescript",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
  lazy = false,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = ts_ensure_installed,
  },
  dependencies = { -- "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      trim_scope = "outer",
      mode = "topline",
      max_lines = 6,
      min_window_height = 20,
    },
  },
}
