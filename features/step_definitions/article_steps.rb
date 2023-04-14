# frozen_string_literal: true

Given "there is an article" do
  @article = Article.create! title: "Hello World"
  binding.pry
end

Given "I am viewing an article" do
  visit article_path @article
end

Given "I am editing an article" do
  visit edit_article_path @article
end

When "I fill in the article editor with {string}" do |text|
  editor = find(".trix-content")
  editor.click
  editor.set(text)
end

And "I click the Update Article button" do
  click_button "Update Article"
end

Then "I should be redirected to the article" do
  expect(current_path).to eq article_path @article
end

Then "I should be redirected to the editor for the article" do
  expect(current_path).to eq edit_article_path @article
end
