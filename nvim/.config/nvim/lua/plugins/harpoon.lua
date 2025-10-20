return { -- "ThePrimeagen/harpoon",
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  opts = {},
  keys = function()
    local harpoon = require("harpoon")
    local keys = {
      {
        "<leader>h",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon menu",
      },
      {
        "<leader>a",
        function()
          harpoon:list():add()
        end,
        desc = "harpoon add",
      },
    }
    for i = 1, 9 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          harpoon:list():select(i)
        end,
        desc = "harpoon select " .. i,
      })
    end
    return keys
  end,
}
