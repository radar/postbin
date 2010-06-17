Feature: Posting to a bin
  In order to value
  As a role
  I want feature

  Scenario: Posting to a bin
    Given there is a bin called "abcdefg"
    When there is JSON data posted to this bin
    Then the bin should have an item with this data
  
