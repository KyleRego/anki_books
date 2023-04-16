Feature: Editing an article

  Background:
    Given there is an article
    And I am editing the article

  Scenario: Adding plain text to the article and saving it
    When I fill in the article editor with "some plain text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some plain text"

  Scenario: Adding bold text to the article and saving it
    When I click the "Bold" button
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some bold text" in bold

  Scenario: Adding italic text to the article and saving it
    When I click the "Italic" button
    And I fill in the article editor with "some italic text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some italic text" in italics

  Scenario: Adding strikethrough text to the article and saving it
    When I click the "Strikethrough" button
    And I fill in the article editor with "some strikethrough text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some strikethrough text" with a strikethrough

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