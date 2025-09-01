return { -- "nvim-lualine/lualine.nvim",
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)

    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 9 do
      vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end)
    end

    -- show harpoon files in statusline
    local highlight = require("lualine.highlight")
    local barb = require("lualine.component"):extend()

    function barb:init(options)
      barb.super.init(self, options)
      self.options = self.options or {}
      self.hl_colors = {
        active = highlight.create_component_highlight_group(
          { fg = "#b7bdf8" },
          "barb_active",
          self.options
        ),
        inactive = highlight.create_component_highlight_group(
          { fg = "#6e738d" },
          "barb_inactive",
          self.options
        ),
      }
    end

    function barb:update_status()
      local root_dir = harpoon:list().config:get_root_dir()
      local current_filepath = vim.api.nvim_buf_get_name(0)
      local files = {}

      for i, item in ipairs(harpoon:list().items) do
        local filepath = item.value
        local fullpath = filepath
        if string.sub(filepath, 1, 1) ~= "/" then
          fullpath = root_dir .. "/" .. filepath
        end
        local active = fullpath == current_filepath
        local fname = vim.fn.fnamemodify(filepath, ":t")
        local file = string.format("%d %s  ", i, fname)
        local hl_file = highlight.component_format_highlight(
          active and self.hl_colors.active or self.hl_colors.inactive
        ) .. file
        table.insert(files, hl_file)
      end

      return table.concat(files, "")
    end

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
        lualine_c = { { barb } },
        lualine_x = {
          { "diagnostics", separator = {} },
          { "lsp_status", separator = {} },
          { "diff", separator = {} },
        },
        lualine_y = { "searchcount", "filetype", "progress" },
        lualine_z = {
          {
            "location",
            separator = { right = "" },
            padding = { left = 1, right = 0 },
          },
        },
      },
      winbar = {
        lualine_c = { { "navic", color_correction = "static" } },
        lualine_y = { { "filename", path = 1 } },
      },
    }

    return opts
  end,
  dependencies = {
    { -- "ThePrimeagen/harpoon",
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
}
