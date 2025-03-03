require('config.launch')
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.diagnostics')

Spec('plugins.which-key')
Spec('plugins.fzf')
Spec('plugins.oil')
Spec('plugins.lspconfig')
Spec('plugins.treesitter')
Spec('plugins.blink')

Spec('extras.colorschemes')

Spec('extras.lang.lua')
Spec('extras.lang.php')

require('plugins.lazy')

vim.cmd.colorscheme('tokyonight')
