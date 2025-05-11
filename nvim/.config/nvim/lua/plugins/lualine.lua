return { -- "nvim-lualine/lualine.nvim",
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- local lualine_require = require("lualine_require")
    -- lualine_require.require = require

    local opts = {
      options = {
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_b = { "filename" },
        lualine_c = { "%{ expand('%:~:.:h') }", "%=" },
        lualine_x = { "diagnostics", "diff", "branch", "filetype" },
      },
    }

    local harpoon = require("harpoon")
    harpoon:setup()
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    local harpoon_component = {
      "harpoon2",
      indicators = {},
      active_indicators = {},
    }
    for i = 1, 9 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end)
      table.insert(harpoon_component.indicators, "" .. i)
      table.insert(harpoon_component.active_indicators, "[" .. i .. "]")
    end

    table.insert(opts.sections.lualine_c, harpoon_component)

    return opts
  end,
  dependencies = {
    "letieu/harpoon-lualine",
    { -- "ThePrimeagen/harpoon",
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
}
