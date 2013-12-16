hue = require 'node-hue-api'
HueApi = hue.HueApi
config = require '../config.json'

module.exports = class Bridge

  connect: ->
    hue.locateBridges().then(@_getHostNameFromBridge.bind(@)).fail(@_reportError)

  _getHostNameFromBridge: (result) ->
    @hostName = result[0].ipaddress
    @_initAPI()

  _initAPI: ->
    @api = new HueApi(@hostName, config.userName)
    @api.connect().then(@_ensureUserIsRegistered.bind(@)).fail(@_reportError)

  _ensureUserIsRegistered: (result) ->
    userIsRegistered = !!result.ipaddress
    if userIsRegistered
      @api
    else
      @api.registerUser(@hostName, config.userName, config.userDescription)
          .then(@_initAPI.bind(@))
          .fail(@_reportError)

  _reportError: (err) ->
    console.log(err)

  deleteUser: ->
    hue.locateBridges().then((result) ->
      hostName = result[0].ipaddress
      api = new HueApi(hostName, config.userName)
      api.deleteUser(config.userName).then (result) ->
        console.log "User #{config.userName} deleted."
    ).fail(@_reportError)

