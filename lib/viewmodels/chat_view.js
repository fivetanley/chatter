!function() {

  var $ = require( 'jquery' )
    , socketClient = require( 'socket.io-client' )

  function ChatView( options ) {
    var self = this
    if (!options) options = {}
    this.senderName = options.senderName
    this.el = options.el
    this.$el = $( this.el )
    this.socket = options.socket || socketClient.connect('http://localhost')
    this.socket.on( 'message', function( message ) {
      self.appendMessage( message )
    })
  }

  ChatView.prototype = {
    appendMessage: function( message ) {
      var messageView = $( '<li></li>' )
      messageView.text( '<' + message.author + '>' + message.body )
      this.$el.append( messageView )
    }

  , sendMessage: function( /*String*/ message ) {
      this.socket.emit( 'message', message )
      this.appendMessage( { author: this.senderName, body: message } )
    }
  }

  module.exports = ChatView
}();
