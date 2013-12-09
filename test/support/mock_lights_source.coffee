chai = require('chai')
spies = require('chai-spies')
chai.use(spies)

module.exports = class MockLightsSource

  constructor: ->

  fetch: chai.spy 'fetch', ->
    console.log "MockLightsSource fetching"

  sync: chai.spy 'sync', (value) ->
    console.log "MockLightsSource syncing:", value
