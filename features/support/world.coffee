
zombie = require 'zombie'

module.exports.World = ( callback ) ->

  @browser = new zombie.Browser()

  @visit = @browser.visit

  callback()
