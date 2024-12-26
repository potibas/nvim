---Path helpers
---@class PathHelpers
local M = {}

---Return the path to Neovim's config directory.
---@return string
function M.neovim_config_dir()
  return vim.fn.fnamemodify(vim.fn.stdpath('config'), ':p:~:.')
end

---Return the path to the current buffer's file directory
---@return string
function M.current_buffer_dir()
  return vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
end

return M
