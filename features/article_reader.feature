Feature: Reading an article

  Background:
    Given there is an article with a basic note

  Scenario: Clicking the Edit link if I am logged in
    And I am logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article

  Scenario: Clicking the Edit link if I am not logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should see "You must be logged in to access this page."

  Scenario: An article with a basic note
    When I am logged in
    And I am viewing the article
    Then I should see "What kind of note is this note?"
    And I should see "This is a Basic note."
 