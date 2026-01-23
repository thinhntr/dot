return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
        create = "split",
      },
    },
  },
  cmd = { "Sidekick" },
  keys = function()
    local default = "opencode"
    return {
      {
        "<leader>bn",
        function()
          require("sidekick.cli").toggle({ name = default })
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "x" },
      },
      {
        "<leader>bb",
        function()
          require("sidekick.cli").send({ name = default, msg = "{file}" })
        end,
        desc = "Sidekick send buffer",
      },
      {
        "<leader>bl",
        function()
          require("sidekick.cli").send({ name = default, msg = "{this}" })
        end,
        desc = "Sidekick send buffer with line + column",
        mode = { "n", "x" },
      },
      {
        "<leader>bs",
        function()
          require("sidekick.cli").send({ name = default, msg = "{selection}" })
        end,
        desc = "Sidekick send selection",
        mode = { "x" },
      },
    }
  end,
}
