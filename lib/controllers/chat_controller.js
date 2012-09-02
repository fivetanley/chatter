!function(){

  var validator = require( 'validator' )
  function ChatController( sockets ) {
    var self = this
    this.names = []
    this.sockets = sockets
    this.sockets.on( 'connection', function( socket ) {
      socket.on( 'message', function( message ) {
        self.handleMessage( message, socket )
      })
      socket.on('name:change', function( newName ) {
        self.handleNameChange( newName, socket )
      })
    })
  }

  ChatController.prototype = {
    handleMessage: function( message, socket, callback ) {
      message = validator.sanitize( message ).xss()
      socket.get( 'name', function( err, name ) {
        message = {
          author: name
        , body: message
        }
      socket.broadcast.emit( 'message', message )
      if ( callback ) callback()
      })
    }
  , handleNameChange: function( newName, socket, callback ) {
      if ( this.names.indexOf( newName ) !== -1  ) {
        socket.emit( 'deny:name:change', newName )
        if ( callback ) callback()
      }
      socket.set( 'name', newName, function() {
        socket.emit( 'accept:name:change', newName )
        if ( callback ) callback()
      })
    }
  }

  module.exports = ChatController

}();
