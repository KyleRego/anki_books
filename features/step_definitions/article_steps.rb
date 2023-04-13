# frozen_string_literal: true

Given "I am viewing an article" do
  @article = Article.create title: "Hello World"
  visit "/articles/1"
end

Then "I should be redirected to the editor for the article" do
  expect(current_path).to eq "/articles/#{@article.id}/edit"
end
