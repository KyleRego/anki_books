@javascript
Feature: Creating basic notes at different ordinal positions

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in
    And I am viewing the article

  Scenario: Adding a note between the first and second
    When I click the 2nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then the article's basic note with front "test insert note" should be at ordinal position "1"
    And I should see the 2nd basic note of the article has front "test insert note"
    And the article's basic note with front "Front of note 1" should be at ordinal position "2"
    And I should see the 3rd basic note of the article has front "Front of note 1"

  Scenario: Adding a note between the second and third
    When I click the 3nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then screenshot
    Then the article's basic note with front "test insert note" should be at ordinal position "2"
    And I should see the 3rd basic note of the article has front "test insert note"
    And the article's basic note with front "Front of note 2" should be at ordinal position "3"
    And I should see the 4th basic note of the article has front "Front of note 2"

  Scenario: Adding a note after the third
    When I click the 4th link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    Then the article's basic note with front "test insert note" should be at ordinal position "3"
    And I should see the 4th basic note of the article has front "test insert note"
