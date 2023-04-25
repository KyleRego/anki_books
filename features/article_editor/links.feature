Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Clicking the Link button 
    When I click the "Link" button
    Then I should see a "Enter a URL…" placeholder

  Scenario: Adding a link to the article without selecting text first
    When I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I click the "Update Article" button
    Then I should see the text "https://kylerego.github.io" linking to "https://kylerego.github.io"

  Scenario: Adding a link after selecting some text
    When I fill in the article editor with "this is my link"
    And I select the text in the article editor
    And I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I click the "Update Article" button
    Then I should see the text "this is my link" linking to "https://kylerego.github.io"

  Scenario: Selecting a link and making it not a link
    When I fill in the article editor with "this is my link"
    And I select the text in the article editor
    And I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I select the text in the article editor
    And I click the "Link" button
    And I click the URL form "Unlink" button
    Then I should see the text "this is my link" but it should not be a link