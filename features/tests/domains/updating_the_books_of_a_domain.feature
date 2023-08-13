Feature: Updating a domain's books

  Scenario: Updating a domain's books
    Given the test user has a domain called "Test domain"
    And the test user has a book called "Test book 1"
    And the test user has a book called "Test book 2"
    And the test user has a book called "Test book 3"
    And the test user has a book called "Test book 4"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "Test domain" link
    And I click the "Manage domain" link
    And I check the checkbox labeled "Test book 1"
    And I check the checkbox labeled "Test book 4"
    And I click the "Update Books" button
    Then the checkbox labeled "Test book 1" should be checked
    And the checkbox labeled "Test book 2" should not be checked
    And the checkbox labeled "Test book 3" should not be checked
    And the checkbox labeled "Test book 4" should be checked
    And I click the "Books" link
    And I click the "Test book 1" link
    And I click the "Manage book" link
    Then the checkbox labeled "Test domain" should be checked
