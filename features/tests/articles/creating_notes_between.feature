# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Creating basic notes at different ordinal positions

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"

  Scenario: Adding a note between the first and second
    When I click the 2nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then the article's basic note with front "test insert note" should be at ordinal position "1"
    And I should see the 2nd basic note of the article has front "test insert note"
    And the article's basic note with front "Front of note 1" should be at ordinal position "2"
    And I should see the 3rd basic note of the article has front "Front of note 1"
    And I should see 5 links with the text "New note"

  Scenario: Adding two notes next to each other
    When I click the 2nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I click the 3rd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then I should see 6 links with the text "New note"

  Scenario: Adding a note between the second and third
    When I click the 3nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then the article's basic note with front "test insert note" should be at ordinal position "2"
    And I should see the 3rd basic note of the article has front "test insert note"
    And the article's basic note with front "Front of note 2" should be at ordinal position "3"
    And I should see the 4th basic note of the article has front "Front of note 2"
    And I should see 5 links with the text "New note"

  Scenario: Adding a note after the third
    When I click the 4th link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then the article's basic note with front "test insert note" should be at ordinal position "3"
    And I should see the 4th basic note of the article has front "test insert note"
    And I should see 5 links with the text "New note"
