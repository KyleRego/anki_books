Feature: Displaying the back of the basic note

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 1 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"

  Scenario: Not seeing the back of the note before it's clicked
    Then I should see "What kind of note is this note?"
    And I should not see "This is a Basic note."

  @javascript
  Scenario: Clicking the note to reveal the back
    When I click on the span with text "What kind of note is this note?"
    Then I should see "This is a Basic note."
