-- global variables
vim.g.mapleader = ' '
vim.g.have_nerd_font = true

-- appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.guicursor = ''
vim.o.laststatus = 3 -- all windows use the same status line
vim.o.wrap = false
vim.o.breakindent = true -- wrapped line appears visually indented
vim.o.linebreak = true -- wrapped line don't break word
vim.o.scrolloff = 3
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.winborder = 'single'
vim.o.concealcursor = 'nc'

-- tab
vim.o.tabstop = 2
vim.o.shiftwidth = 0 -- zero -> uses 'tabstop'
vim.o.softtabstop = 0 -- zero -> off, negative -> uses 'shiftwidth'
vim.o.expandtab = true

-- behavior
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fixeol = false
vim.o.confirm = true -- ask to save before exit

-- diagnostic
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  signs = {
    text = not vim.g.have_nerd_font and {} or {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})
