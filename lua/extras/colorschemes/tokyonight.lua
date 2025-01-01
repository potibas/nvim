return {
  "folke/tokyonight.nvim",
  lazy = true,
  config = true,

  ---@class tokyonight.Config
  opts = {
    style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`

    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      variables = { bold = true },
    },

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    -- --- @param colors ColorScheme
    -- on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param hi tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(hi, colors)
      local utils = require("tokyonight.util")

      -- Search
      hi.Search = { italic = true, underline = true, fg = "yellow", bg = "NONE" }
      hi.CurSearch = { italic = true, underline = true, fg = "yellow", bold = true, bg = "NONE" }
      hi.IncSearch = { link = "Search" }

      -- Add contrast to some elements
      hi.Comment = { fg = utils.brighten(colors.comment, 0.2) }
      hi.DiagnosticUnnecessary = { fg = utils.brighten(colors.terminal_black, 0.3) }

      -- Make the line blame more visible
      hi.GitSignsCurrentLineBlame = { fg = colors.fg_float, italic = true }

      -- Clearer window divisions
      hi.WinSeparator = { fg = colors.orange }
      hi.NeoTreeWinSeparator = { fg = colors.orange }
    end,
  },
}

