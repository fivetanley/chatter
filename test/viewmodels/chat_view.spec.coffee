ChatView = require( '../../lib/public/js/viewmodels/chat_view' )

describe 'ChatView', ->

  chatView = {}

  beforeEach ->
    chatView = new ChatView( { el: 
      $( '<div><ol class="message_list"></ol></div>' ) } )

  describe 'updating messages', ->

    beforeEach ->
      chatView.socket.$emit( 'message', { author: 'Stanley'
                                , body: 'Robots'
      })

    describe 'when received from server', ->
      it 'adds a message when its socket emits `message`', ->
        expect( chatView.$messageList.children().length ).to.equal( 1 )

      it 'renders the message body', ->
        expect( chatView.$messageList.filter( ':last-child' ) )
          .to.contain( 'Robots' )

      it 'renders the authors name', ->
        expect( chatView.$messageList.filter( ':last-child' ) )
          .to.contain( 'Stanley' )

    describe 'when sending to server', ->

      beforeEach ->
        chatView.senderName = 'Stanley2'
        chatView.sendMessage( 'Robots' )

      it 'renders the sender\'s name', ->
        expect( chatView.$el.filter( ':last-child' ) )
          .to.contain( 'Stanley2' )

  describe 'user typing message', ->

    beforeEach ->
      chatView.senderName = 'Stanley'
      sinon.stub( chatView.socket, 'emit' )
      inputArea = $( """
        <form class="new_message">
          <input class='chatbox' type='text' />
        </form>
      """)
      chatView.$el.append( inputArea )
      chatView = new ChatView( el: chatView.$el.get( 0 ) )

    afterEach ->
      chatView.socket.emit.restore()

    describe 'when the message is empty', ->

      it 'will not send a message of all whitespace', ->
        chatView.$chatInput.val( '\t\t\t   \n\n\n\n' )
        chatView.$chatForm.submit()
        expect( chatView.socket.emit ).not.to.have.been.called

    describe 'when the message is not empty', ->

      it 'will send the message', ->
        chatView.$chatInput.val( 'fgsdgs' )
        console.log( chatView.$chatInput.val() )
        chatView.$chatForm.submit()
        expect( chatView.socket.emit ).to.have.been.called

  describe 'changing name', ->

    beforeEach ->
      sinon.stub( chatView.socket, 'emit' )

    afterEach ->
      chatView.socket.emit.restore()

    it 'will send a request to the server for auth to change name', ->
      chatView.changeName( 'Robots2' )
      expect( chatView.socket.emit ).to
        .have.been.calledWith 'name:change', 'Robots2'

    it 'will change the name if it is available', ->
      chatView.socket.$emit 'accept:name:change', 'Robots2'
      expect( chatView.senderName ).to.equal 'Robots2'

    it 'will not change the name if it is not available', ->
      chatView.senderName = 'Robots'
      chatView.changeName 'Robots2'
      chatView.socket.$emit 'deny:name:change', 'Robots2'
      expect( chatView.senderName ).to.equal 'Robots'

