Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Uploading an image
    When I drop the fixture image "test_image.png" on the article editor
    Then I should see the fixture image "test_image.png" on the page
