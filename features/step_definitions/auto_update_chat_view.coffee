ChatView = require( '../../lib/viewmodels/ChatView' )

module.exports = ->

  @chatView = {}

  @Given /I am on the chatsite/, ( done ) ->
    @visit @chatUrl, =>
      @chatView = new ChatView( el: '#chat' )
      done()

  @When /a Message is broadcasted from the server/, ( done ) ->
    @chatView.socket.emit( 'message', { author: 'foo', body: 'bam' } )
    done()

  @Then /I should see the Message/, ( done ) ->
    expect( @chatView.$el ).to.have.text( 'bam' )
    done()

