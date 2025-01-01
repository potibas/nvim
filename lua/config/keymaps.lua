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
  .contextualHelp('<Space>?')
  .clearScreen(ALT.l)
  .multijumpEnable()
  .multijumpQuickfix()
  .multijumpBuffers()
  -- .navigateDiagnostics({ float = true })
  .multijumpDiagnostics({ float = true })

ALL_MODES = { 'n', 'i', 'c', 'v', 'x', 's', 'o', 't' }

local function map(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc })
end

local function map_silent(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc, silent = true })
end

local function remap(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc, remap = true })
end

local f = require('lib.functions')

-- Common shortcuts
map({ 'n', 'v' }, ';a', '<C-^>', 'Edit the alternate file')
map({ 'n', 't' }, '<C-q>', vim.cmd.quit, 'Quit Window')
map('n', ';x', vim.cmd.bd, 'Delete Buffer')

-- Write the buffer without throwing an error if there is no current file
map({ 'n', 'v' }, ';w', f.pcaller(vim.cmd.write), 'Write Buffer')

-- Open line above in insert mode
map_silent('i', ALT.o, '<C-o>O', 'Open line above')

-- Treesitter shortcuts
map('n', ';rt', vim.cmd.InspectTree, 'Inspect Tree')
map('n', ';r?', vim.cmd.Inspect, 'Inspect Node')

-- Comment code
remap('n', ',', 'gc', 'Toggle comments {motion}')
remap('n', '<C-/>', 'gcc', 'Toggle comments')
remap('v', '<C-/>', 'gc', 'Toggle comments')
