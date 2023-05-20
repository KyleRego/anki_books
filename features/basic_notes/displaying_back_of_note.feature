Feature: Displaying the back of the basic note

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "1" basic note(s)
    And I am logged in
    And I am viewing the article

  Scenario: Not seeing the back of the note before it's clicked
    Then I should see "What kind of note is this note?"
    And I should not see "This is a Basic note."

  @javascript
  Scenario: Clicking the note to reveal the back
    When I click on the span with text "What kind of note is this note?"
    Then I should see "This is a Basic note."
