vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

--[[
===================
|  options         |
===================
--]]

-- appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "single"
vim.o.concealcursor = "nc"
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.guicursor = ""
vim.o.laststatus = 3 -- all windows use the same status line
vim.o.wrap = true
vim.o.breakindent = true -- wrapped line appears visually indented
vim.o.linebreak = true -- wrapped line don't break word
vim.o.scrolloff = 3
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.colorcolumn = ""
vim.o.splitright = true

-- tab
vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- zero -> uses 'tabstop'
vim.o.softtabstop = 0 -- zero -> off, negative -> uses 'shiftwidth'
vim.o.expandtab = true

-- behavior
vim.o.fixeol = false
vim.o.confirm = true -- confirm on save

-- diagnostic
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = not vim.g.have_nerd_font and {} or {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  virtual_text = true,
})

--[[
===================
| keymaps         |
===================
--]]

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "cursor to the right" })

vim.keymap.set("n", "n", "nzz", { desc = "next / and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "prev ? and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "down <C-d> and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "up <C-u> and center" })

vim.keymap.set("n", "<C-h>", "<C-w><C-w>", { desc = "cycle through windows" })
vim.keymap.set("n", "<C-q>", "<C-w><C-q>", { desc = "close window" })

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
vim.keymap.set({ "n", "v" }, "<leader>c", '"_c')
vim.keymap.set({ "n", "v" }, "<leader>C", '"_C')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y')

vim.keymap.set("x", ">", ">gv", { desc = "shift lines right nonstop" })
vim.keymap.set("x", "<", "<gv", { desc = "shift lines left nonstop" })

vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>", { desc = "quickfix next item" })
vim.keymap.set("n", "<C-p>", "<cmd>cprev<cr>", { desc = "quickfix prev item" })
vim.keymap.set(
  "n",
  "<leader>qq",
  vim.diagnostic.setqflist,
  { desc = "diagnostic qflist" }
)

vim.keymap.set("n", "<leader>r", function()
  local count = vim.fn.system("tmux list-panes | wc -l")
  if tonumber(count) < 2 then
    vim.fn.system("tmux splitw -h -b -l 60")
  end
  local cmd = "make"
  vim.system({ "tmux", "send-keys", "-t", ":.1", cmd, "Enter" })
  vim.notify("trunner: ok")
end, { desc = "split tmux panes and run stuff" })

--[[
===================
| autocommands    |
===================
--]]

--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Create BarBuf",
  group = vim.api.nvim_create_augroup("BarBufGroup", { clear = true }),
  pattern = { "*.bar" },
  callback = function()
    local barBufnr = vim.fn.bufnr("BarBuf")

    if barBufnr == -1 then
      barBufnr = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_name(barBufnr, "BarBuf")
    end

    if not _G.BarWin or not vim.api.nvim_win_is_valid(_G.BarWin) then
      local curWin = vim.api.nvim_get_current_win()
      vim.cmd.vsplit()
      _G.BarWin = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(_G.BarWin, barBufnr)
      vim.api.nvim_set_current_win(curWin)
    end

    vim.fn.jobstart({ "zsh", vim.fn.expand("%:p") }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        vim.api.nvim_buf_set_lines(barBufnr, -1, -1, false, data)
      end,
    })
  end,
})

--[[
===================
| lazy.nvim       |
===================
--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
