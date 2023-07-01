Feature: Moving an article to a different book

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "3" basic note(s)
    And the test user has the test book "test book 2" with the test article "test article 2" that has "2" basic note(s)
    And I am logged in as the test user
    And I click the "My books" link
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Moving an article from one book to a different book
    When I choose "test book 2" from the "book_id" select
    And I click the "Move this article to a different book" button
    Then I should see "Article moved to test book 2"
    When I click the "My books" link
    And I click the "test book 2" link
    Then I should see "test article 1"
