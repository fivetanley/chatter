
zombie = require 'zombie'

module.exports.World = ( callback ) ->

  @browser = new zombie.Browser()

  @chatUrl = 'http://localhost:9010'

  @visit = ( url, callback ) ->
    @browser.visit url, (err, browser) ->
      if ( err) then callback.fail( new Error 'ZombieJS: ' + err.message )
      callback()

  callback()
