@javascript
Feature: Using the undo and redo when editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Using the Undo button to un-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    Then I should not see "something to undo"

  Scenario: Using the Redo button to re-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    And I click the "Redo" button
    Then I should see "something to undo"

  Scenario: Using the keyboard shortcut to un-do something
    When I fill in the article editor with "something to undo"
    And I use the ctrl + "z" keyboard shortcut
    Then I should not see "something to undo"

  Scenario: Using the keyboard shortcut to re-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    And I use the ctrl + "y" keyboard shortcut
    Then I should see "something to undo"
