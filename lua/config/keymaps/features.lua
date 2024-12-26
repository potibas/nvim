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

-- Reference: https://github.com/ibhagwan/nvim-lua/blob/82accf3aac/lua/utils.lua#L233
--
-- expand or minimize current buffer in a more natural direction (tmux-like)
-- ':resize <+-n>' or ':vert resize <+-n>' increases or decreasese current
-- window horizontally or vertically. When mapped to '<leader><arrow>' this
-- can get confusing as left might actually be right, etc
-- the below can be mapped to arrows and will work similar to the tmux binds
-- map to: "<cmd>lua require'utils'.resize(false, -5)<CR>"
function resize_window(vertical, margin)
  local cur_win = vim.api.nvim_get_current_win()
  -- go (possibly) right
  vim.cmd(string.format('wincmd %s', vertical and 'l' or 'j'))
  local new_win = vim.api.nvim_get_current_win()

  -- determine direction cond on increase and existing right-hand buffer
  local not_last = not (cur_win == new_win)
  local sign = margin > 0

  -- go to previous window if required otherwise flip sign
  if not_last == true then
    vim.cmd([[wincmd p]])
  else
    sign = not sign
  end

  local sign_str = sign and '+' or '-'
  local dir = vertical and 'vertical ' or ''
  local cmd = dir .. 'resize ' .. sign_str .. math.abs(margin) .. '<CR>'
  vim.cmd(cmd)
end

---Adds normal mode mappings to resize the windows "Tmux-style"
---(considering the direction)
---@param left_lhs string
---@param down_lhs string
---@param up_lhs string
---@param right_lhs string
---@return KeymapFeatures
function M.tmuxStyleWindowResize(left_lhs, down_lhs, up_lhs, right_lhs)
  local f = require('lib.functions')
  map('n', left_lhs, f.wrap(resize_window, true, -2), 'Resize Split Left')
  map('n', down_lhs, f.wrap(resize_window, false, 2), 'Resize Split Down')
  map('n', up_lhs, f.wrap(resize_window, false, -2), 'Resize Split Up')
  map('n', right_lhs, f.wrap(resize_window, true, 2), 'Resize Split Right')

  return M
end

---Adds a normal mode mapping to toggle the quickfix window.
---@param lhs string
---@return KeymapFeatures
function M.toggleQuickfixWindow(lhs)
  local f = require('lib.functions')
  map('n', lhs, f.toggleQuickfix, 'Toggle Quickfix Window')

  return M
end

---Changes the `p` mapping so it doesn't replace the register with the
---exixting text when pasting.
---@return KeymapFeatures
function M.dontReplaceRegisterWhenPasting()
  map_silent('x', 'p', '"_dP', 'Paste')

  return M
end

---Adds mappings to move around in insert mode.
---@param left_lhs string
---@param down_lhs string
---@param up_lhs string
---@param right_lhs string
---@return KeymapFeatures
function M.insertModeMovementKeys(left_lhs, down_lhs, up_lhs, right_lhs)
  map('i', left_lhs, '<Left>', 'Left')
  map('i', down_lhs, '<Down>', 'Down')
  map('i', up_lhs, '<Up>', 'Up')
  map('i', right_lhs, '<Right>', 'Right')

  return M
end

---Adds a normal mode mapping to delete the file and the current buffer.
---@param lhs string
---@return KeymapFeatures
function M.forceDelete(lhs)
  map_silent('n', lhs, function()
    vim.fn.delete(vim.fn.expand('%'))
    vim.cmd.bdelete({ bang = true })
  end, 'Delete(!) the current file')

  return M
end

return M
