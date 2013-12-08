LightsController = require('../../lib/lights_controller')

describe 'LightsController', ->
  controller = undefined
  lightGroup = undefined

  controller = ->
    new LightsController(lightGroup)

  beforeEach ->
    lightGroup = new MockLightGroup

  describe 'toggling the lights', ->
    executeCommand = ->
      controller().toggle()

    describe 'when the lights are off', ->
      beforeEach ->
        lightGroup.on = false
        executeCommand()

      it 'turns on the lights', ->
        expect(lightGroup.turnOn).to.have.been.called()

    describe 'when the lights are on', ->
      beforeEach ->
        lightGroup.on = true
        executeCommand()

      it 'turns off the lights', ->
        expect(lightGroup.turnOff).to.have.been.called()

  describe 'increasing the brightness', ->
    executeCommand = ->
      controller().increaseBrightness()

    describe 'when the lights are off', ->
      beforeEach ->
        lightGroup.on = false
        executeCommand()

      it 'turns on the lights', ->
        expect(lightGroup.turnOn).to.have.been.called()

    describe 'when the lights are on', ->
      initialBrightness = 50

      beforeEach ->
        lightGroup.on = true
        lightGroup.brightness = initialBrightness
        executeCommand()

      it 'brightens the lights', ->
        expect(lightGroup.brightness).to.be.greaterThan(initialBrightness)

  describe 'decreasing the brightness', ->
    executeCommand = ->
      controller().decreaseBrightness()

    describe 'when the lights are off', ->
      beforeEach ->
        lightGroup.on = false
        executeCommand()

      it 'does not turn on the light', ->
        expect(lightGroup.turnOn).not.to.have.been.called()

    describe 'when the lights are on', ->
      initialBrightness = 50

      beforeEach ->
        lightGroup.brightness = initialBrightness
        lightGroup.on = true
        executeCommand()

      it 'dims the lights', ->
        expect(lightGroup.brightness).to.be.lessThan(initialBrightness)
