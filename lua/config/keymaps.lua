local features = require('config.keymaps.features')

features
  .ctrlCBehavesLikeEscInInsertMode()
  .commandModeHistorySwitch()
  --.useEmacsCommandMode()
  .enableTabAndCtrlI()
  .expandCurrentDirectory('%%')
  .expandNeovimConfigDirectory('@@')
  .homeEndWithHL()

local function map(modes, lhs, rhs, desc)
  vim.keymap.set(modes, lhs, rhs, { desc = desc })
end

-- Common shortcuts
map({ 'n', 'v' }, ';a', '<C-^>', 'Edit the alternate file')
