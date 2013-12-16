'use strict';

PowerMate = require('node-powermate')
LightsSource = require('../lib/lights_source')
LightsController = require('../lib/lights_controller')
Bridge = require('../lib/bridge')
_ = require('underscore')


module.exports = (program) ->

  program
    .command('watch')
    .version('0.0.0')
    .description('Continually watch a PowerMate for commands')
    .action ->
      bridge = new Bridge()
      bridge.connect().then (bridge) ->
        source = new LightsSource(bridge)
        source.fetch().then( (lightsCollection) ->
          console.log('Watching PowerMate for commands...')

          adjustBrightness = (delta) ->
            if delta > 0
              controller.increaseBrightness()
            else
              controller.decreaseBrightness()

          powermate = new PowerMate
          powermate.setBrightness(0)
          controller = new LightsController(lightsCollection)

          powermate.on 'buttonDown', ->
            controller.toggle()
          powermate.on 'wheelTurn', _.throttle(adjustBrightness, 200)

        ).fail(->console.log(arguments[0]))
