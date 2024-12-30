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

    opts_extend = { 'servers' },

    opts = {
      servers = {},
    },

    config = function(_, opts)
      local lspconfig = require('lspconfig')
      -- Get default client capabilities
      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      local handlers = {}

      --:help mason-lspconfig.setup_handlers()
      for _, server_name in ipairs(opts.servers) do
        local ok, server_opts = pcall(require, 'config.lsp.' .. server_name)

        if not ok then
          server_opts = {}
        end

        server_opts.capabilities = vim.tbl_deep_extend(
          'force',
          server_opts.capabilities or {},
          client_capabilities
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
