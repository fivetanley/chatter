Feature: User Name
  Users have a uniquely identifiable name (a.k.a. ID).
  Nobody else can have the same name.

  Scenario: Changing the Name When the Name is Available
    Given I am on the chatsite
    When I request to change my name
    And the name is not taken by anyone else
    Then my name should be changed
