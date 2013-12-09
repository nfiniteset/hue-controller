LightsSource = require('../../lib/lights_source')

describe 'LightsSource', ->
  host = '1.2.3.4'
  username = 'foobar'
  source = undefined

  beforeEach ->
    source = new LightsSource(host, username)

  describe '#constrctor', ->
    describe 'without a host and username', ->
      initializingWithoutParams = ->
        new LightsSource()

      it 'throws an exception', ->
        expect(initializingWithoutParams).to.throw()

  describe '#fetch', ->
    returnValue = undefined

    beforeEach ->
      returnValue = source.fetch()

    it 'returns a promise', ->
      expect(typeof returnValue.then).to.eq('function')
      expect(typeof returnValue.fail).to.eq('function')
      expect(typeof returnValue.done).to.eq('function')
