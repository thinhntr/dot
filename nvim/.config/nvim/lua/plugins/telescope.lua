return { -- "nvim-telescope/telescope.nvim"
  "nvim-telescope/telescope.nvim",
  -- branch = "0.1.x",
  -- event = "VeryLazy",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local vimgrep_arguments =
      { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not
          -- `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
    pcall(telescope.load_extension, "fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set(
      "n",
      "<leader>fh",
      builtin.help_tags,
      { desc = "[F]ind [H]elp" }
    )
    vim.keymap.set(
      "n",
      "<leader>fk",
      builtin.keymaps,
      { desc = "[F]ind [K]eymaps" }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>",
      builtin.find_files,
      { desc = "Find files in current working directory" }
    )
    vim.keymap.set(
      "n",
      "<leader>fg",
      builtin.git_files,
      { desc = "Fuzzy search through the output of git ls-files" }
    )
    vim.keymap.set(
      "n",
      "<leader>fs",
      builtin.builtin,
      { desc = "[F]ind [S]elect Telescope" }
    )
    vim.keymap.set(
      "n",
      "<leader>fw",
      builtin.grep_string,
      { desc = "[F]ind current [W]ord" }
    )
    vim.keymap.set(
      "n",
      "<leader>ff",
      builtin.live_grep,
      { desc = "[F]ind by Grep" }
    )
    vim.keymap.set(
      "n",
      "<leader>fd",
      builtin.diagnostics,
      { desc = "[F]ind [D]iagnostics" }
    )
    vim.keymap.set(
      "n",
      "<leader>fr",
      builtin.resume,
      { desc = "[F]ind [R]esume" }
    )
    vim.keymap.set(
      "n",
      "<leader>fb",
      builtin.buffers,
      { desc = "[F]ind existing [b]uffers" }
    )

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>f/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[F]ind [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[F]ind [N]eovim files" })
  end,
}
