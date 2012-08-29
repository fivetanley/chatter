ChatView = require( '../../lib/viewmodels/chat_view' )
module.exports = ->

  chatView = {}

  chatView = new ChatView()
  chatView.senderName = 'Robot'

  @When /I request to change my name/, ( done ) ->
    chatView.changeName( 'Robot2' )
    done()

  @When /the name is not taken by anyone else/, ( done ) ->
    chatView.socket.$emit( 'accept:name:change', 'Robot2' )
    done()

  @Then /my name should be changed/, ( done ) ->
    expect( chatView.senderName ).to.equal( 'Robot2' )
