return {
  "folke/sidekick.nvim",
  opts = {},
  cmd = { "Sidekick" },
  keys = {
    {
      "<leader>ba",
      function()
        require("sidekick.cli").toggle({ name = "gemini" })
      end,
      desc = "Sidekick Toggle",
      mode = { "n", "x" },
    },
  },
}
