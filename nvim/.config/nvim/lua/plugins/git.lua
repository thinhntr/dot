return {
  {
    "sindrets/diffview.nvim",
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>" } },
  },

  { -- "tpope/vim-fugitive",
    "tpope/vim-fugitive",
    dependencies = "lewis6991/gitsigns.nvim",
    cmd = { "Git", "G" },
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd("Git")
          if vim.api.nvim_win_get_width(0) > 125 then
            vim.cmd.wincmd("L")
          end
        end,
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(l, r, desc, mode)
          vim.keymap.set(
            mode or "n",
            l,
            r,
            { buffer = buffer, desc = desc, silent = true }
          )
        end

        map("<leader>gb", gs.blame, "git blame buffer")
        map("<leader>gB", gs.toggle_current_line_blame, "git blame line")
        map("<leader>gi", gs.preview_hunk_inline, "git preview hunk inline")
        map("<leader>gp", gs.preview_hunk, "git preview hunk")
        map("<leader>gp", gs.preview_hunk, "git preview hunk")
        map("<leader>gq", gs.setqflist, "git to qf")
        map("<leader>g-", gs.stage_hunk, "git toggle hunk", { "n", "x" })
        map("<leader>gr", gs.reset_hunk, "git reset hunk", { "n", "x" })

        map("]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")

        map("[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
      end,
    },
  },
}
