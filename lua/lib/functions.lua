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

return M
