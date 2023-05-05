Feature: Flipping a basic note between front and back

  Background:
    Given there is an article with "5" basic note(s)
    And I am logged in
    And I am viewing the article

  Scenario: Reordering the basic notes with drag and drop
    When I drag the note at the ordinal position "0" to ordinal position "1"
    And I refresh the page
    Then I should see the note with front "Front of note 0" at ordinal position "3"
