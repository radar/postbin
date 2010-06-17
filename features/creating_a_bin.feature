Feature: Creating a bin
  In order to create a bin
  As a user
  I want to press a button and have a new bin

  Scenario: Creating a new bin
    Given I am on the homepage
    And I press "Create"
    Then I should see "Postbin #"
  
