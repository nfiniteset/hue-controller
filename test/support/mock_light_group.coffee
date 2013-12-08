chai = require('chai')
spies = require('chai-spies')
chai.use(spies)

module.exports = class MockLightGroup
  constructor: ->
  turnOn: chai.spy()
  turnOff: chai.spy()

  getOn: ->
    @on

  getBrightness: ->
    @brightness

  setBrightness: (brightness) ->
    @brightness = brightness