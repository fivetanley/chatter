!function() {

  var $ = require( 'jquery' )
    , socketClient = require( 'socket.io-client' )

  function ChatView( options ) {
    if (!options) options = {}
    this.el = options.el
    this.$el = $( this.el )
    this.socket = options.socket || socketClient.connect('http://localhost')
  }

  module.exports = ChatView
}();
