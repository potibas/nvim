---Fluent interface to switch several key mappings
---@class KeymapFeatures
local M = {}

---Makes <C-c> behave like <Esc> in insert mode.
---@return KeymapFeatures
function M.ctrlCBehavesLikeEscInInsertMode()
  vim.keymap.set('i', '<C-c>', '<Esc>', {
    desc = 'Exit insert mode',
    silent = true,
  })

  return M
end

return M
