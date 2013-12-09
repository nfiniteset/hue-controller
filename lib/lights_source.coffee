LightsCollection = require './lights_collection'
hue = require("node-hue-api")
HueApi = hue.HueApi

module.exports = class LightsSource

  constructor: (host, username) ->
    throw Error "host amd username must be defined" unless host && username
    @api = new HueApi(host, username)

  fetch: () ->
    @api.lights()
      .then(@_fetchLightStatus.bind(@))
      .fail(@_reportError)

  _fetchLightStatus: (result) ->
    @lightsData = result.lights

    @api.lightStatus(@lightsData[0].id)
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
      @api.setLightState(light.id, state)

  _serializeCollection: (collection) ->
    {
      on: collection.on,
      bri: collection.brightness
    }

