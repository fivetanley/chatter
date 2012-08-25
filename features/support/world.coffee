
zombie = require 'zombie'

module.exports.World = ( callback ) ->

  @browser = new zombie.Browser()

  @chatUrl = 'http://localhost:9010'

  @visit = @browser.visit

  callback()
