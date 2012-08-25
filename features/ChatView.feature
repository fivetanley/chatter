Feature: Chat View
  Users should see the chat and activity happening in it.

  Scenario: On Page Load When Not Logged In
    Given I am not on the chatsite
    When I visit the chatsite
    Then I should see the chat
