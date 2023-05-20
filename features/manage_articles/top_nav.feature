Feature: The top nav links on the Manage articles page

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in
    And I am viewing the article
    And I click the "test book 1" link
    And I click the "Manage articles" link

  Scenario: There should be a link to the book but not a link to My books
    Then I should see "test book 1"
    And I should not see "My books"