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
  local paths = require('lib.paths')
  map_expr('c', lhs, paths.current_buffer_dir, "Current buffer's directory")

  return M
end

-- Add a mapping to expand Neovim's config directory on command line mode.
---@param lhs string
---@return KeymapFeatures
function M.expandNeovimConfigDirectory(lhs)
  local paths = require('lib.paths')
  map_expr('c', lhs, paths.neovim_config_dir, 'Neovim config directory')

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

---Add visual/insert/normal mode mappings to move entire lines up and down.
---@param lhs_down string
---@param lhs_up string
---@return KeymapFeatures
function M.moveLinesAround(lhs_down, lhs_up)
  map_silent('i', lhs_down, '<esc><cmd>m .+1<cr>==gi', 'Move Down')
  map_silent('i', lhs_up, '<esc><cmd>m .-2<cr>==gi', 'Move Up')
  map_silent('n', lhs_down, '<cmd>m .+1<cr>==', 'Move Down')
  map_silent('n', lhs_up, '<cmd>m .-2<cr>==', 'Move Up')
  map_silent('v', lhs_down, ":m '>+1<cr>gv=gv", 'Move Down')
  map_silent('v', lhs_up, ":m '<-2<cr>gv=gv", 'Move Up')

  return M
end

local function blanks_below()
  local line = vim.fn.line('.')

  local blanks = {}
  for i = 1, vim.v.count1 do
    blanks[i] = ''
  end

  vim.api.nvim_buf_set_lines(0, line, line, true, blanks)
end

local function blanks_above()
  local line = vim.fn.line('.')

  local blanks = {}
  for i = 1, vim.v.count1 do
    blanks[i] = ''
  end

  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, blanks)
end

---Add normal mode mappings to insert blank lines above and below the cursor.
---@param lhs_above string
---@param lhs_below string
---@return KeymapFeatures
function M.insertBlankLines(lhs_above, lhs_below)
  map('n', lhs_above, blanks_above, 'Insert (count) line(s) above')
  map('n', lhs_below, blanks_below, 'Insert (count) line(s) below')

  return M
end

---Add normal mode mapping to change the word under cursor with repeat.
---@param lhs string
---@return KeymapFeatures
function M.replaceUnderCursor(lhs)
  map('n', lhs, '*``cgn', 'Change word under cursor (w/ repeat)')

  return M
end

---Causes the '*' mapping to keep the position after finding the first match
---in both visual and normal modes.
---@return KeymapFeatures
function M.starMatchKeepsPosition()
  -- TODO: show some visual feedback (how?)
  map_silent({ 'n', 'v' }, '*', '*``')

  return M
end

return M
