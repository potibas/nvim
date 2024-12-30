require('config.keymaps')
require('config.keymaps.keycodes')

local function find_config_file()
  local paths = require('lib.paths')
  require('fzf-lua').files({ cwd = paths.neovim_config_dir() })
end

return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.icons',
  },

  opts = function()
    local actions = require('fzf-lua.actions')

    return {
      help_open_win = function(buf, enter, opts)
        opts.border = 'single'
        opts.row = 0
        opts.col = 0
        return vim.api.nvim_open_win(buf, enter, opts)
      end,

      grep = {
        actions = {
          ['ctrl-i'] = { actions.toggle_ignore },
          ['ctrl-u'] = { actions.toggle_hidden },
        }
      }
    }
  end,

  keys = {
    {
      '<F1>',
      '<Cmd>FzfLua helptags<CR>',
      desc = 'Show Help',
      mode = ALL_MODES,
    },

    -- Commonly used pickers
    { '<C-p>', '<Cmd>FzfLua files<CR>', desc = 'Search Files' },
    { '<Space>/', '<Cmd>FzfLua live_grep<CR>', desc = 'Live Grep' },
    { ';sb', '<Cmd>FzfLua buffers<CR>', desc = 'Search Buffers' },
    { ';sh', '<Cmd>FzfLua highlights<CR>', desc = 'Search Highlights' },
    { ';sj', '<Cmd>FzfLua jumps<CR>', desc = 'Search in Jumplist' },
    { ';sk', '<Cmd>FzfLua keymaps<CR>', desc = 'Search Keymaps' },
    { ';ss', '<Cmd>FzfLua resume<CR>', desc = 'Resume last Search' },
    { ';sr', '<Cmd>FzfLua oldfiles<CR>', desc = 'Recent Files' },

    -- Assorted finders
    { ';sv', find_config_file, desc = 'Search in Neovim Config Files' },
    { ';sc', '<Cmd>FzfLua colorschemes<CR>', desc = 'Search Colorscheme' },
  },
}
