---@class ConfigIcons
local M = {
  icons = {},
  spaced = {},
  wide = {},
}

---Unicode En Space (U-2002)
local en_space = ' '

-- Unicode Em Space (U-2003)
local em_space = ' '

local function spaced(icon)
  return icon .. em_space
end

local function wide(icon)
  return icon .. en_space
end

local function add_icons(key, table)
  local sp = vim.tbl_map(spaced, table)
  local wd = vim.tbl_map(wide, table)

  M.icons[key] = table
  M.spaced[key] = sp
  M.wide[key] = wd
end

function M.get_key(key)
  return M.wide.keys[key] or ('<' .. key .. '>')
end

local function get_icon(key)
  return vim.tbl_get(M.icons, unpack(vim.split(key, '[.]')))
end

local function get_spaced(key)
  return vim.tbl_get(M.spaced, unpack(vim.split(key, '[.]')))
end

local function get_wide(key)
  return vim.tbl_get(M.wide, unpack(vim.split(key, '[.]')))
end

---Replace keys in the given text for their icons
---@param text string
---@return string
function M.format(text)
  local retval, _ = text
    :gsub('<icon:([%w.]+)>', get_icon)
    :gsub('<spaced:([%w.]+)>', get_spaced)
    :gsub('<wide:([%w.]+)>', get_wide)
    :gsub('<(%w+)>', M.get_key)

  return retval
end

add_icons('diagnostics', {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
})

add_icons('misc', {
  Bulb = '',
  BulbFilled = '',
  Comment = '',
  DoubleChevronRight = '»',
  Ellipsis = '',
  PlusSquare = '',
  Thunder = '',
})

add_icons('arrows', {
  CircleDown = '',
  CircleLeft = '',
  CircleRight = '',
  CircleUp = '',
  Right = '',
})

add_icons('keys', {
  Up = '',
  Down = '',
  Left = '',
  Right = '',
  Ctrl = '󰘴',
  Opt = '󰘵',
  Cmd = '󰘳',
  Shift = '󰘶',
  CR = '󰌑',
  Esc = '󱊷',
  ScrollWheelDown = '󱕐',
  ScrollWheelUp = '󱕑',
  NL = '󰌑',
  Backspace = '󰁮',
  Space = '󱁐',
  Tab = '󰌒',
  F1 = '󱊫',
  F2 = '󱊬',
  F3 = '󱊭',
  F4 = '󱊮',
  F5 = '󱊯',
  F6 = '󱊰',
  F7 = '󱊱',
  F8 = '󱊲',
  F9 = '󱊳',
  F10 = '󱊴',
  F11 = '󱊵',
  F12 = '󱊶',
})

return M
