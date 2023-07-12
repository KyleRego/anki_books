@javascript
Feature: Adding quotes when editing an article

  Background:
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am editing the article "test article 0"

  Scenario: Adding a quote to the article using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Update Article" button
    Then I should see "Great power comes with..." as a quote

  Scenario: Adding a quote to the article and then removing it using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Update Article" button
    And I click the "Edit" link
    And I click the "Quote" button
    And I click the "Update Article" button
    Then I should see "Great power comes with..." but not as a quote
