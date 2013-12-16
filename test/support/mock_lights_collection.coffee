chai = require('chai')
sinonChai = require('sinon-chai')
chai.use(sinonChai)
sinon = require('sinon')

module.exports = class MockLightsCollection

  constructor: (@source, lightsData, firstLightState) ->
    @on = firstLightState.on
    @brightness = firstLightState.bri

  setOn: sinon.spy (value) ->

  setBrightness: sinon.spy (value) ->

  getOn: ->
    @on

  getBrightness: ->
    @brightness
