!function() {
  var express = require( 'express' )
    , http = require( 'http' )
    , app = express()
    , server = http.createServer( app )
    , controllers = require( './controllers' )
    , PWD = __dirname
    , io = require( 'socket.io' ).listen( server )

  console.log( Object.getPrototypeOf( io.sockets ) )
  app.configure( function() {
    app.engine( 'html', require( 'ejs' ).renderFile )
    app.set( 'views', PWD + '/public/views' )
  })

  controllers.setup( express, io.sockets )

  // set up routes
  app.get( '/', function( req, res ) {
    res.render( 'index.html' )
  })

  // javascripts
  app.get( '/js/:file', function( req, res ) {
    res.sendfile( PWD + '/public/js/' + req.params.file )
  })

  // css
  app.get( '/css/:file', function( req, res ) {
    res.sendfile( PWD + '/public/css/' + req.params.file )
  })

  server.listen( 9010 )
}();
