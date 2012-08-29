ChatView = require( '../../lib/viewmodels/chat_view' )
module.exports = ->

  chatView = {}

  @Before ( done ) ->
    chatView = new ChatView()
    chatView.senderName = 'Robot'
    done()

  @When /I request to change my name/, ( done ) ->
    chatView.changeName( 'Robot2' )
    done()

  @When /the name is not taken by anyone else/, ( done ) ->
    chatView.socket.$emit( 'accept:name:change', 'Robot2' )
    done()

  @Then /my name should be changed/, ( done ) ->
    expect( chatView.senderName ).to.equal( 'Robot2' )
    done()

  # When name not available
  
  @When /the name is taken by somebody else/, ( done ) ->
    chatView.socket.$emit( 'deny:name:change', 'Robot2' )
    done()

  @Then /my name should not change/, ( done ) ->
    expect( chatView.senderName ).to.equal 'Robot'
    done()
