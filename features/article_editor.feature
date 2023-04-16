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

  Scenario: Using the headers button group to add an H1 main heading
    When I click the "Headers" button
    And I click the "H1" button
    And I fill in the article editor with "My H1 heading"
    And I click the "Update Article" button
    Then I should see a "H1" heading with the text "My H1 heading"

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
