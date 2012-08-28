ChatView = require( '../../lib/viewmodels/chat_view' )

describe 'ChatView', ->

  chatView = {}

  beforeEach ->
    chatView = new ChatView( { el: $( '<div></div>' ) } )

  describe 'updating messages', ->

    it 'adds a message when its socket emits `message`', ->
      chatView.socket.$emit( 'message', { author: 'Stanley'
                                , message: 'Robots'
      })
      expect( chatView.$el.children().length ).to.equal( 1 )

