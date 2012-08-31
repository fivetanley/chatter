var ChatController = require( './chat_controller' )

module.exports.ChatController = ChatController

module.exports.setup = function( express, sockets ) {
  return new ChatController( sockets )
}
