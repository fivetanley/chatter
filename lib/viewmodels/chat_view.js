!function() {

  var $ = require( 'jquery' )
    , socketClient = require( 'socket.io-client' )

  function ChatView( options ) {
    var self = this
    if (!options) options = {}
    this.el = options.el
    this.$el = $( this.el )
    this.socket = options.socket || socketClient.connect('http://localhost')
    this.socket.on( 'message', function( message ) {
      self.appendMessage( message )
    })
  }

  ChatView.prototype = {
    appendMessage: function( message ) {
      this.$el.append( $( '<li></li> ' ) )
    }
  }

  module.exports = ChatView
}();
