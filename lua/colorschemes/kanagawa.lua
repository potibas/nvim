return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  config = true,

  ---@module "kanagawa"
  ---@type KanagawaConfig
  opts = {
    compile = true,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
  },
}
