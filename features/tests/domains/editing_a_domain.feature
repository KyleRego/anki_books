Feature: Editing domains

  Scenario: Editing a new domain
    Given the test user has a domain called "domain to edit"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "domain to edit" link
    And I click the "Manage domain" link
    And I click the "Edit domain" link
    And I fill in the "Title" field with "A new domain title"
    And I click the "Update Domain" button
    Then I should see "A new domain title"
