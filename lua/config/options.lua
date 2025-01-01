-- Window Appearance
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 20
vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↲' }
vim.opt.list = false
vim.opt.showmode = true
vim.opt.colorcolumn = { 80 }

-- stylua: ignore start
vim.opt.shortmess = {
  a = true, s = true, t = true, T = true,
  W = true, A = true, I = false, c = true,
  C = true, F = true, S = true,
}
-- stylua: ignore end

-- Editor behaviour
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.mouse = 'a'
vim.opt.timeoutlen = 800
vim.opt.updatetime = 200
vim.opt.sessionoptions = 'blank,curdir,folds,help,tabpages,winpos'
vim.opt.virtualedit = 'block'

--- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Completion
vim.opt.completeopt = 'menu,menuone,preview,noinsert'

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'

-- Indenting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.shell = '/bin/zsh'

--- Disable plugins and remote plugin providers that I don't use
vim.g.loaded_matchit = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
