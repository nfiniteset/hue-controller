module.exports = class LightsCollection
  constructor: (@source, lightsData, firstLightState) ->
    @lights = lightsData
    @on = firstLightState.on
    @brightness = firstLightState.bri

  getOn: ->
    @on

  setOn: (value) ->
    @on = value
    @source.sync(@)

  getBrightness: ->
    @brightness

  setBrightness: (value) ->
    value = parseInt value
    @brightness = value
    @source.sync(@)
