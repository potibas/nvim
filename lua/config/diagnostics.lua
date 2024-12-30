local icons = require('config.icons').wide
local severity = vim.diagnostic.severity

local colors = {
  Warn = '#d8a657',
  Info = '#7daea3',
  Error = '#ea6962',
  Hint = '#a9b665',
}

for key, value in pairs(colors) do
  vim.api.nvim_set_hl(
    0,
    'DiagnosticVirtualText' .. key,
    { fg = value, italic = true }
  )
end

---@type vim.diagnostic.Opts.VirtualText
local virtual_text = {
  spacing = 4,
  source = false,
  prefix = '',
}

vim.diagnostic.config({
  underline = true,
  severity_sort = false,
  update_in_insert = false,
  virtual_text = virtual_text,

  ---@type vim.diagnostic.Opts.Float
  float = {
    focusable = false,
    border = 'rounded',
    source = true, -- "if_many"
    -- style = 'minimal',
    -- header = '',
    -- prefix = '',
  },

  ---@type vim.diagnostic.Opts.Signs
  signs = {
    active = true,
    text = {
      [severity.ERROR] = icons.diagnostics.Error,
      [severity.WARN] = icons.diagnostics.Warn,
      [severity.HINT] = icons.diagnostics.Hint,
      [severity.INFO] = icons.diagnostics.Info,
    },
    linehl = {
      [severity.ERROR] = 'DiagnosticLineHighlightErr',
      [severity.WARN] = 'DiagnosticLineHighlightWarn',
      [severity.HINT] = 'DiagnosticLineHighlightHint',
      [severity.INFO] = 'DiagnosticLineHighlightInfo',
    },
    numhl = {
      [severity.ERROR] = 'DiagnosticSignError',
      [severity.WARN] = 'DiagnosticSignWarn',
      [severity.HINT] = 'DiagnosticSignHint',
      [severity.INFO] = 'DiagnosticSignInfo',
    },
  },
})

local function toggle_vtext()
  local config = vim.diagnostic.config()
  if config and config.virtual_text then
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.diagnostic.config({ virtual_text = virtual_text })
  end
end

local function toggle_diag()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

map(';uv', toggle_vtext, 'Toggle Diagnostic VirtualText')
map(';ud', toggle_diag, 'Toggle Diagnostics')
