vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[
===================
|  options         |
===================
--]]

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- zero -> uses 'tabstop'
vim.o.softtabstop = 0 -- zero -> off, negative -> uses 'shiftwidth'
vim.o.expandtab = true

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.o.concealcursor = "nc"

vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"

vim.o.laststatus = 3 -- all windows use the same status line
vim.o.showmode = false -- don't show the mode, it's in the status line

vim.o.scrolloff = 6
vim.o.fixeol = false
vim.o.guicursor = ""
vim.o.signcolumn = "auto"
vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.wrap = true
vim.o.breakindent = true

vim.o.winbar = " "
vim.o.winborder = "single"
vim.o.confirm = true -- confirm on save
vim.o.timeoutlen = 500 -- decrease mapped sequence wait time

vim.o.splitright = true
vim.o.splitbelow = false

--[[
===================
| keymaps         |
===================
--]]

vim.keymap.set("n", "Q", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "n", "nzz", { desc = "next / result and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "next ? result and center" })

-- window nav shortcuts
vim.keymap.set("n", "<C-h>", "<C-w><C-w>", { desc = "Cycle through windows" })
vim.keymap.set("n", "<C-q>", "<C-w><C-q>", { desc = "Close window" })

-- yank/delete shortcuts
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y')

-- shift shortcuts
vim.keymap.set("x", ">", ">gv", { desc = "shift right nonstop" })
vim.keymap.set("x", "<", "<gv", { desc = "shift left nonstop" })

-- execute stuff
vim.keymap.set(
  "n",
  "<leader>xc",
  "<CMD>!chmod +x %:p<CR>",
  { desc = "chmod +x current file" }
)
vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>! %:p<cr>",
  { desc = "execute current file" }
)
vim.keymap.set(
  "v",
  "<leader>xh",
  "y:let @9=substitute(@0, '\\\\*\\n', ' ', 'g')<CR>:!<C-r>9",
  { desc = "execute highlighted text" }
)

--[[
===================
| autocommands    |
===================
--]]

--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.replaceme" },
  group = vim.api.nvim_create_augroup("TmuxRunner", { clear = true }),
  callback = function()
    local count = vim.fn.system("tmux list-panes | wc -l")
    if tonumber(count) < 2 then
      vim.fn.system("tmux splitw -h")
    end
    vim.system({ "tmux", "send-keys", "-t", ":.2", "C-q" })
    vim.wait(300)
    local cmd = "uv run --dev main.py"
    vim.system({ "tmux", "send-keys", "-t", ":.2", cmd, "Enter" })
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
| diagnostic      |
===================
--]]
vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.keymap.set(
  "n",
  "<leader>qq",
  vim.diagnostic.setqflist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

vim.keymap.set(
  "n",
  "<leader>ql",
  vim.diagnostic.setloclist,
  { desc = "Open buffer diagnostic [L]ocation list" }
)

vim.keymap.set("n", "<leader>qv", function()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({ virtual_lines = false })
    vim.notify("diagnostic virtual lines disabled")
  else
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
    vim.notify("diagnostic virtual lines enabled")
  end
end, { desc = "Toggle virtual lines" })

--[[
===================
| DEBUG           |
===================
--]]
function P(t)
  vim.print(vim.inspect(t))
end

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
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = {
        "netrwPlugin",
        "tutor",
      },
    },
  },
})
