@javascript
Feature: Reordering basic notes

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 5 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"

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
