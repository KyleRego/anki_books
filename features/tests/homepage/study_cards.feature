@javascript
Feature: Studying the cards of the homepage

  Scenario: Visiting the homepage when it has a basic note not logged in
    When the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    Then I should not see "Edit"

  Scenario: Visiting the homepage when it has a basic note logged in as the homepage article's user
    Given the test user has a book called "Book with system article"
    And the homepage belongs to the book "Book with system article"
    And I am logged in as the test user
    And the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    And I click on the span with text "First card"
    Then I should see "Edit"
    And I click the "Back to article" link
    And I click the "Study cards" link
    And I click on the span with text "Random order"
    Then I should see "Edit"

  Scenario: Visiting the homepage when it has a basic note logged in as a random user
    Given the homepage belongs to the book "Book with system article"
    And I am logged in as the test user
    And the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    And I click on the span with text "First card"
    Then I should not see "Edit"
    And I click the "Back to article" link
    And I click the "Study cards" link
    And I click on the span with text "Random order"
    Then I should not see "Edit"
