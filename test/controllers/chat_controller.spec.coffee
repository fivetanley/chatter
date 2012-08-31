ChatController = module.isolate(__dirname +  '/../../lib/controllers/chat_controller' )

validator = ChatController.dependencies.find( /validator\S+index\.js/ )
describe 'ChatController', ->

  sockets =
    foo: {}
    baz: {}
    bar: {}
    on: sinon.stub()

  for own key,socket of sockets
    socket.emit = sinon.stub() unless key == 'on'
    socket.set = sinon.stub() unless key == 'on'

  chatController = new ChatController( sockets )

  delete sockets.on

  describe 'when a client sends a message', ->

    beforeEach ->
      ChatController::handleMessage.call(
        { sockets: sockets }
      , 'hello'
      , sockets.foo
      )

    it 'sanitizes that message for xss', ->
      expect( validator.sanitize ).to.have.been.calledWith( 'hello' )

    it 'sends the message everyone else', ->
      expect( sockets.baz.emit, sockets.bar.emit )
        .to.have.been.calledWith 'hello'

    it 'wont send the message to the sender', ->
      expect( sockets.foo.emit ).not.to.have.been.called

  describe 'client changing their name', ->
    ChatController::handleNameChange.call(
      { sockets: sockets }
    , 'hello'
    , sockets.foo
    )




