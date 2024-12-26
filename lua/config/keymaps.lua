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
  .toggleQuickfixWindow(';uq')
  .dontReplaceRegisterWhenPasting()

local function map(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc })
end

local function pcaller(cmd)
  return function()
    pcall(cmd)
  end
end

-- Common shortcuts
map({ 'n', 'v' }, ';a', '<C-^>', 'Edit the alternate file')
map('n', ';x', vim.cmd.bd, 'Delete Buffer')
map('n', '<C-q>', vim.cmd.quit, 'Quit Window')

-- Write the buffer without throwing an error if there is no current file
map({ 'n', 'v' }, ';w', pcaller(vim.cmd.write), 'Write Buffer')

-- Contextual Help
map('n', '<F1>', ':help <C-r><C-w><CR>', 'Show help for word under cursor')
