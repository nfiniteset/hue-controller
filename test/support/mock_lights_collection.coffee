chai = require('chai')
spies = require('chai-spies')
chai.use(spies)

module.exports = class MockLightsCollection

  constructor: (@source, lightsData, firstLightState) ->
    @on = firstLightState.on
    @brightness = firstLightState.bri

  setOn: chai.spy 'setOn', (value) ->
    console.log "Setting on: #{value}"

  setBrightness: chai.spy 'setBrightness', (value) ->
    console.log "Setting brightness: #{value}"

  getOn: ->
    @on

  getBrightness: ->
    @brightness
