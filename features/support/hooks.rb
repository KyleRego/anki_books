# frozen_string_literal: true

Before do
  @system_article = Article.create! title: "Hello World", system: true
  @system_article.content = "This is the system article to serve as the homepage."
  @system_article.save
end
