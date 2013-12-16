_ = require 'underscore'
NodePowerMate = require 'node-powermate'
{ EventEmitter } = require 'events'

CLICK_THRESHOLD_MS = 500

module.exports = class PowerMate extends EventEmitter

  constructor: (id) ->
    @_powermate = new NodePowerMate(id)
    @_watchForClickGesture()
    @_delegateMethods()
    @_delegateEvents()

  _delegateMethods: ->
    for method in ['setBrightness']
      @[method] = -> @_powermate[method](arguments...)

  _delegateEvents: ->
    for event in ['buttonDown', 'buttonUp', 'wheelTurn']
      @_powermate.on(event, => @emit(event, arguments...))

  _watchForClickGesture: ->
    pressEnded = undefined
    pressBegan = undefined

    @_powermate.on 'buttonDown', =>
      pressBegan = new Date

    @_powermate.on 'buttonUp', =>
      pressEnded = new Date
      if pressEnded - pressBegan < CLICK_THRESHOLD_MS
        @emit('click')
