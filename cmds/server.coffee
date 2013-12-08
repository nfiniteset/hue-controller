'use strict';

module.exports = (program) ->
  program
    .command('server')
    .version('0.0.0')
    .description('A commander command')
    .action ->
      console.log('some of my favorite thangs')
