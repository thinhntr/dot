_G.Z = {}

-- ┌──────────────────────┐
-- │ Troubleshoot helpers │
-- └──────────────────────┘
---@param x any
---@param tag string
---@param level vim.log.levels?
Z.notify = function(x, tag, level)
  level = level or vim.log.levels.DEBUG
  local info = debug.getinfo(2, 'Sl')
  local filename = info.source:match('([^/\\]+)$')
  local location = filename .. ':' .. info.currentline
  local msg = location .. ' ' .. tag .. '="' .. vim.inspect(x) .. '"'
  vim.notify(msg, level)

  local log_path = vim.env.HOME .. '/.nvim.log'
  local file, err = io.open(log_path, 'a+')
  if file == nil then
    vim.api.nvim_echo({ { 'Log() failed: ' .. err, 'ErrorMsg' } }, true, {})
    return
  end

  local timestamp = tostring(os.date('%Y-%m-%dT%H:%M:%S%Z'))
  msg = timestamp .. ' ' .. msg .. '\n'

  file:write(timestamp .. ' ' .. msg .. '\n')
  file:close()
end

-- ┌─────────────────┐
-- │ Autocmd helpers │
-- └─────────────────┘
local gr = vim.api.nvim_create_augroup('custom-config', { clear = true })
Z.create_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- ┌────────────────┐
-- │ Plugin helpers │
-- └────────────────┘
Z.map = vim.keymap.set

local mini_path = vim.fn.stdpath('data') .. '/site/pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local origin = 'https://github.com/nvim-mini/mini.nvim'
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', origin, mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup()

local misc = require('mini.misc')
Z.add = MiniDeps.add
Z.now = function(f) misc.safely('now', f) end
Z.later = function(f) misc.safely('later', f) end
Z.now_if_args = vim.fn.argc(-1) > 0 and Z.now or Z.later
Z.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Z.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end
