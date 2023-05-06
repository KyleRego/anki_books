Feature: Reading an article

  Background:
    Given there is an article with "3" basic note(s)
    And I am viewing the article
    And I click the "Study cards" link

  Scenario: I visit the Study cards page
    Then I should see "Back to article"
    And I should see "First card"
    And I should see "Random card"

  Scenario: Clicking the First card option should replace it with Next card
    When I click on the span with text "First card"
    Then I should not see "First card"
    And I should see "Next card"

  Scenario: Clicking the Random card option should replace the First card option with Next card
    When I click on the span with text "Random card"
    Then I should not see "First card"
    And I should see "Next card"

  Scenario: Clicking the card should reveal the back of the card
    When I click on the span with text "First card"
    And I click on the span with text "Front of note 0"
    Then I should see "Back of note 0"

  Scenario: Clicking the First card option followed by Next card should show me the cards in order looping to the first card
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

  Scenario: Clicking the Random card option should always show one of the other cards
    When I click on the span with text "First card"
    And I click on the span with text "Random card"
    Then I should not see "Front of note 0"
    When I refresh the page
    And I click on the span with text "First card"
    And I click on the span with text "Random card"
    Then I should not see "Front of note 0"
    When I refresh the page
    And I click on the span with text "First card"
    And I click on the span with text "Random card"
    Then I should not see "Front of note 0"
