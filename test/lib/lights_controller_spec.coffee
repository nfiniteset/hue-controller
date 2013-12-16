LightsController = require('../../lib/lights_controller')
MockLightsCollection = require("../support/mock_lights_collection.coffee")

describe 'LightsController', ->

  beforeEach ->
    @_controller = undefined
    @_lights = undefined

    @lightState = { on: undefined, bri: 75 }

    @controller = ->
      unless @_controller
        @_controller = new LightsController(@lights())
      @_controller

    @lights = ->
      unless @_lights
        @_lights = new MockLightsCollection({}, [], @lightState)
      @_lights

  describe 'toggling the lights', ->
    beforeEach ->
      @executeCommand = ->
        @controller().toggle()

    describe 'when the lights are off', ->
      beforeEach ->
        @lightState.on = false
        @executeCommand()

      it 'turns on the lights', ->
        @lights().setOn.should.have.been.calledWith(true)

    describe 'when the lights are on', ->
      beforeEach ->
        @lightState.on = true
        @executeCommand()

      it 'turns off the lights', ->
        @lights().setOn.should.have.been.calledWith(false)

  describe 'increasing the brightness', ->
    beforeEach ->
      @executeCommand = ->
        @controller().increaseBrightness()

    describe 'when the lights are off', ->
      beforeEach ->
        @lightState.on = false
        @executeCommand()

      it 'turns on the lights', ->
        @lights().setOn.should.have.been.calledWith(true)

    describe 'when the lights are on', ->
      initialBrightness = 50
      arguedBrightness = undefined

      beforeEach ->
        @lightState.on = true
        @lightState.bri = initialBrightness

        @executeCommand()

        @lights().setBrightness.should.have.been.calledOnce()
        arguedBrightness = @lights().setBrightness.__spy.calls[0][0]

      it 'brightens the lights', ->
        expect(arguedBrightness).to.be.greaterThan(initialBrightness)

  describe 'decreasing the brightness', ->
    beforeEach ->
      @executeCommand = ->
        @controller().decreaseBrightness()

    describe 'when the lights are off', ->
      beforeEach ->
        @lightState.on = false
        sinon.spy(@controller(), 'decreaseBrightness')

        @executeCommand()

      it 'does not turn on the light', ->
        expect(@lights().setOn).not.to.have.been.called()

      it 'does not decrease the brightness', ->
        expect(@controller().decreaseBrightness).not.to.have.been.called()

      afterEach ->
        @controller().decreaseBrightness.restore()

    describe 'when the lights are on', ->
      initialBrightness = 50
      arguedBrightness = undefined

      beforeEach ->
        @lightState.on = true
        @lightState.bri = initialBrightness

        @executeCommand()

        expect(@lights().setBrightness).to.have.been.calledOnce()
        arguedBrightness = @lights().setBrightness.__spy.calls[0][0]

      it 'dims the lights', ->
        expect(arguedBrightness).to.be.lessThan(initialBrightness)
