'use strict';

LightsSource = require('../lib/lights_source')
LightsController = require('../lib/lights_controller')

host = "10.0.4.3"
username = "seandevelopment"

module.exports = (program) ->
  program
    .command('increaseBrightness')
    .version('0.0.0')
    .description('Make the lights brighter')
    .action ->
      source = new LightsSource(host, username)

      source.fetch().then (lights) ->
        controller = new LightsController(lights)
        controller.increaseBrightness()
