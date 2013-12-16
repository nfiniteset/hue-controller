LightsCollection = require './lights_collection'

module.exports = class LightsSource

  constructor: (@bridge) ->

  fetch: () ->
    @bridge.lights()
      .then(@_fetchLightStatus.bind(@))
      .fail(@_reportError)

  _fetchLightStatus: (result) ->
    @lightsData = result.lights

    @bridge.lightStatus(@lightsData[0].id)
      .then(@_buildLightCollection.bind(@))
      .fail(@_reportError)

  _buildLightCollection: (result) ->
    state = result.state
    new LightsCollection(@, @lightsData, state)

  _reportError: (err) ->
    console.log(err)

  sync: (collection) ->
    state = @_serializeCollection(collection)
    for light in @lightsData
      @bridge.setLightState(light.id, state)

  _serializeCollection: (collection) ->
    {
      on: collection.on,
      bri: collection.brightness
    }

