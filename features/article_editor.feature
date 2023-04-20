Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Adding plain text to the article and saving it
    When I fill in the article editor with "some plain text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "Article updated successfully."
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

  Scenario: Adding a quote to the article using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Update Article" button
    Then I should see "Great power comes with..." as a quote

  Scenario: Adding a quote to the article and then removing it using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Update Article" button
    And I click the "Edit" link
    And I click the "Quote" button
    And I click the "Update Article" button
    Then I should see "Great power comes with..." but not as a quote

  Scenario: Adding a code block with the "Code" button
    When I click the "Code" button
    And I fill in the article editor with '#include<iostream>;int main(){std::cout<<"Hello, world!";}'
    And I click the "Update Article" button
    And I refresh the page
    Then I should see a code block with syntax highlighting

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
