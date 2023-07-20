Feature: Adding books to domains

  Scenario: Adding a book to a domain
    Given the test user has a domain called "Test domain"
    And the test user has a book called "Test book"
    And I am logged in as the test user
    And I click the "My books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I check the checkbox labeled "Test domain"
    And I click the "Update Domains" button
    And I click the "My domains" link
    And I click the "Test domain" link
    Then I should see "Test book"

  Scenario: Removing a book from a domain
    Given the test user has a domain called "domain"
    And the test user has a book called "Test book 1"
    And the book "Test book 1" belongs to the "domain" domain
    And I am logged in as the test user
    And I click the "My books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I uncheck the checkbox labeled "domain"
    And I click the "Update Domains" button
    And I click the "My domains" link
    And I click the "domain" link
    Then I should not see "Test book 1"
