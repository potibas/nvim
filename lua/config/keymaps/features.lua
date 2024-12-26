---Fluent interface to switch several key mappings
---@class KeymapFeatures
local M = {}

local function map(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc })
end

local function map_silent(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc, silent = true })
end

local function map_expr(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc, expr = true })
end

---Enable emacs-like editing in the command line
---@param cedit? string Mapping to use for bringing the command window
---(This is <C-f> in vanilla vim, but emacs mode uses <C-f> to move right).
---In not specified, it will be changed to "<C-g>"
---@return KeymapFeatures
function M.useEmacsCommandMode(cedit)
  map('c', '<C-a>', '<Home>', { desc = 'Beginning of line' })
  map('c', '<C-e>', '<End>', { desc = 'End of line' })
  map('c', '<C-f>', '<Right>', { desc = 'Right' })
  map('c', '<C-b>', '<Left>', { desc = 'Left' })
  map('c', '<A-f>', '<C-Right>', { desc = 'One word right' })
  map('c', '<A-b>', '<C-Left>', { desc = 'One word left' })
  map('c', '<C-d>', '<Del>', { desc = 'Delete right' })
  vim.opt.cedit = cedit or '<C-g>'

  return M
end

---Makes <C-c> behave like <Esc> in insert mode.
---@return KeymapFeatures
function M.ctrlCBehavesLikeEscInInsertMode()
  map_silent('i', '<C-c>', '<Esc>', 'Exit insert mode')

  return M
end

local function ifwild(if_true, if_false)
  return function()
    return vim.fn.wildmenumode() == 1 and if_true or if_false
  end
end

---Switch functionality between the arrow keys and <C-p>/<C-n>
---(Use <C-p> and <C-n> to searches the command mode history, and
---<Up>/<Down> to cycle through all)
---@return KeymapFeatures
function M.commandModeHistorySwitch()
  map_expr('c', '<C-n>', ifwild('<C-n>', '<Down>'), 'Search History Backwards')
  map_expr('c', '<C-p>', ifwild('<C-p>', '<Up>'), 'Search History Forward')
  map_expr('c', '<Down>', ifwild('<Down>', '<C-n>'), 'Command History Prev')
  map_expr('c', '<Up>', ifwild('<Up>', '<C-p>'), 'Command History Next')

  return M
end

---Allows mapping <Tab> without <C-i> having to wait for the timeout
---@return KeymapFeatures
function M.enableTabAndCtrlI()
  map('n', '<C-i>', '<C-i>', 'Go to newer cursor position in jump llist.')
  map('n', '<Tab>', '<Tab>', 'Next tab stop')

  return M
end

-- Add a mapping to expand the directory for the current buffer
-- on command line mode.
---@param lhs string
---@return KeymapFeatures
function M.expandCurrentDirectory(lhs)
  map_expr('c', lhs, function()
    return vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
  end, "Current buffer's directory")

  return M
end

-- Add a mapping to expand Neovim's config directory on command line mode.
---@param lhs string
---@return KeymapFeatures
function M.expandNeovimConfigDirectory(lhs)
  map_expr('c', lhs, function()
    return vim.fn.fnamemodify(vim.fn.stdpath('config'), ':p:~:.')
  end, 'Neovim config directory')

  return M
end

---Add visual and normal mode mappings to jump to the start and end of line
---with H and L (mimicking Home and End keys on PCs).
---@return KeymapFeatures
function M.homeEndWithHL()
  map({ 'n', 'v' }, 'H', '^', 'Start of line')
  map({ 'n', 'v' }, 'L', 'g_', 'End of line')

  return M
end

return M
