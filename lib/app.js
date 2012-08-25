!function() {
  var express = require( 'express' )
    , app = express()

  // set up routes
  app.get( '/', function( req, res ) {
    res.send( 'hello' )
  })
  app.listen( 9010 )
}();
