@javascript
Feature: Flash messages

  Scenario: Dismissing an alert flash message
    Given I visit the root path
    And there is a user with username "test_user", email "test@example.com", and password "123abc777www"
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "wrong_password"
    And I click the "Log in" button
    And I click the "Dismiss" button
    Then I should not see "Invalid email or password"

  Scenario: Dismissing a notice flash message
    Given I visit the root path
    And there is a user with username "test_user", email "test@example.com", and password "123abc777www"
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "123abc777www"
    And I click the "Log in" button
    And I click the "Dismiss" button
    Then I should not see "Logged in successfully"
