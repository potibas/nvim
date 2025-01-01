return {
  'supermaven-inc/supermaven-nvim',
  cmd = 'SupermavenToggle',

  opts = {
    keymaps = {
      accept_suggestion = '<C-l>',
      clear_suggestion = '<C-e>',
      accept_word = '<C-j>',
    },
    suggestion_color = '#969fca',
    ignore_filetypes = {},
    disable_keymaps = false,
    disable_inline_completion = false,
    log_level = 'off',
  },

  keys = {
    { ';us', '<Cmd>SupermavenToggle<CR>', desc = 'Toggle Supermaven' },
  }
}
