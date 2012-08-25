module.exports = ->

  @Given /I am not on the chatsite/, ( done ) ->
    done()

  @When /I visit the chatsite/, ( done ) ->
    @visit @chatUrl, done

  @Then /I should see the chat/, ( done ) ->
    chatEl = $( '#chat' )
    expect( chatEl ).to.be.visible()
    done()
