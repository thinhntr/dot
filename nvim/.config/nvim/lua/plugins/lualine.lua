return { -- "nvim-lualine/lualine.nvim",
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local opts = {
      options = {
        icons_enabled = false,
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s)
              return s:sub(1, 3)
            end,
            separator = { left = "" },
          },
        },
        lualine_b = {
          {
            "branch",
            fmt = function(s)
              return "%-00.20{ '" .. s .. "' }"
            end,
          },
        },
        lualine_c = {
          { "%-00.38{ expand('%:~:.') } %m", separator = {} },
          { "%=", separator = {} },
        },
        lualine_x = {
          { "diagnostics", separator = {} },
          { "lsp_status", separator = {} },
          { "diff", separator = {} },
        },
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          {
            "location",
            separator = { right = "" },
            padding = { left = 1, right = 0 },
          },
        },
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
