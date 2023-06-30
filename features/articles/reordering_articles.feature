@javascript
Feature: Reordering the articles of a book

  Background:
    Given I have a book with the title "Reordering test book" and 5 numbered articles
    And I am logged in as the test user
    When I visit the root path
    And I click the "My books" link
    And I click the "Reordering test book" link
    And I click the "Manage Reordering test book" link

  Scenario: Dragging an article up
    When I drag the article with title "Article 0" to below the article with title "Article 2"
    Then the title of the article at position 0 should be "Article 1"

  Scenario: Dragging an article down
    When I drag the article with title "Article 4" to below the article with title "Article 0"
    Then the title of the article at position 1 should be "Article 4"

  Scenario: A sequence of many article repositions
    When I drag the article with title "Article 0" to below the article with title "Article 1"
    When I drag the article with title "Article 2" to below the article with title "Article 3"
    When I drag the article with title "Article 4" to below the article with title "Article 0"
    When I drag the article with title "Article 0" to below the article with title "Article 2"
    When I drag the article with title "Article 1" to below the article with title "Article 2"
    Then the title of the article at position 0 should be "Article 4"
    Then the title of the article at position 1 should be "Article 3"
    Then the title of the article at position 2 should be "Article 2"
    Then the title of the article at position 3 should be "Article 1"
    Then the title of the article at position 4 should be "Article 0"
