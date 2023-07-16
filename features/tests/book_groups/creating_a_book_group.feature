Feature: Creating book groups

  Scenario: Creating a new book group
    Given I am logged in as the test user
    And I click the "My book groups" link
    And I click the "New book group" link
    When I fill in the "Title" field with "A new book group title"
    And I click the "Create Book group" button
    Then I should see "A new book group title"
