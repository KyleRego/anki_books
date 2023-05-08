@javascript
Feature: Creating a basic note

  Background:
    Given there is an article
    And I am logged in
    And I am viewing the article

  Scenario: Creating a note for the article
    When I click the "New note" link
    And I fill in the "Front" field with "Front of my note"
    And I fill in the "Back" field with "Back of my note"
    And I click the "Create Basic note" button
    Then I should see "Front of my note" in a basic note
    And I should see "Edit" in a basic note

  Scenario: Error messages when trying to create an invalid note
    When I click the "New note" link
    And I click the "Create Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"
