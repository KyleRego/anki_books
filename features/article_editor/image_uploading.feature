Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Uploading an image
    When I drop the fixture image "test_image.png" on the article editor
    Then I should see the fixture image "test_image.png" on the page

  Scenario: Uploading and then removing an image
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the image "test_image.png" on the page
    And I click the "Remove" button
    Then I should not see the image "test_image.png" on the page

  Scenario: Uploading an image should show the filename as the image caption
    When I drop the fixture image "test_image.png" on the article editor
    Then I should see "test_image.png"

  Scenario: Clicking on the default filename image caption should change it to show: Add a caption…
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the span with text "test_image.png"
    Then I should see the textarea placeholder "Add a caption…"

  Scenario: Editing the caption of the uploaded image
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the span with text "test_image.png"
    And I type "this is my caption" on the focused element
    And I click the "Update Article" button
    Then I should see "this is my caption"
