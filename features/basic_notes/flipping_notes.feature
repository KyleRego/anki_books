Feature: Flipping a basic note between front and back

  Background:
    Given there is an article with a basic note
    And I am logged in
    And I am viewing the article

  Scenario: Flipping the note from front to back
    When I click on the span with text "What kind of note is this note?"
    Then I should see "This is a Basic note."

  Scenario: Flipping the note from front to back to front
    When I click on the span with text "What kind of note is this note?"
    And I click on the span with text "This is a Basic note."
    Then I should see "What kind of note is this note?"
