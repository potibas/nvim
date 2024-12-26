local features = require('config.keymaps.features')

features
  .ctrlCBehavesLikeEscInInsertMode()
  .commandModeHistorySwitch()
  --.useEmacsCommandMode()
  .enableTabAndCtrlI()
  .expandCurrentDirectory('%%')
  .expandNeovimConfigDirectory('@@')
  .homeEndWithHL()
