Feature: Studying the basic notes of a book

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 10 basic notes
    And the book "test book 1" has an article called "test article 2"
    And the article "test article 2" has 10 basic notes
    And I am logged in as the test user
    And I visit the root path
    And I click the "My books" link
    And I click the "test book 1" link

  Scenario: Visiting the book study cards page and then using the link back to the book
    When I click the "Study cards" link
    Then I should not see "test book 1"
    And I click the "Back to book" link
    Then I should see "test book 1"
