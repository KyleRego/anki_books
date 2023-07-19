# frozen_string_literal: true

Given "the test user has a domain called {string}" do |book_title|
  create(:domain, title: book_title, user: @test_user)
end

Given "the book {string} belongs to the {string} domain" do |book_title, domain_title|
  book = Book.find_by(title: book_title)
  domain = Domain.find_by(title: domain_title)
  domain.books << book
end
