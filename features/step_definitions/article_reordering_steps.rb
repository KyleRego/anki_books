# frozen_string_literal: true

Then "I should not see two adjacent New note links" do
  expect(page.text).not_to include "New note\nNew note"
end

When "I drag the article with title {string} to below the article with title {string}" do |string, string2|
  dragged_article = page.find("[draggable=\"true\"]", text: string)

  article_above_dropzone = page.find("[draggable=\"true\"]", text: string2)
  dropzone = article_above_dropzone
             .ancestor("div.reorderable-unit")
             .find("[data-reorder-articles--article-dropzone-target=\"dropzone\"]")
  dragged_article.drag_to(dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the title of the article at position {int} should be {string}" do |int, string|
  all_articles = page.all("[draggable=\"true\"]")
  expect(all_articles[int].text).to eq string
end
