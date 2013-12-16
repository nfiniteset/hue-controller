chai = require('chai')
sinonChai = require('sinon-chai')
chai.use(sinonChai)
sinon = require('sinon')

module.exports = class MockLightsSource

  constructor: ->

  fetch: sinon.spy ->
    console.log "MockLightsSource fetching"

  sync: sinon.spy (value) ->
    console.log "MockLightsSource syncing:", value
