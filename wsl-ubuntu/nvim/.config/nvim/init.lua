_G.Z = {}

-- ┌──────────────────────┐
-- │ Troubleshoot helpers │
-- └──────────────────────┘

--- Inspect `x`. Notify and log result.
--- @param x any
--- @param tag string?
--- @param level vim.log.levels?
Z.log = function(x, tag, level)
  level = level or vim.log.levels.INFO

  -- Check who calls this `log` function
  local info = debug.getinfo(2, 'Sl')
  local filename = info.source:match('([^/\\]+)$')
  local location = filename .. ':' .. info.currentline

  -- Show notification msg
  tag = tag and tag .. '=' or ''
  local msg = location .. ' ' .. tag .. vim.inspect(x)
  vim.notify(msg, level)

  -- Log msg to file
  local log_path = vim.env.HOME .. '/.nvim.log'
  local file, err = io.open(log_path, 'a+')
  if file == nil then
    vim.api.nvim_echo({ { 'Log() failed: ' .. err, 'ErrorMsg' } }, true, {})
    return
  end

  local timestamp = tostring(os.date('%Y-%m-%dT%H:%M:%S%Z'))
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

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')
Z.add = vim.pack.add
Z.now = function(f) misc.safely('now', f) end
Z.later = function(f) misc.safely('later', f) end
Z.now_if_args = vim.fn.argc(-1) > 0 and Z.now or Z.later
Z.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Z.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

Z.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function (ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback(ev.data)
  end
  Z.create_autocmd('PackChanged', '*', f, desc)
end
