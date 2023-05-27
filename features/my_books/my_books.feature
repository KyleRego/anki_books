Feature: The My books page

  Scenario: The My books link should not show if I am not logged in
    When I visit the root path
    Then I should not see "My books"

  Scenario: The My books link should show if I am logged in
    Given I am logged in
    When I visit the root path
    Then I should see "My books"

  Scenario: The My books link should not show if I am on the My books page
    Given I am logged in
    When I visit the root path
    And I click the "My books" link
    Then I should see "My books"
    And I should not see a "My books" link

  Scenario: The My books page should show the Home link
    Given I am logged in
    When I visit the root path
    And I click the "My books" link
    Then I should see "Home"

  Scenario: The My books page should show the Logout link
    Given I am logged in
    When I visit the root path
    And I click the "My books" link
    Then I should see "Logout"
