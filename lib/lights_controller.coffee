module.exports = class LightsController

  BRIGHTNESS_INCREMENT: 10

  constructor: (@lights) ->

  toggle: ->
    if @lights.getOn()
      @lights.setOn(false)
    else
      @lights.setOn(true)

  increaseBrightness: ->
    brightness = parseInt @lights.getBrightness()
    @lights.setOn(true)
    @lights.setBrightness(brightness + @BRIGHTNESS_INCREMENT)

  decreaseBrightness: ->
    brightness = @lights.getBrightness()
    @lights.setBrightness(brightness - @BRIGHTNESS_INCREMENT)
