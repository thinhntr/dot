return {
  { -- "nvim-lualine/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = "ThePrimeagen/harpoon",
    opts = function()
      local harpoon = require("harpoon")

      -- Creating a harpoon component (barb) for lualine
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
          local delimiter = i < #harpoon:list().items and " " or ""
          local file = string.format("%d %s%s", i, fname, delimiter)
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
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            {
              "filename",
              path = 1,
              fmt = function(s)
                local maxwid = vim.o.columns < 95 and "40" or ""
                return "%-00." .. maxwid .. "{ '" .. s .. "' }"
              end,
            },
          },
          lualine_c = {},
          lualine_x = {
            {
              "diagnostics",
              fmt = function(s)
                return vim.o.columns < 120 and "" or s
              end,
            },
            {
              "lsp_status",
              fmt = function(s)
                return vim.o.columns < 80 and "" or s
              end,
            },
          },
          lualine_y = {
            {
              "diff",
              fmt = function(s)
                return vim.o.columns < 90 and "" or s
              end,
            },
            {
              "branch",
              fmt = function(s)
                if vim.o.columns < 80 then
                  return ""
                end
                if vim.o.columns < 110 then
                  return "%-00.25{ '" .. s .. "' }"
                end
                return s
              end,
            },
          },
          lualine_z = {
            { -- location
              function()
                return vim.o.columns < 110 and "%l|%v" or "%4l:%L|%2v"
              end,
            },
          },
        },
        tabline = {
          lualine_b = { { "tabs", mode = 1, show_modified_status = false } },
          lualine_c = { "navic" },
          lualine_y = { barb },
        },
      }
      return opts
    end,
  },

  {
    "SmiteshP/nvim-navic",
    event = "CursorMoved",
    opts = {
      lsp = { auto_attach = true },
      depth_limit = 5,
    },
  },
}
