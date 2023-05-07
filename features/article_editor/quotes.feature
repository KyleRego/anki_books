@javascript
Feature: Adding quotes when editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

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