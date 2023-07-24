Feature: Creating domains

  Scenario: Creating a new domain
    Given I am logged in as the test user
    And I click the "Domains" link
    And I click the "New domain" link
    When I fill in the "Title" field with "A new domain title"
    And I click the "Create Domain" button
    Then I should see "A new domain title"
