return {
  'stevearc/oil.nvim',

  dependencies = {
    'echasnovski/mini.icons',
    'nvim-tree/nvim-web-devicons',
  },

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {

    use_default_keymaps = false,
    keymaps = {
      ['g?'] = { 'actions.show_help', mode = 'n' },

      ['<CR>'] = 'actions.select',
      ['<C-j>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-l>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = { 'actions.close', mode = 'n' },

      ['<C-o>'] = { 'actions.parent', mode = 'n' },
      ['<C-i>'] = { 'actions.select', mode = 'n' },
      ['<C-.>'] = { 'actions.toggle_hidden', mode = 'n' },

      ['q'] = { 'actions.close', mode = 'n' },
      ['r'] = { 'actions.refresh', mode = 'n' },
      ['/'] = { 'actions.open_cwd', mode = 'n' },

      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
    },

    skip_confirm_for_simple_edits = true,
  },

  keys = {
    -- stylua: ignore start
    { '<Space>oe', function() require('oil').open_float() end, desc = 'Open File Explorer' },
    { ';ue', function() require('oil').toggle_float() end, desc = 'Toggle File Explorer - <F2>' },
    { '<F2>', function() require('oil').toggle_float() end, desc = 'Toggle File Explorer' },
    -- stylua: ignore end
  },
}
