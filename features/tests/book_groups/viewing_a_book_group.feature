Feature: Viewing book groups

  Scenario: Viewing a new book group
    Given the test user has a book group called "Book group 1"
    And the test user has a book called "Book 1 of group 1"
    And the test user has a book called "Book 2 of group 1"
    And the book "Book 1 of group 1" belongs to the "Book group 1" book group
    And the book "Book 2 of group 1" belongs to the "Book group 1" book group
    And the test user has a book group called "Book group 2"
    And the test user has a book called "Book 1 of group 2"
    And the book "Book 1 of group 2" belongs to the "Book group 2" book group
    And the test user has a book group called "Book group 3"
    And I am logged in as the test user
    And I click the "My book groups" link
    Then I should see "Book group 1"
    And I should see "Book group 2"
    And I should see "Book group 3"
    And I click the "Book group 1" link
    Then I should see "Book 1 of group 1"
    And I should see "Book 2 of group 1"
    And I should not see "Book 1 of group 2"
