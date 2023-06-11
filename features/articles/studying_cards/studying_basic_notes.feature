@javascript
Feature: Reading an article

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in
    And I am viewing the article
    And I click the "Study cards" link

  Scenario: I visit the Study cards page
    Then I should see "Back to article"
    And I should see "First card"
    And I should see "Random order"

  Scenario: The Study cards page should not have the Study cards link
    Then I should not see "Study cards"

  Scenario: Studying in normal order should adjust the spans
    When I click on the span with text "First card"
    Then I should not see "First card"
    And I should not see "Random order"
    And I should see "Previous card"
    And I should see "Next card"

  Scenario: Studying in random order should adjust the spans
  Then screenshot
    When I click on the span with text "Random order"
    Then I should not see "First card"
    And I should not see "Random order"
    And I should see "Previous card"
    And I should see "Next card"

  Scenario: Clicking the card should reveal the back of the card
    When I click on the span with text "First card"
    And I click on the span with text "Front of note 0"
    Then I should see "Back of note 0"
    And I should not see "New note"

  Scenario: Clicking the First card span followed by Next card should show me the cards in order looping to the first card
    When I click on the span with text "First card"
    Then I should see "Front of note 0"
    When I click on the span with text "Next card"
    Then I should see "Front of note 1"
    When I click on the span with text "Next card"
    Then I should see "Front of note 2"
    When I click on the span with text "Next card"
    Then I should see "Front of note 0"
    When I click on the span with text "Next card"
    Then I should see "Front of note 1"

  Scenario: Clicking the First card span followed by Previous card should show me the cards in reverse order looping back to the first
    When I click on the span with text "First card"
    Then I should see "Front of note 0"
    When I click on the span with text "Previous card"
    Then I should see "Front of note 2"
    When I click on the span with text "Previous card"
    Then I should see "Front of note 1"
    When I click on the span with text "Previous card"
    Then I should see "Front of note 0"
    When I click on the span with text "Previous"
    Then I should see "Front of note 2"
