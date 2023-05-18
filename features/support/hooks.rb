# frozen_string_literal: true

Before do
  @system_book = Book.create! title: "System book"
  @system_article = Article.create! title: "Hello World", system: true, book: @system_book
  @system_article.content = "This is the system article to serve as the homepage."
  @system_article.save
end
