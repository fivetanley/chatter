!function() {

  var $ = require( 'jquery' )
    , socketClient = require( 'socket.io-client' )

  function ChatView( options ) {
    var self = this
    if (!options) options = {}
    this.senderName = options.senderName
    this.el = options.el
    this.$el = $( this.el )
    this.$chatInput = this.$el.find( 'input.chatbox' )
    this.$chatForm = this.$el.find( 'form.new_message' )
    this.$chatForm.submit( function( event ) {
      event.preventDefault()
      self.sendMessage( self.$chatInput.val() )
    })
    this.socket = options.socket || socketClient.connect()
    this.socket.on( 'message', function( message ) {
      self.appendMessage( message )
    })
    this.socket.on( 'accept:name:change', function( name ) {
      self.senderName = name
    })
    this.socket.on( 'deny:name:change', this.notifyUnavailable )
  }

  ChatView.prototype = {
    appendMessage: function( message ) {
      var messageView = $( '<li></li>' )
      messageView.text( '<' + message.author + '>' + message.body )
      this.$el.append( messageView )
    }

  , sendMessage: function( /*String*/ message ) {
      if ( message ) message = message.trim()
      if ( !message ) return
      this.socket.emit( 'message', message )
      this.appendMessage( { author: this.senderName, body: message } )
    }
  , changeName: function( name ) {
      this.socket.emit( 'name:change', name )
    }
  , notifyUnavailable: function( name ) {
      if ( typeof alert !== 'undefined' ) alert( name + 'is taken by someone else!' )
    }
  }

  module.exports = ChatView
}();