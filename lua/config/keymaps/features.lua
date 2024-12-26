---Fluent interface to switch several key mappings
---@class KeymapFeatures
local M = {}

---Enable emacs-like editing in the command line
---@param cedit? string Mapping to use for bringing the command window
---(This is <C-f> in vanilla vim, but emacs mode uses <C-f> to move right).
---In not specified, it will be changed to "<C-g>"
---@return KeymapFeatures
function M.useEmacsCommandMode(cedit)
  vim.keymap.set('c', '<C-a>', '<Home>', { desc = 'Beginning of line' })
  vim.keymap.set('c', '<C-e>', '<End>', { desc = 'End of line' })
  vim.keymap.set('c', '<C-f>', '<Right>', { desc = 'Right' })
  vim.keymap.set('c', '<C-b>', '<Left>', { desc = 'Left' })
  vim.keymap.set('c', '<A-f>', '<C-Right>', { desc = 'One word right' })
  vim.keymap.set('c', '<A-b>', '<C-Left>', { desc = 'One word left' })
  vim.keymap.set('c', '<C-d>', '<Del>', { desc = 'Delete right' })
  vim.opt.cedit = cedit or '<C-g>'

  return M
end

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
