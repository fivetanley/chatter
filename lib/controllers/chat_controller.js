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
    handleMessage: function( message, socket ) {
      message = validator.sanitize( message ).xss()
      socket.broadcast.emit( 'message', message )
    }
  , handleNameChange: function( newName, socket ) {
      if ( this.names.indexOf( newName ) !== -1  )
        return socket.emit( 'deny:name:change', newName )
      return socket.emit( 'accept:name:change', newName )
    }
  }

  module.exports = ChatController

}();
