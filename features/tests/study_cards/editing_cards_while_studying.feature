# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Editing/updating basic notes from the study cards page

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    And I click the "Study cards" link

  Scenario: Editing a basic note after studying in random order
    When I click on the span with text "Random order"
    When I click the "Edit" link
    And I fill in the study cards basic note edit form with the following data:
      | Field  | Value       |
      | Front  | Front Value |
      | Back   | Basic Value |
    And I click the "Update Basic note" button
    Then I should see "Front Value"
    And I should see "Next card"
    And I should not see "New"

  Scenario: Editing a basic note after studying in normal order
    When I click on the span with text "First card"
    When I click the "Edit" link
    And I fill in the study cards basic note edit form with the following data:
      | Field  | Value       |
      | Front  | Front Value |
      | Back   | Basic Value |
    And I click the "Update Basic note" button
    Then I should see "Front Value"
    And I should see "Next card"
