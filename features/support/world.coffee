$ = require 'jquery'
zombie = require 'zombie'

module.exports.World = ( callback ) ->

  @browser = new zombie.Browser()

  @chatUrl = 'http://localhost:9010'

  @visit = ( url, callback ) ->
    @browser.visit url, (err, browser) ->
      if err? then return callback.fail( new Error 'ZombieJS: ' + err.message )
      @browser = browser
      global.$ = ( selector ) ->
        return $( selector, $( @browser.html() ) )
      callback()

  callback()
