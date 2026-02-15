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
vim.o.wrap = false
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
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.timeoutlen = 600
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
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
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

vim.keymap.set("n", "[e", function()
  vim.cmd.move("-" .. vim.v.count1 + 1)
end, { desc = "move current line up" })

vim.keymap.set("n", "]e", function()
  vim.cmd.move("+" .. vim.v.count1)
end, { desc = "move current line down" })

vim.keymap.set("x", ">", ">gv", { desc = "shift lines right nonstop" })
vim.keymap.set("x", "<", "<gv", { desc = "shift lines left nonstop" })

-- stylua: ignore start
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>zz", { desc = "quickfix next item" })
vim.keymap.set("n", "<C-p>", "<cmd>cprev<cr>zz", { desc = "quickfix prev item" })
-- stylua: ignore end

vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)
vim.keymap.set(
  "n",
  "<leader>bq",
  vim.diagnostic.setqflist,
  { desc = "diagnostic qflist" }
)

vim.keymap.set("n", "<leader>r", function()
  if vim.env.TMUX == nil or vim.env.TMUX == "" then
    vim.notify("run: failed. Not in tmux")
    return
  end
  local count = vim.fn.system("tmux list-panes | wc -l")
  if tonumber(count) < 2 then
    if vim.api.nvim_win_get_width(0) > 125 then
      vim.fn.system("tmux splitw -h -l 60")
    else
      vim.fn.system("tmux splitw -v -l 15")
    end
  end
  local cmd = "make"
  vim.system({ "tmux", "send-keys", "-t", ":.2", cmd, "Enter" })
  vim.notify("run: ok. " .. cmd)
end, { desc = "split tmux panes and run stuff" })

--[[
===================
| Troubleshoot    |
===================
--]]
local log_path = vim.env.HOME .. "/.nvim.log"

function Log(t)
  local file, err = io.open(log_path, "a+")
  if file == nil then
    vim.api.nvim_echo({ { "Log() failed: " .. err, "ErrorMsg" } }, true, {})
    return
  end

  local timestamp = tostring(os.date("%Y-%m-%dT%H:%M:%S%Z"))
  local msg = t and vim.inspect(t) or ""
  file:write(timestamp .. " " .. msg .. "\n")
  file:close()
end

vim.keymap.set("n", "<leader>fl", function()
  vim.cmd.edit(log_path)
end, { desc = "view nvim log file" })

--[[
===================
| autocommands    |
===================
--]]

local common_ag = vim.api.nvim_create_augroup("common_ag", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "vertical help",
  group = common_ag,
  pattern = "help",
  callback = function()
    if vim.api.nvim_win_get_width(0) > 125 then
      vim.cmd.wincmd("L")
      vim.cmd("vert res 80")
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "jump to the cursor position when last exiting the curent buffer",
  group = common_ag,
  callback = function()
    pcall(vim.cmd.normal, "'\"")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = common_ag,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Create BarBuf",
  group = common_ag,
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

-- cursorline
vim.api.nvim_create_autocmd("WinEnter", {
  desc = "enable cursorline for active win",
  group = vim.api.nvim_create_augroup("cul_ag", { clear = true }),
  callback = function()
    vim.o.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  desc = "disable cursorline for inactive win",
  group = "cul_ag",
  callback = function()
    if vim.bo.filetype == "qf" then
      return
    end
    vim.o.cursorline = false
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

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h16"
end
