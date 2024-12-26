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

---Switch functionality between the arrow keys and <C-p>/<C-n>
---(Use <C-p> and <C-n> to searches the command mode history, and
---<Up>/<Down> to cycle through all)
---@return KeymapFeatures
function M.commandModeHistorySwitch()
  vim.keymap.set('c', '<C-n>', function()
    return vim.fn.wildmenumode() == 1 and '<C-n>' or '<Down>'
  end, { desc = 'Search Command History Backwards', expr = true })

  vim.keymap.set('c', '<C-p>', function()
    return vim.fn.wildmenumode() == 1 and '<C-p>' or '<Up>'
  end, { desc = 'Search Command History Forward', expr = true })

  vim.keymap.set('c', '<Down>', function()
    return vim.fn.wildmenumode() == 1 and '<Down>' or '<C-n>'
  end, { desc = 'Command History Prev', expr = true })

  vim.keymap.set('c', '<Up>', function()
    return vim.fn.wildmenumode() == 1 and '<Up>' or '<C-p>'
  end, { desc = 'Command History Next', expr = true })

  return M
end

return M
