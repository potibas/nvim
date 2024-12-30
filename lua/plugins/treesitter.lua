return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',

  opts_extend = { 'ensure_installed' },

  ---@module "nvim-treesitter"
  ---@type TSConfig
  opts = {
    ensure_installed = {
      'c',
      'lua',
      'vim',
      'vimdoc',
      'query',
    },

    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = "gnn", -- set to `false` to disable one of the mappings
        -- node_incremental = "grn",
        -- scope_incremental = "grc",
        -- node_decremental = "grm",
        init_selection = ';ri',
        scope_incremental = '<C-s>',
        node_incremental = '<C-,>',
        node_decremental = '<C-.>',
      },
    },
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    vim.keymap.set(
      'n',
      ';ut',
      '<Cmd>TSToggle highlight<CR>',
      { desc = 'Toggle Treesitter Highlights' }
    )
  end,
}
