require('config.keymaps.keycodes')

local features = require('config.keymaps.features')

features
  .ctrlCBehavesLikeEscInInsertMode()
  .commandModeHistorySwitch()
  --.useEmacsCommandMode()
  .enableTabAndCtrlI()
  .expandCurrentDirectory('%%')
  .expandNeovimConfigDirectory('@@')
  .homeEndWithHL()
  .moveLinesAround(ALT.j, ALT.k)
  .insertBlankLines('<S-CR>', '<M-CR>')
  .replaceUnderCursor('<C-8>')
  .starMatchKeepsPosition()
  .tmuxStyleWindowResize('<C-S-H>', '<C-S-J>', '<C-S-K>', '<C-S-L>')
  .windowNavigation('<C-h>', '<C-j>', '<C-k>', '<C-l>')
  .toggleQuickfixWindow(';uq')
  .dontReplaceRegisterWhenPasting()
  .insertModeMovementKeys('<M-C-H>', '<M-NL>', '<M-C-K>', '<M-C-L>')
  .forceDelete('<C-\\><C-x>')
  .reloadNeovim('<C-\\><C-\\>')
  .forceReloadNeovim('<C-\\><C-q>')
  .navigateDiagnostics({ float = true })

local function map(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc })
end

local function map_silent(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc, silent = true })
end

local function pcaller(cmd)
  return function()
    pcall(cmd)
  end
end

-- Common shortcuts
map({ 'n', 'v' }, ';a', '<C-^>', 'Edit the alternate file')
map({ 'n', 't' }, '<C-q>', vim.cmd.quit, 'Quit Window')
map('n', ';x', vim.cmd.bd, 'Delete Buffer')

-- Write the buffer without throwing an error if there is no current file
map({ 'n', 'v' }, ';w', pcaller(vim.cmd.write), 'Write Buffer')

-- Contextual Help
map('n', '<F1>', ':help <C-r><C-w><CR>', 'Show help for word under cursor')

-- Open line above in insert mode
map_silent('i', ALT.o, '<C-o>O', 'Open line above')

-- Treesitter shortcuts
map('n', ';rt', vim.cmd.InspectTree, 'Inspect Tree')
map('n', ';rn', vim.cmd.Inspect, 'Inspect Node')
