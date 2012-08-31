ChatController = module.isolate(__dirname +  '/../../lib/controllers/chat_controller' )

validator = ChatController.dependencies.find( /validator\S+index\.js/ )
describe 'ChatController', ->

  sockets =
    foo: {}
    baz: {}
    bar: {}
    on: sinon.stub()

  for own key,socket of sockets
    socket.set = sinon.stub().yields() unless key is 'on'
    socket.get = sinon.stub()
      .yields( null, 'bill' ) unless key is on
    socket.emit = sinon.stub() unless key is 'on'
    socket.broadcast = sinon.stub() unless key is 'on'
    socket.broadcast.emit = sinon.stub() unless key is 'on'

  chatController = new ChatController( sockets )

  delete sockets.on

  describe 'when a client sends a message', ->

    beforeEach ( done )->
      ChatController::handleMessage.call(
        { sockets: sockets }
      , 'hello'
      , sockets.foo
      , done
      )

    it 'sanitizes that message for xss', ->
      expect( validator.sanitize ).to.have.been.calledWith( 'hello' )

    it 'sends the message everyone else', ->
      expect( sockets.foo.broadcast.emit ).to.have.been.called

    it 'will include the message author', ->
      expect( sockets.foo.broadcast.emit )
        .to.have.been.calledWith( 'message', 
          { author: 'bill'
          , body: 'hello' } )

  describe 'when a client changes their name', ->

    beforeEach (done)->
      ChatController::handleNameChange.call(
        { sockets: sockets
        , names: [ 'foo', 'bar', 'baz' ]
        }
      , 'foo'
      , sockets.foo
      , done
      )

    it 'will deny the name change if it is taken', ->
      expect( sockets.foo.emit ).to.have.been.calledWith 'deny:name:change'

    it 'will accept the name change if it is not taken', (done)->
      ChatController::handleNameChange.call(
        { sockets: sockets
        , names: [ 'foo', 'bar', 'baz' ]
        }
      , 'tastic'
      , sockets.foo
      , done )

      expect( sockets.foo.emit ).to.have.been.calledWith(
        'accept:name:change', 'tastic' )
      expect( sockets.foo.set ).to.have.been.calledWith 'name', 'tastic'

