Feature: Moving an article to a different book

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And there is a book titled "test book 2" with an article titled "test article 2" that has "2" basic note(s)
    And I am logged in
    And I click the "My books" link
    And I click the "test book 1" link
    And I click the "Manage articles" link
    And I click the "Manage test article 1" link

  @javascript
  Scenario: Moving an article from one book to a different book
    When I choose "test book 2" from the "book_id" select
    And I click the "Move article" button
    Then I should see "Article moved to test book 2"
    When I click the "My books" link
    And I click the "test book 2" link
    Then screenshot
    Then I should see "test article 1"
