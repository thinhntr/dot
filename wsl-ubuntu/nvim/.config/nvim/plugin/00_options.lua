-- global variables
vim.g.mapleader = ' '

-- appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.fillchars = 'diff: '
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
vim.o.concealcursor = 'n'
vim.o.pumheight = 10
vim.o.pumborder = 'rounded'
vim.o.winborder = 'rounded'
-- vim.o.colorcolumn = '120'

-- tab
vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- zero -> uses 'tabstop'
vim.o.softtabstop = 0 -- zero -> off, negative -> uses 'shiftwidth'
vim.o.expandtab = true

-- behavior
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fixeol = false
vim.o.confirm = true -- ask to save before exit
vim.opt.diffopt:append('algorithm:patience')

-- diagnostic
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})
