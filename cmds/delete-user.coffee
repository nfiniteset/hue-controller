'use strict';

Bridge = require '../lib/bridge'

module.exports = (program) ->

  program
    .command('delete-user')
    .version('0.0.0')
    .description('Delete the huePowermateController user created by this package.')
    .action ->
      bridge = new Bridge
      bridge.deleteUser()
