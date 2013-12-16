module.exports = class LightsController

  BRIGHTNESS_INCREMENT: 3
  MIN_BRIGHTNESS: 1
  MAX_BRIGHTNESS: 255

  constructor: (@lights) ->

  toggle: ->
    if @lights.getOn()
      @lights.setOn(false)
    else
      @lights.setOn(true)

  increaseBrightness: ->
    return @lights.setOn(true) if !@lights.getOn()

    brightness = Math.min(@lights.getBrightness() + @BRIGHTNESS_INCREMENT, @MAX_BRIGHTNESS)
    @lights.setBrightness(brightness)

  decreaseBrightness: ->
    brightness = Math.max(@lights.getBrightness() - @BRIGHTNESS_INCREMENT, @MIN_BRIGHTNESS)
    @lights.setBrightness(brightness)
