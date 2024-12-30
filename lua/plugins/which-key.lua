local icons = require('config.icons')

return {
  'folke/which-key.nvim',

  event = 'VeryLazy',

  opts_extend = { 'triggers', 'spec' },

  ---@module "which-key"
  ---@type wk.Opts;
  opts = {
    preset = 'modern',

    triggers = {
      { ';', mode = { 'n' } },
      { '<Space>', mode = { 'n' } },
      { '<C-w>', mode = { 'n' } },
      { '<C-\\>', mode = { 'n' } },
      { ']', mode = { 'n' } },
      { '[', mode = { 'n' } },
      { 'a', mode = 'v' },
      { 'i', mode = 'v' },
      { 'g', mode = 'n' },
    },

    icons = {
      group = icons.spaced.misc.PlusSquare,
      breadcrumb = icons.spaced.misc.DoubleChevronRight,
      separator = icons.spaced.arrows.Right,
      ellipsis = icons.spaced.misc.Ellipsis,

      mappings = false,
      rules = false,

      keys = {
        CR = icons.wide.keys.CR,
        NL = icons.wide.keys.CR,
        F1 = icons.wide.keys.F1,
        F2 = icons.wide.keys.F2,
        F3 = icons.wide.keys.F3,
        F4 = icons.wide.keys.F4,
        F5 = icons.wide.keys.F5,
        F6 = icons.wide.keys.F6,
        F7 = icons.wide.keys.F7,
        F8 = icons.wide.keys.F8,
        F9 = icons.wide.keys.F9,
        F10 = icons.wide.keys.F10,
        Esc = icons.wide.keys.Esc,
        Space = icons.wide.keys.Space,
        Back = icons.wide.keys.Back,
      },
    },

    spec = {
      mode = { 'n' },
      { ';', group = 'Leader' },
      { '<Space>', group = 'Leader' },
      { '<C-w>', group = 'Window' },
      { '<C-\\>', group = 'System' },
      { '<Space>o', group = 'Open' },
      { ';c', group = 'Code' },
      { ';u', group = 'UI' },
      { ';r', group = 'Treesitter' },
      { ';s', group = 'Search' },

      -- Groups
      { 'g', group = 'Go to' },
      { '[', group = 'Previous' },
      { ']', group = 'Next' },
      { 'z', group = 'Fold' },

      -- Change descriptions for native mappings
      { 'K', desc = 'Display Hover Definition' },
      { '&', desc = 'Repeat last substitution' },
      { '%', desc = 'Jump to matching ([{}])' },
      { 'g%', desc = 'Jump back to matching ([{}])' },
      { 'Y', desc = 'Yank to the end of the line' },
      { 'gx', desc = 'Open item under cursor' },
    },
  },

  config = function(_, opts)
    require('config.keymaps.keycodes')

    local alt_replaces = {}
    for key, mapping in pairs(ALT) do
      alt_replaces[mapping] = string.format('<M-%s>', string.upper(key))
    end

    local overrides = {
      ['<S-NL>'] = '󰘴 󰘶 J',
      ['󰌒 '] = '󰘴 I',
      ['`'] = '`',
    }

    opts.replace = {
      key = {
        function(key)
          local format = require('which-key.view').format
          return overrides[key] or format(alt_replaces[key] or key)
        end,
      },

      desc = {
        function(desc)
          return icons.format(desc)
        end,
        { '<Plug>%(?(.*)%)?', '%1' },
        { '^%+', '' },
        { '<[cC]md>', '' },
        { '<[cC][rR]>', '' },
        { '<[sS]ilent>', '' },
        { '^lua%s+', '' },
        { '^call%s+', '' },
        { '^:%s*', '' },
        { 'Next ftFT', 'Leader' },
      },
    }

    require('which-key').setup(opts)
  end,
}
