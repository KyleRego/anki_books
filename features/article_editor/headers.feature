Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Clicking the Headers button to display the headers button group
    When I click the "Headers" button
    Then I should see "H1"
    And I should see "H2"
    And I should see "H3"
    And I should see "H4"
    And I should see "H5"
    And I should see "H6"

  Scenario: Clicking the Headers button to hide the headers button group
    When I click the "Headers" button
    And I click the "Headers" button
    Then I should not see "H1"
    And I should not see "H2"
    And I should not see "H3"
    And I should not see "H4"
    And I should not see "H5"
    And I should not see "H6"

  Scenario: The Headers button should load correctly when the article starts with a header
    When I click the "Headers" button
    And I click the "H1" button
    And I fill in the article editor with "A heading"
    And I click the "Update Article" button
    And I click the "Edit" link
    Then I should see the Headers button is not active

  Scenario: Using the headers button group to add an H1 main heading
    When I click the "Headers" button
    And I click the "H1" button
    And I fill in the article editor with "My H1 heading"
    And I click the "Update Article" button
    Then I should see a "H1" heading with the text "My H1 heading"

  Scenario: Using the headers button group to add an H2 subheading
    When I click the "Headers" button
    And I fill in the article editor with "My H3 heading"
    And I click the "H2" button
    And I click the "Update Article" button
    Then I should see a "H2" heading with the text "My H3 heading"

  Scenario: Using the headers button group to add an H3 subheading
    When I click the "Headers" button
    And I fill in the article editor with "My H3 heading"
    And I click the "H3" button
    And I click the "Update Article" button
    Then I should see a "H3" heading with the text "My H3 heading"

  Scenario: Using the headers button group to add an H4 subheading
    When I click the "Headers" button
    And I fill in the article editor with "My H4 heading"
    And I click the "H4" button
    And I click the "Update Article" button
    Then I should see a "H4" heading with the text "My H4 heading"

  Scenario: Using the headers button group to add an H5 subheading
    When I click the "Headers" button
    And I fill in the article editor with "My H5 heading"
    And I click the "H5" button
    And I click the "Update Article" button
    Then I should see a "H5" heading with the text "My H5 heading"

  Scenario: Using the headers button group to add an H6 subheading
    When I click the "Headers" button
    And I fill in the article editor with "My H6 heading"
    And I click the "H6" button
    And I click the "Update Article" button
    Then I should see a "H6" heading with the text "My H6 heading"

  Scenario: Using one of the subheading buttons disables the other subheading buttons
    When I click the "Headers" button
    And I click the "H3" button
    Then the "H4" button should be disabled