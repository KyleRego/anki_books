Feature: Updating a domain's child domains

  Scenario: Updating a domain's domains
    Given the test user has a domain called "Test domain 1"
    And the test user has a domain called "Test domain 2"
    And the test user has a domain called "Test domain 3"
    And the test user has a domain called "Test domain 4"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "Test domain 1" link
    And I click the "Manage domain" link
    And I check the child domain checkbox labeled "Test domain 2"
    And I check the child domain checkbox labeled "Test domain 3"
    And I click the "Update Child Domains" button
    Then the child domain checkbox labeled "Test domain 2" should be checked
    And the child domain checkbox labeled "Test domain 3" should be checked
    And the child domain checkbox labeled "Test domain 4" should not be checked
    And I click the "Domains" link
    And I click the "Test domain 2" link
    And I click the "Manage domain" link
    Then the parent domain checkbox labeled "Test domain 1" should be checked
