
ChatController = require( '../../lib/controllers/chat_controller' )

describe 'ChatController', ->

  chat = {}
  app = {}
  chatController = null
  reqStub = Object.create null
  resStub = Object.create null


  beforeEach ->
    app.send = sinon.stub()

    chatController = new ChatController( app )

  it 'just works', ->
    expect( true ).to.be( true )

  describe 'rendering the ChatView', ->

    it 'creates HTML for the ChatView', ->
      chatController.renderChatView( reqStub, resStub )
      firstArg = app.send.args[0][0]
      expect( firstArg ).to.match( /\#chat/ )
      expect( app.send ).to.have.been.called()

