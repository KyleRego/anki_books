Feature: User authentication

  Background:
    Given I visit the root path
    And there is a user with username "test_user", email "test@example.com", and password "123abc777www"

  Scenario: Logging in with valid credentials
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "123abc777www"
    And I click the "Log in" button
    Then I should see "Logged in successfully."

  Scenario: Logging in with invalid credentials
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "123456789abc"
    And I click the "Log in" button
    Then I should see "Invalid email or password."

  Scenario: Logging out
    When I click the "Login" link
    And I fill in the "Email" field with "test@example.com"
    And I fill in the "Password" field with "123abc777www"
    And I click the "Log in" button
    And I click the "Logout" link
    Then I should see "Logged out successfully."

  Scenario: Navigating from the homepage to the login page and back
    When I click the "Login" link
    When I click the "Home" link
    Then I should see the homepage