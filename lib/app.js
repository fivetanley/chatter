!function() {
  var express = require( 'express' )
    , app = express()
    , controllers = require( './controllers' )

  app.configure( function() {
    app.engine( 'html', require( 'ejs' ).renderFile )
    app.set( 'views', __dirname + '/public/views' )
  })

  // set up routes
  app.get( '/', function( req, res ) {
    res.render( 'index.html' )
  })

  app.listen( 9010 )
}();
