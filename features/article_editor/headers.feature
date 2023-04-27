Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: The article editor toolbar should show 6 header buttons
    Then I should see "H1"
    And I should see "H2"
    And I should see "H3"
    And I should see "H4"
    And I should see "H5"
    And I should see "H6"

  Scenario: Using the headers button group to add an H1 main heading
    When I click the "H1" button
    And I fill in the article editor with "My H1 heading"
    And I click the "Update Article" button
    Then I should see a "H1" heading with the text "My H1 heading"

  Scenario: Using the headers button group to add an H2 subheading
    When I fill in the article editor with "My H3 heading"
    And I click the "H2" button
    And I click the "Update Article" button
    Then I should see a "H2" heading with the text "My H3 heading"

  Scenario: Using the headers button group to add an H3 subheading
    When I fill in the article editor with "My H3 heading"
    And I click the "H3" button
    And I click the "Update Article" button
    Then I should see a "H3" heading with the text "My H3 heading"

  Scenario: Using the headers button group to add an H4 subheading
    When I fill in the article editor with "My H4 heading"
    And I click the "H4" button
    And I click the "Update Article" button
    Then I should see a "H4" heading with the text "My H4 heading"

  Scenario: Using the headers button group to add an H5 subheading
    When I fill in the article editor with "My H5 heading"
    And I click the "H5" button
    And I click the "Update Article" button
    Then I should see a "H5" heading with the text "My H5 heading"

  Scenario: Using the headers button group to add an H6 subheading
    When I fill in the article editor with "My H6 heading"
    And I click the "H6" button
    And I click the "Update Article" button
    Then I should see a "H6" heading with the text "My H6 heading"

  Scenario: Using one of the subheading buttons disables the other subheading buttons
    When I click the "H3" button
    Then the "H4" button should be disabled
