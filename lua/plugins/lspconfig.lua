return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    dependencies = { 'williamboman/mason.nvim' },

    opts_extend = { 'ensure_installed' },

    opts = {
      auto_update = true,
      run_on_start = true,
      start_delay = 1000,
      ensure_installed = {},
    },

    config = function(_, opts)
      require('mason').setup()
      require('mason-tool-installer').setup(opts)
    end,
  },

  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        mode = { 'n' },
        { ';cl', group = 'LSP' },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    opts_extend = { 'servers', 'capabilities' },

    opts = {
      servers = {},
      capabilities = {},
    },

    config = function(_, opts)
      local f = require('lib.functions')
      local lspconfig = require('lspconfig')
      local default_server_opts = require('config.lsp.default')

      for _, cap in ipairs(opts.capabilities) do
        default_server_opts.capabilities = vim.tbl_deep_extend(
          'force',
          default_server_opts.capabilities,
          f.value(cap)
        )
      end

      --:help mason-lspconfig.setup_handlers()
      local handlers = {}

      for _, server_name in ipairs(opts.servers) do
        local _, custom_opts = pcall(require, 'config.lsp.' .. server_name)

        if type(custom_opts) ~= 'table' then
          custom_opts = {}
        end

        local server_opts = vim.tbl_deep_extend(
          'force',
          default_server_opts,
          custom_opts
        )

        handlers[server_name] = function()
          lspconfig[server_name].setup(server_opts)
        end
      end

      require('mason-lspconfig').setup({ handlers = handlers })

      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = desc })
      end

      map(';cli', vim.cmd.LspInfo, 'Show LSP Info')
      map(';cls', vim.cmd.LspStart, 'Start LSP Client')
      map(';clR', vim.cmd.LspRestart, 'Restart LSP Client')
      map(';clT', vim.cmd.LspStop, 'Stop LSP Client')
      map('<Space>om', vim.cmd.Mason, 'Open Mason')
    end,
  },
}
