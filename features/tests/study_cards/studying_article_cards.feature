# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Reading an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
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
    When I click on the span with text "Random order"
    Then I should not see "First card"
    And I should not see "Random order"
    And I should see "Previous card"
    And I should see "Next card"

  Scenario: Clicking the card should reveal the back of the card
    When I click on the span with text "First card"
    And I click on the span with text "Front of note 0"
    Then I should see "Back of note 0"
    And I should not see "New basic note"

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

  Scenario: Using the link back to the article should load the article correctly
    When I click the "Back to article" link
    Then I should see "Front of note 0"
