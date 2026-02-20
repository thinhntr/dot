Z.later(function()
  Z.add('https://github.com/tpope/vim-fugitive')
  Z.map('n', '<leader>gg', function()
    vim.cmd('Git')
    if vim.api.nvim_win_get_width(0) > 125 then vim.cmd.wincmd('L') end
  end, { desc = 'open vimfugitive' })
end)

Z.later(function()
  Z.add('https://github.com/lewis6991/gitsigns.nvim')

  local setup_keymaps = function(buffer)
    local gs = package.loaded.gitsigns
    local map = function(l, r, desc, mode)
      local opts = { buffer = buffer, desc = desc, silent = true }
      vim.keymap.set(mode or 'n', l, r, opts)
    end

    map('<leader>gb', gs.blame, 'git blame buffer')
    map('<leader>gB', gs.toggle_current_line_blame, 'git blame line')
    map('<leader>gi', gs.preview_hunk_inline, 'git preview hunk inline')
    map('<leader>gp', gs.preview_hunk, 'git preview hunk')
    map('<leader>gp', gs.preview_hunk, 'git preview hunk')
    map('<leader>gq', gs.setqflist, 'git to qf')
    map('<leader>g-', gs.stage_hunk, 'git toggle hunk', { 'n', 'x' })
    map('<leader>gr', gs.reset_hunk, 'git reset hunk', { 'n', 'x' })

    map(']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end, 'Next Hunk')

    map('[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end, 'Prev Hunk')
  end

  require('gitsigns').setup({ on_attach = setup_keymaps })
end)
