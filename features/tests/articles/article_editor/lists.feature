@javascript
Feature: Adding lists when editing an article

  Background:
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am editing the article "test article 0"

  Scenario: Adding an unordered list 
    When I click the "Bullets" button
    And I fill in the article editor with "my bullet point"
    And I click the "Update Article" button
    Then I should see an unordered list with the list item "my bullet point"

  Scenario: Adding an ordered list
    When I click the "Numbers" button
    And I fill in the article editor with "my first numbered bullet point"
    And I click the "Update Article" button
    Then I should see an ordered list with the list item "my first numbered bullet point"

  Scenario: Adding an unordered list with nested list items
    When I click the "Bullets" button
    And I fill in the article editor with "hello"
    And I press the Enter key while the article editor is focused
    And I press the Tab key while the article editor is focused
    And I fill in the article editor with "world"
    Then I should see a nested list element with text "world" under the list element with text "hello"
