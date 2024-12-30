---General helper functions
---@class Helpers
local M = {}

---Return a function that calls the given function with the given arguments.
function M.wrap(fn, ...)
  local args = { ... }

  return function()
    return fn(unpack(args))
  end
end

---Returns a function that will call the function `fun` with the given arguments in protected mode.
---The returned function returns true and `fun`'s result in case of success; otherwise, false plus the error object.
---@generic T
---@param fun   fun(): T
---@param ...   any
---@return fun(): (success:boolean, result:T)
function M.pcaller(fun, ...)
  local args = { ... }

  return function()
    return pcall(fun, unpack(args))
  end
end

---Switches the quickfix list window between visible and invisible.
function M.toggleQuickfix()
  local qf = vim.tbl_filter(function(win)
    return win.quickfix == 1 and win.loclist == 0
  end, vim.fn.getwininfo())

  if #qf > 0 then
    --- visible, make invisible ("toggle off")
    for _, win in ipairs(qf) do
      vim.api.nvim_win_hide(win.winid)
    end
  else
    --- no windows, create one and move down ("toggle on")
    vim.cmd.copen()
    vim.cmd.wincmd('J')
  end
end

---Saves all open buffers and reloads Neovim.
---@param force? boolean If `true`, discards any pending changes and ignores any warning.
function M.saveAllAndReload(force)
  if force then
    pcall(vim.cmd.wall)
    vim.cmd.cq({ bang = true })
  else
    vim.cmd.wall()
    vim.cmd.cq()
  end
end

return M
