@javascript
Feature: Reordering basic notes

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "5" basic note(s)
    And I am logged in
    And I am viewing the article

  Scenario: Reordering one basic note with drag and drop
    When I drag the note at position "0" to the dropzone at position "3"
    Then the front of the note at position "3" should be "Front of note 0"
    When I refresh the page
    Then the front of the note at position "3" should be "Front of note 0"

  Scenario: Reordering notes several times to reverse the original order
    When I drag the note at position "4" to the dropzone at position "0"
    And I drag the note at position "0" to the dropzone at position "1"
    And I drag the note at position "4" to the dropzone at position "0"
    And I drag the note at position "4" to the dropzone at position "1"
    And I drag the note at position "3" to the dropzone at position "4"
    Then the front of the note at position "0" should be "Front of note 4"
    And the front of the note at position "1" should be "Front of note 3"
    And the front of the note at position "2" should be "Front of note 2"
    And the front of the note at position "3" should be "Front of note 1"
    And the front of the note at position "4" should be "Front of note 0"
