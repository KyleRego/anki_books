Feature: Adding books to book groups

  Scenario: Adding a book to a book group
    Given the test user has a book group called "Test book group"
    And the test user has a book called "Test book"
    And I am logged in as the test user
    And I click the "My books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I check the checkbox labeled "Test book group"
    And I click the "Update book groups" button
    And I click the "My book groups" link
    And I click the "Test book group" link
    Then I should see "Test book"

  Scenario: Removing a book from a book group
    Given the test user has a book group called "Book group"
    And the test user has a book called "Test book 1"
    And the book "Test book 1" belongs to the "Book group" book group
    And I am logged in as the test user
    And I click the "My books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I uncheck the checkbox labeled "Book group"
    And I click the "Update book groups" button
    And I click the "My book groups" link
    And I click the "Book group" link
    Then I should not see "Test book 1"
