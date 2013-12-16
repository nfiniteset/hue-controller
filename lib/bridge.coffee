hue = require 'node-hue-api'
HueApi = hue.HueApi
username = 'huePowermateControl'
userDescription = 'Hue Powermate Control'

module.exports = class Bridge

  connect: ->
    hue.locateBridges().then(@_initAPI.bind(@)).fail(@_reportError)

  _initAPI: (result) ->
    ipAddress = result[0].ipaddress
    @api = new HueApi(ipAddress, username)
    @api.connect().then(@_ensureUserIsRegistered.bind(@)).fail(@_reportError)

  _ensureUserIsRegistered: (result) ->
    userIsRegistered = !!result.ipaddress
    if userIsRegistered
      console.log('User is registered.')
      @api
    else
      @api.registerUser(ipAddress, username, userDescription).fail(@_reportError)

  _reportError: (err) ->
    console.log(err)
