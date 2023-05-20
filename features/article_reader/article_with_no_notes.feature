Feature: Reading an article

  Background:
    Given there is a book titled "test book 0" with an article titled "test article 0"

  Scenario: Clicking the Edit link if I am logged in
    When I am logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article

  Scenario: I should not see the Edit link if I am not logged in
    When I am viewing the article
    Then I should not see "Edit"

  Scenario: I should not see the New note link if I am not logged in
    When I am viewing the article
    Then I should not see "New note"

  @javascript
  Scenario: I should see the Create Basic note form if I am logged in
    When I am logged in
    And I am viewing the article
    Then I should see "New note"
    When I click the "New note" link
    Then I should see an input with value "Create Basic note"

  Scenario: I should not see the Study cards link
    When I am logged in
    And I am viewing the article
    Then I should not see "Study cards"
