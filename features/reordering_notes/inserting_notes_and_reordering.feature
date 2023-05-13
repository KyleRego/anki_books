@javascript
Feature: Flipping a basic note between front and back

  Scenario: Adding a new note at the top and then reordering it
    Given there is an article with "1" basic note(s)
    And I am logged in
    And I am viewing the article
    When I click the 1st link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "0" to the dropzone at position "1"
    Then the front of the note at position "1" should be "test insert note"

  Scenario: Adding a new note at the bottom and then reordering it
    Given there is an article with "2" basic note(s)
    And I am logged in
    And I am viewing the article
    When I click the 3rd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "2" to the dropzone at position "0"
    And I drag the note at position "0" to the dropzone at position "1"
    Then the front of the note at position "0" should be "test insert note"

  Scenario: Adding a new note in the middle and then reordering it
    Given there is an article with "2" basic note(s)
    And I am logged in
    And I am viewing the article
    When I click the 2nd link with text "New note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "0" to the dropzone at position "1"
    Then I should not see two adjacent New note links
    And the front of the note at position "1" should be "Front of note 0"
