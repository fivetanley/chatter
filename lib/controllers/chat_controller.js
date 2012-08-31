!function(){

  var validator = require( 'validator' )
  function ChatController( sockets ) {
    var self = this
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

    }
  }

  module.exports = ChatController

}();
