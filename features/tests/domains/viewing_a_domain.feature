Feature: Viewing domains

  Scenario: Viewing a new domain
    Given the test user has a domain called "domain 1"
    And the test user has a book called "Book 1 of group 1"
    And the test user has a book called "Book 2 of group 1"
    And the book "Book 1 of group 1" belongs to the "domain 1" domain
    And the book "Book 2 of group 1" belongs to the "domain 1" domain
    And the test user has a domain called "domain 2"
    And the test user has a book called "Book 1 of group 2"
    And the book "Book 1 of group 2" belongs to the "domain 2" domain
    And the test user has a domain called "domain 3"
    And I am logged in as the test user
    And I click the "Domains" link
    Then I should see "domain 1"
    And I should see "domain 2"
    And I should see "domain 3"
    And I click the "domain 1" link
    Then the checkbox labeled "Book 1 of group 1" should be checked
    And the checkbox labeled "Book 2 of group 1" should be checked
    And the checkbox labeled "Book 1 of group 2" should not be checked