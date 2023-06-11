@javascript
Feature: Creating a basic note

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "1" basic note(s)
    And I am logged in
    And I am viewing the article

  Scenario: Editing the note and updating it
    When I click "Edit" on the basic note
    And I fill in the basic note edit form with the following data:
      | Field  | Value       |
      | Front  | Front Value |
      | Back   | Basic Value |
    And I click the "Update Basic note" button

  Scenario: Error messages when trying to update the note to be invalid
    When I click "Edit" on the basic note
    And I fill in the basic note edit form with the following data:
    | Field   | Value |
    | Front   |       |
    | Back    |       |
    And I click the "Update Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"
