Feature: Viewing root domains

  Scenario: Setting a domain to be a child domain and then viewing the root domains
    Given the test user has a domain called "domain 1"
    And the test user has a domain called "domain 2"
    And the test user has a domain called "domain 3"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "domain 1" link
    And I click the "Manage domain" link
    And I check the child domain checkbox labeled "domain 2"
    And I click the "Update Child Domains" button
    And I click the "Root domains" link
    Then I should see "domain 1"
    And I should not see "domain 2"
    And I should see "domain 3"
