Feature: Reading an article

  Background:
    Given there is an article

  Scenario: Clicking the Edit link if I am logged in
    When I am logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article

  Scenario: I should not see the Edit link if I am not logged in
    When I am viewing the article
    Then I should not see "Edit"

  Scenario: I should not see the Create Basic note form if I am not logged in
    When I am viewing the article
    Then I should not see an input with value "Create Basic note"

  Scenario: I should see the Create Basic note form if I am logged in
    When I am logged in
    And I am viewing the article
    Then I should see an input with value "Create Basic note"