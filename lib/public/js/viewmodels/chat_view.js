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
    this.$messageList = this.$el.find( 'ol.message_list' )
    this.$chatForm.submit( function( event ) {
      self.sendMessage( self.$chatInput.val() )
      event.preventDefault()
    })
    this.socket = options.socket || socketClient
      .connect( 'http://localhost:9010')
    this.socket.on( 'message', function( message ) {
      self.appendMessage( message )
    })
    this.socket.on( 'connection', function() {
        self.changeName( self.senderName )
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
      this.$messageList.append( messageView )
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
  , promptUsername: function() {

    }
  }

  module.exports = ChatView
}();
