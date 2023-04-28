Feature: Flash messages

  Scenario: Dismissing an alert flash message
    Given there is an article
    And I am viewing the article
    When I click the "Edit" link
    And I click the "Dismiss" button
    Then I should not see "You must be logged in to access this page."

  Scenario: Dismissing a notice flash message
    Given I visit the root path
    And there is a user with username "test_user", email "test@example.com", and password "123abc777www"
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "123abc777www"
    And I click the "Log in" button
    And I click the "Dismiss" button
    Then screenshot
    Then I should not see "Logged in successfully"