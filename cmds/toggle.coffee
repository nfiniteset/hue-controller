'use strict';

LightsSource = require('../lib/lights_source')
LightsController = require('../lib/lights_controller')

host = "10.0.4.3"
username = "seandevelopment"

module.exports = (program) ->
  program
    .command('toggle')
    .version('0.0.0')
    .description('Toggle the lights on and off')
    .action ->
      source = new LightsSource(host, username)

      source.fetch().then (lights) ->
        controller = new LightsController(lights)
        controller.toggle()
