Feature: User Name
  Users have a uniquely identifiable name (a.k.a. ID).
  Nobody else can have the same name.

  Scenario: Changing the Name When the Name is Available
    Given I am on the chatsite
    When I request to change my name
    And the name is not taken by anyone else
    Then my name should be changed

  Scenario: Changing the Name When the Name is not Available
    Given I am on the chatsite
    When I request to change my name
    And the name is taken by somebody else
    Then my name should not change
    And I should be notified the name is not available

  Scenario: Choosing Name On First Arrival to the Site
    Given I am not on the chatsite
    When I visit the chatsite
    Then I should be prompted to choose a name

