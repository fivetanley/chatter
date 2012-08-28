ChatView = require( '../../lib/viewmodels/chat_view' )

module.exports = ->

  @chatView = {}

  # When a Message is received
  @Given /I am on the chatsite/, ( done ) ->
    @visit @chatUrl, =>
      @chatView = new ChatView( { el: $('<ol></ol>') } )
      done()

  @When /a Message is broadcasted from the server/, ( done ) ->
    @chatView.socket.$emit( 'message', { author: 'foo', body: 'bam' } )
    done()

  @Then /I should see the Message/, ( done ) ->
    expect( @chatView.$el.filter( ':last-child' ) ).to.contain( 'bam' )
    done()

  # When a Message is Sent

  @When /I send a Message/, ( done ) ->
    @chatView.sendMessage( 'foo' )
    done()

  @Then /I should see my Message/, ( done ) ->
    expect( @chatView.$el.filter( ':last-child' ) ).to.contain( 'foo' ) 
    done()
