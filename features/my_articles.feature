Feature: The My articles page

  Scenario: The My articles link should not show if I am not logged in
    When I visit the root path
    Then I should not see "My articles"

  Scenario: The My articles link should show if I am logged in
    Given I am logged in
    When I visit the root path
    Then I should see "My articles"

  Scenario: The My articles link should not show if I am on the My articles page
    Given I am logged in
    When I visit the root path
    And I click the "My articles" link
    Then I should not see "My articles"

  Scenario: The My articles page should show the Home link
    Given I am logged in
    When I visit the root path
    And I click the "My articles" link
    Then I should see "Home"

  Scenario: The My articles page should show the Logout link
    Given I am logged in
    When I visit the root path
    And I click the "My articles" link
    Then I should see "Logout"

  Scenario: Creating a new article
    Given I am logged in
    When I visit the root path
    And I click the "My articles" link
    And I click the "Create new" button
    And I fill in the article editor with "content of a new article"
    And I click the "Update Article" button
    And I click the "My articles" link
    And I click the "My new article" link
    Then I should see "content of a new article"
