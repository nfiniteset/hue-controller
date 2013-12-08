module.exports = class LightsController

  BRIGHTNESS_INCREMENT: 10

  constructor: (@lights) ->

  toggle: ->
    if @lights.getOn()
      @lights.turnOff()
    else
      @lights.turnOn()

  increaseBrightness: ->
    brightness = @lights.getBrightness()
    @lights.turnOn()
    @lights.setBrightness(brightness + @BRIGHTNESS_INCREMENT)

  decreaseBrightness: ->
    brightness = @lights.getBrightness()
    @lights.setBrightness(brightness - @BRIGHTNESS_INCREMENT)