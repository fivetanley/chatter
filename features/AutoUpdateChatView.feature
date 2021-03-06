Feature: Automatically Update the Chat View
  Users should not have to refresh their browser to see the latest messages.

  Scenario: When a message is received
    Given I am on the chatsite
    When a Message is broadcasted from the server
    Then I should see the Message

  Scenario: When a message is sent
    Given I am on the chatsite
    When I send a Message
    Then I should see my Message
