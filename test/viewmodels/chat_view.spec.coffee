ChatView = require( '../../lib/viewmodels/chat_view' )

describe 'ChatView', ->

  chatView = {}

  beforeEach ->
    chatView = new ChatView( { el: $( '<div></div>' ) } )

  describe 'updating messages', ->

    beforeEach ->
      chatView.socket.$emit( 'message', { author: 'Stanley'
                                , body: 'Robots'
      })

    describe 'when received from server', ->
      it 'adds a message when its socket emits `message`', ->
        expect( chatView.$el.children().length ).to.equal( 1 )

      it 'renders the message body', ->
        expect( chatView.$el.filter( ':last-child' ) )
          .to.contain( 'Robots' )

      it 'renders the authors name', ->
        expect( chatView.$el.filter( ':last-child' ) )
          .to.contain( 'Stanley' )

    describe 'when sending to server', ->

      beforeEach ->
        chatView.senderName = 'Stanley2'
        chatView.sendMessage( 'Robots' )

      it 'renders the sender\'s name', ->
        expect( chatView.$el.filter( ':last-child' ) )
          .to.contain( 'Stanley2' )

