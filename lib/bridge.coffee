hue = require 'node-hue-api'
HueApi = hue.HueApi
config = require '../config.json'
Q = require 'q'

module.exports = class Bridge

  deleteUser: ->
    hue.locateBridges().then((result) ->
      hostName = result[0].ipaddress
      api = new HueApi(hostName, config.userName)
      api.deleteUser(config.userName).then (result) ->
        console.log "User #{config.userName} deleted."
    ).fail(@_reportError)

  connect: ->
    hue.locateBridges().then(@_getHostNameFromBridge.bind(@)).fail(@_reportError)

  _getHostNameFromBridge: (result) ->
    @hostName = result[0].ipaddress
    @_initAPI()

  _initAPI: ->
    @api = new HueApi(@hostName, config.userName)
    @_ensureUserIsRegistered()

  _ensureUserIsRegistered: ->
    @api.connect().then((result) =>
      userIsRegistered = !!result.ipaddress
      if userIsRegistered
        @api
      else
        @api.registerUser(@hostName, config.userName, config.userDescription)
            .then(@_initAPI.bind(@))
            .fail(@_retryRegistration.bind(@))
    ).fail(@_reportError)

  _retryRegistration: (err) ->
    if err.message == 'link button not pressed'
      deferred = Q.defer()
      tryAgain = => deferred.resolve(@_ensureUserIsRegistered())

      console.log 'Press the link button on the hue bridge to enable this app.'
      setTimeout(tryAgain, 1000)
      deferred.promise
    else
      @_reportError(err)

  _reportError: (err) ->
    console.log(err)
